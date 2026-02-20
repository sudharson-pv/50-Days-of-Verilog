package com.example.translate

import android.content.res.AssetManager

object WhisperBridge {

    init {
        System.loadLibrary("whisper_jni")
    }

    external fun initContext(modelPath: String): Int

    external fun transcribe(audioData: FloatArray): String

    external fun freeContext()

    fun getModelPath(assetManager: AssetManager, modelName: String): String {
        val asset = assetManager.open(modelName)
        val path = "${assetManager}/$modelName"
        asset.close()
        return path
    }
}
