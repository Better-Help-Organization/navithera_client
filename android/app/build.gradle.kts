import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

// Validate every required field up-front; all must be present for release signing.
val releaseStoreFile   = keystoreProperties["storeFile"]?.toString()?.takeIf { it.isNotBlank() }?.let { file(it) }
val releaseKeyAlias    = keystoreProperties["keyAlias"]?.toString()?.takeIf { it.isNotBlank() }
val releaseKeyPassword = keystoreProperties["keyPassword"]?.toString()?.takeIf { it.isNotBlank() }
val releaseStorePass   = keystoreProperties["storePassword"]?.toString()?.takeIf { it.isNotBlank() }

val hasValidReleaseKeystore =
    releaseStoreFile != null && releaseStoreFile.exists() &&
    releaseKeyAlias != null &&
    releaseKeyPassword != null &&
    releaseStorePass != null

android {
    namespace = "com.Abthon.abthon_navithera_client"
    compileSdk = 36
    ndkVersion = "30.0.14904198"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.Abthon.abthon_navithera_client"
        minSdk = 28
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        // Only create the config when every field is confirmed non-null/non-empty
        // and the store file actually exists on disk.
        // If any field is missing the block is skipped entirely — no empty fallbacks.
        if (hasValidReleaseKeystore) {
            create("release") {
                keyAlias      = releaseKeyAlias!!
                keyPassword   = releaseKeyPassword!!
                storeFile     = releaseStoreFile!!
                storePassword = releaseStorePass!!

                enableV1Signing = false
                enableV2Signing = true
                enableV3Signing = true
            }
        }
    }

    buildTypes {
        release {
            // Mirror the same guard: only assign release signing when the config exists.
            // If it was skipped above, the release build is left unsigned and will
            // fail clearly at the APK/AAB signing step rather than silently producing
            // a debug-signed or broken artifact.
            if (hasValidReleaseKeystore) {
                signingConfig = signingConfigs.getByName("release")
            }
            isMinifyEnabled   = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}