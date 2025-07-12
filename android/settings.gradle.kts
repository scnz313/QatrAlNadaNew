pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-gradle-plugin") version "1.0.0" apply false
    id("com.android.application") version "8.3.0" apply false
    id("org.jetbrains.kotlin.android") version "1.9.22" apply false
}

include(":app")

// Flutter plugin Android modules
val flutterPluginsDir = File(System.getProperty("user.home"), ".pub-cache/hosted/pub.dev")
include(":path_provider_android")
project(":path_provider_android").projectDir = flutterPluginsDir.resolve("path_provider_android-2.2.17/android")

include(":sqflite_android")
project(":sqflite_android").projectDir = flutterPluginsDir.resolve("sqflite_android-2.4.1/android")

include(":url_launcher_android")
project(":url_launcher_android").projectDir = flutterPluginsDir.resolve("url_launcher_android-6.3.16/android")
