plugins {
    id("com.android.application")
}

// Versão vem do workflow (-PversionName / -PversionCode); valores padrão para build local.
val appVersionName = (findProperty("versionName") as String?) ?: "3.0.0"
val appVersionCode = ((findProperty("versionCode") as String?) ?: "1").toInt()

android {
    namespace = "com.daroca.adventure"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.daroca.adventure"
        minSdk = 24
        targetSdk = 34
        versionCode = appVersionCode
        versionName = appVersionName
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            // Sem keystore no repositório: o APK de release sai assinado com a chave de debug.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    androidResources {
        // O jogo (pasta dist/) vai inteiro dentro do APK, sem compressão de áudio e imagens.
        noCompress += listOf("mp3", "ogg", "png", "ttf")
    }
}

dependencies {
    implementation("androidx.webkit:webkit:1.11.0")
    // Servidor HTTP + WebSocket do modo TV (celular como controle na rede Wi-Fi)
    implementation("org.nanohttpd:nanohttpd-websocket:2.3.1")
}
