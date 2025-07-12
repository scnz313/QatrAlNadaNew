plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.qataralnada.app"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.qataralnada.app"
        minSdk = 21
        targetSdk = 35
        versionCode = 6
        versionName = "2.0.1"
        
        // Play Store specific configurations
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        multiDexEnabled = true
    }

    signingConfigs {
        create("release") {
            storeFile = file("../app/keystore.jks")
            storePassword = "qataralnada123"
            keyAlias = "qataralnada"
            keyPassword = "qataralnada123"
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            isShrinkResources = false
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}

// Add required dependencies for Material3 theme support
dependencies {
    implementation("com.google.android.material:material:1.11.0")
    implementation("androidx.core:core-ktx:1.13.0")
    // Flutter embedding dependency (ensure FlutterActivity is available)
    implementation("io.flutter:flutter_embedding_release:1.0.0-72f2b18bb094f92f62a3113a8075240ebb59affa")
    implementation(project(":path_provider_android"))
    implementation(project(":sqflite_android"))
    implementation(project(":url_launcher_android"))
}
