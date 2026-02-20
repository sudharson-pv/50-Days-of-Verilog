package com.example.translate

import android.Manifest
import android.content.pm.PackageManager
import android.media.AudioFormat
import android.media.AudioRecord
import android.media.MediaRecorder
import android.os.Bundle
import android.speech.tts.TextToSpeech
import android.util.Log
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.google.android.material.switchmaterial.SwitchMaterial
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.io.File
import java.io.FileOutputStream
import java.nio.ByteBuffer
import java.nio.ByteOrder
import java.util.Locale

class MainActivity : AppCompatActivity(), TextToSpeech.OnInitListener {

    private lateinit var recordButton: Button
    private lateinit var originalTextView: TextView
    private lateinit var translatedTextView: TextView
    private lateinit var latencyTextView: TextView
    private lateinit var sttModeSwitch: SwitchMaterial

    private var isRecording = false
    private lateinit var audioRecord: AudioRecord
    private lateinit var tts: TextToSpeech

    private val coroutineScope = CoroutineScope(Dispatchers.IO)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        recordButton = findViewById(R.id.recordButton)
        originalTextView = findViewById(R.id.originalText)
        translatedTextView = findViewById(R.id.translatedText)
        latencyTextView = findViewById(R.id.latencyText)
        sttModeSwitch = findViewById(R.id.sttModeSwitch)

        tts = TextToSpeech(this, this)

        if (ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.RECORD_AUDIO), 1)
        }

        recordButton.setOnClickListener {
            if (isRecording) {
                stopRecording()
            } else {
                startRecording()
            }
        }

        // Initialize Whisper context
        coroutineScope.launch {
            val modelPath = WhisperBridge.getModelPath(assets, "ggml-tiny.en.bin")
            val result = WhisperBridge.initContext(modelPath)
            if (result != 0) {
                Log.e("MainActivity", "Failed to initialize Whisper context")
            }
        }
    }

    private fun startRecording() {
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
            return
        }
        val sampleRate = 16000
        val channelConfig = AudioFormat.CHANNEL_IN_MONO
        val audioFormat = AudioFormat.ENCODING_PCM_16BIT
        val bufferSize = AudioRecord.getMinBufferSize(sampleRate, channelConfig, audioFormat)

        audioRecord = AudioRecord(MediaRecorder.AudioSource.MIC, sampleRate, channelConfig, audioFormat, bufferSize)

        isRecording = true
        recordButton.text = "Stop Recording"

        coroutineScope.launch {
            val audioFile = File(cacheDir, "recording.pcm")
            val outputStream = FileOutputStream(audioFile)
            val audioBuffer = ByteArray(bufferSize)

            audioRecord.startRecording()

            while (isRecording) {
                val read = audioRecord.read(audioBuffer, 0, audioBuffer.size)
                if (read > 0) {
                    outputStream.write(audioBuffer, 0, read)
                }
            }

            outputStream.close()
            audioRecord.stop()
            audioRecord.release()

            processAudio(audioFile)
        }
    }

    private fun stopRecording() {
        isRecording = false
        recordButton.text = "Record"
    }

    private fun processAudio(audioFile: File) {
        val startTime = System.currentTimeMillis()

        coroutineScope.launch {
            val audioData = readAudioFile(audioFile)
            val originalText: String

            if (sttModeSwitch.isChecked) { // Whisper STT
                originalText = WhisperBridge.transcribe(audioData)
            } else { // Fallback: Android native STT (simulated)
                originalText = "(Native STT not implemented)" // Placeholder for native STT
            }

            val sttLatency = System.currentTimeMillis() - startTime

            // For this example, we'll just display the original text as the translation
            val translatedText = originalText
            val totalLatency = System.currentTimeMillis() - startTime

            withContext(Dispatchers.Main) {
                originalTextView.text = "Original: $originalText"
                translatedTextView.text = "Translated: $translatedText"
                latencyTextView.text = "STT Latency: ${sttLatency}ms, Total: ${totalLatency}ms"
                speak(translatedText)
            }
        }
    }

    private fun readAudioFile(file: File): FloatArray {
        val byteBuffer = ByteBuffer.wrap(file.readBytes()).order(ByteOrder.LITTLE_ENDIAN)
        val floatArray = FloatArray(byteBuffer.asShortBuffer().limit())
        for (i in floatArray.indices) {
            floatArray[i] = byteBuffer.asShortBuffer().get(i) / 32768.0f
        }
        return floatArray
    }

    private fun speak(text: String) {
        tts.speak(text, TextToSpeech.QUEUE_FLUSH, null, "")
    }

    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            val result = tts.setLanguage(Locale.US)
            if (result == TextToSpeech.LANG_MISSING_DATA || result == TextToSpeech.LANG_NOT_SUPPORTED) {
                Log.e("TTS", "The Language specified is not supported!")
            }
        } else {
            Log.e("TTS", "Initialization Failed!")
        }
    }

    override fun onDestroy() {
        WhisperBridge.freeContext()
        if (tts.isSpeaking) {
            tts.stop()
        }
        tts.shutdown()
        super.onDestroy()
    }
}
