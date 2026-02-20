cmake_minimum_required(VERSION 3.22.1)

project("translation_app_native" LANGUAGES CXX C)

# Add whisper.cpp source files
add_library(whisper
        whisper.cpp
        ggml.c)

target_include_directories(whisper PUBLIC .)

# Add the JNI bridge library
add_library(whisper_jni SHARED whisper_jni.cpp)

# Set compiler flags for NEON optimization
target_compile_options(whisper_jni PRIVATE
        -O3
        -DNDEBUG
        -fPIC
        -pthread
        -march=armv8-a+simd
        -mfpu=neon
        -DGGML_USE_NEON=1)

# Link the JNI library against whisper and Android libraries
target_link_libraries(whisper_jni
        whisper
        android
        log)

# Find and link against OpenCL if available (for GPU acceleration)
find_package(OpenCL)
if(OpenCL_FOUND)
    target_link_libraries(whisper_jni PRIVATE OpenCL::OpenCL)
    target_compile_definitions(whisper_jni PRIVATE -DGGML_USE_OPENCL=1)
endif()
