#include <jni.h>
#include <string>
#include <android/log.h>
#include <vector>
#include "whisper.h"

#define LOG_TAG "whisper_jni"
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

static whisper_context *g_whisper_ctx = nullptr;

extern "C" JNIEXPORT jint JNICALL
Java_com_example_translate_WhisperBridge_initContext(JNIEnv *env, jobject /* this */, jstring model_path) {
    const char *path = env->GetStringUTFChars(model_path, nullptr);
    g_whisper_ctx = whisper_init_from_file(path);
    env->ReleaseStringUTFChars(model_path, path);

    if (g_whisper_ctx == nullptr) {
        LOGE("Failed to initialize whisper context");
        return -1;
    }

    return 0;
}

extern "C" JNIEXPORT jstring JNICALL
Java_com_example_translate_WhisperBridge_transcribe(JNIEnv *env, jobject /* this */, jfloatArray audio_data) {
    if (g_whisper_ctx == nullptr) {
        LOGE("Whisper context not initialized");
        return env->NewStringUTF("Error: Whisper context not initialized");
    }

    jsize len = env->GetArrayLength(audio_data);
    std::vector<float> pcmf32(len);
    env->GetFloatArrayRegion(audio_data, 0, len, pcmf32.data());

    whisper_full_params params = whisper_full_default_params(WHISPER_SAMPLING_GREEDY);
    params.n_threads = 2; // Max 2 threads as requested
    params.language = "en";

    if (whisper_full(g_whisper_ctx, params, pcmf32.data(), pcmf32.size()) != 0) {
        LOGE("Failed to process audio");
        return env->NewStringUTF("Error: Failed to process audio");
    }

    const int n_segments = whisper_full_n_segments(g_whisper_ctx);
    std::string result;
    for (int i = 0; i < n_segments; ++i) {
        const char *text = whisper_full_get_segment_text(g_whisper_ctx, i);
        result += text;
    }

    return env->NewStringUTF(result.c_str());
}

extern "C" JNIEXPORT void JNICALL
Java_com_example_translate_WhisperBridge_freeContext(JNIEnv *env, jobject /* this */) {
    if (g_whisper_ctx != nullptr) {
        whisper_free(g_whisper_ctx);
        g_whisper_ctx = nullptr;
    }
}
