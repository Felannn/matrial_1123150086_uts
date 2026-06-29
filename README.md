# Aplikasi Material Ku (E-Commerce System)

* **Nama** : Felan Ardenta Yoga Adiyama
* **NIM** : 1123150086
* **Kelas** : TI SE SH 23
* **Matkul** : Pemrograman Mobile Lanjutan
* **Kampus** : Global Institute Bina Sarana Global

Aplikasi mobile e-commerce berbasis Flutter untuk pembelian material bangunan secara online. Aplikasi ini mendukung autentikasi pengguna (termasuk Google Sign-In dan biometrik), manajemen produk, keranjang belanja, proses checkout, serta notifikasi pembayaran secara real-time melalui deep link.

---

## 📌 Deskripsi Aplikasi

**Material Ku** adalah aplikasi toko material bangunan yang dibangun menggunakan Flutter. Pengguna dapat melakukan registrasi dan login, menelusuri daftar produk, menambahkan produk ke keranjang, melakukan checkout dengan integrasi pembayaran berbasis e-wallet, dan melihat riwayat transaksi. Aplikasi ini mendukung verifikasi email, autentikasi biometrik (sidik jari / face ID), serta notifikasi sistem lokal setelah status pembayaran selesai diproses.

---

## 📂 Struktur Folder Proyek (Feature-First Architecture)

## 📂 Struktur Folder Proyek

### 1. Aplikasi Wallet Ku (Clean Architecture)
Aplikasi dompet digital ini terstruktur dengan memisahkan domain bisnis, data, dan presentasi secara modular:
```text
wallet_ku/
├── lib/
│   ├── core/                      # Utilitas global dan konfigurasi aplikasi
│   │   ├── constants/             # Konstanta teks, ukuran, dan API
│   │   ├── router/                # Konfigurasi navigasi (GoRouter)
│   │   ├── services/              # Layanan callback deeplink & otentikasi lokal
│   │   │   ├── biometric_service.dart
│   │   │   └── deeplink_service.dart
│   │   └── theme/                 # Palet warna premium, tema, dan gaya teks
│   │
│   ├── data/                      # Implementasi operasional data (API/DB)
│   │   ├── datasources/           # Remote client (Dio) & local storage (Secure Storage)
│   │   ├── models/                # JSON parser & mapper untuk entitas
│   │   └── repositories/          # Implementasi kontrak repositori domain
│   │
│   ├── domain/                    # Layer bisnis murni (bebas dependensi UI)
│   │   ├── entities/              # Objek bisnis inti (User, Account, Transaction)
│   │   ├── repositories/          # Kontrak interface data (abstraksi)
│   │   └── usecases/              # Logika use-case spesifik aplikasi
│   │
│   ├── presentation/              # Layer visual antarmuka pengguna
│   │   ├── blocs/                 # Pengelola state aplikasi menggunakan BLoC
│   │   ├── pages/                 # Halaman aplikasi (home, payment, topup, transfer, success)
│   │   └── widgets/               # Komponen UI reusable (buttons, badges, pin_pad)
│   │
│   ├── injection/                 # Pengaturan Dependency Injection (GetIt/Locator)
│   ├── firebase_options.dart      # Konfigurasi Firebase untuk Android/iOS
│   └── main.dart                  # Titik entri utama aplikasi
```

### 2. Aplikasi Material Ku (Feature-First Architecture)
Aplikasi e-commerce ini dikelompokkan berdasarkan modul/fitur untuk mempermudah pengembangan modul:
```text
matrial_1123150086_uts/
├── lib/
│   ├── core/                      # Infrastruktur bersama & fungsi global
│   │   ├── constants/             # String konstan & parameter endpoint
│   │   ├── guards/                # Pelindung rute login / otentikasi (AuthGuard)
│   │   ├── routes/                # Tabel rute navigasi aplikasi (AppRouter)
│   │   ├── services/              # Layanan backend HTTP, secure storage, & notifikasi
│   │   │   ├── biometric_service.dart
│   │   │   ├── dio_client.dart
│   │   │   └── notification_service.dart
│   │   ├── shared/                # Widget reusable lintas modul (buttons, fields, headers)
│   │   └── theme/                 # Pengaturan tema visual & warna
│   │
│   ├── features/                  # Modul fitur utama e-commerce
│   │   ├── auth/                  # Modul Otentikasi (Login, Register, Email Verification)
│   │   │   ├── presentation/
│   │   │   │   ├── pages/         # Tampilan halaman login, register, dll.
│   │   │   │   └── providers/     # Pengelola state otentikasi (AuthProvider)
│   │   │
│   │   ├── cart/                  # Modul Keranjang & Transaksi Checkout
│   │   │   ├── presentation/
│   │   │   │   ├── pages/         # Tampilan cart, checkout, success, awaiting_payment
│   │   │   │   └── providers/     # Pengelola state belanja & pembayaran
│   │   │
│   │   └── dashboard/             # Modul Dashboard utama (Home, History, Profile)
│   │       ├── presentation/
│   │       │   ├── pages/         # Tampilan dashboard, katalog produk, riwayat belanja
│   │       │   └── providers/     # Pengelola katalog produk
│   │
│   ├── firebase_options.dart      # Konfigurasi Firebase lokal
│   └── main.dart                  # Inisialisasi dependensi global & stream listener deeplink
```

* **State Management:** Provider (ChangeNotifier)
* **Komunikasi API:** Dio dengan interceptor token Bearer
* **Autentikasi:** Firebase Auth (Email/Password + Google Sign-In) + JWT Token via Secure Storage
* **Deep Link:** Callback pembayaran menggunakan skema `tokomaterial://callback`

---

## 🚀 Cara Menjalankan Proyek

### Prasyarat
* Flutter SDK versi 3.x atau lebih baru
* Dart SDK ^3.9.2
* Android Studio / VS Code
* Akun Firebase (dengan project yang sudah dikonfigurasi)
* Backend API yang berjalan (lihat konfigurasi `baseUrl` di `app_constants.dart`)

### Langkah Instalasi

1. Clone repositori ini:
   ```bash
   git clone https://github.com/Felannn/matrial_1123150086_uts.git
   cd matrial_1123150086_uts
   ```

2. Install semua dependensi:
   ```bash
   flutter pub get
   ```

3. Sesuaikan konfigurasi `baseUrl` di file [app_constants.dart](file:///home/nafisah/UAS-FELAN-1123150086/matrial_1123150086_uts/lib/core/constants/app_constants.dart) dengan alamat IP server backend yang digunakan:
   ```dart
   static const String baseUrl = 'http://<IP_SERVER>:8080/v1';
   ```

4. Pastikan file `google-services.json` (Android) dan `GoogleService-Info.plist` (iOS) sudah ditempatkan sesuai direktori platform masing-masing.

5. Jalankan aplikasi:
   ```bash
   flutter run
   ```

---

## 📦 Daftar Dependensi Utama

| Package | Versi | Kegunaan |
|---|---|---|
| **provider** | `^6.1.5` | State management (ChangeNotifier) |
| **firebase_core** | `^4.6.0` | Inisialisasi Firebase |
| **firebase_auth** | `^6.3.0` | Autentikasi pengguna via Firebase |
| **google_sign_in** | `^6.2.1` | Login menggunakan akun Google |
| **dio** | `^5.9.2` | HTTP client untuk komunikasi REST API |
| **equatable** | `^2.0.8` | Perbandingan objek model |
| **email_validator** | `^3.0.0` | Validasi format email |
| **flutter_svg** | `^2.2.4` | Render ikon format SVG |
| **url_launcher** | `^6.3.2` | Membuka URL eksternal (payment gateway) |
| **app_links** | `^6.1.1` | Deep link / universal link handler |
| **flutter_secure_storage** | `^10.0.0` | Penyimpanan token JWT secara aman |
| **flutter_local_notifications** | `^17.2.1` | Notifikasi lokal sistem (pembayaran) |
| **local_auth** | `^2.3.0` | Autentikasi biometrik (fingerprint / face ID) |

---

## 🔗 Link Tautan & Repositori

* **Github E-Commerce:** [Material Ku Repositori](https://github.com/Felannn/matrial_1123150086_uts.git)
* **Github E-Wallet:** [Wallet Ku Repositori](https://github.com/Felannn/wallet-ku.git)
* **Backend E-Commerce:** [Backend Gin API](https://github.com/Felannn/gin-backend.git)
* **Backend E-Money:** [Backend Wallet API](https://github.com/Felannn/be-wallet-ku.git)
* **Video Demo Aplikasi:** [Tautan YouTube](https://youtu.be)