# Matrial Disaster

Aplikasi mobile e-commerce berbasis Flutter untuk pembelian material bangunan secara online. Aplikasi ini mendukung autentikasi pengguna (termasuk Google Sign-In dan biometrik), manajemen produk, keranjang belanja, proses checkout, serta notifikasi pembayaran secara real-time melalui deep link.

---

## Deskripsi Aplikasi

Matrial Disaster adalah aplikasi toko material bangunan yang dibangun menggunakan Flutter. Pengguna dapat melakukan registrasi dan login, menelusuri daftar produk, menambahkan produk ke keranjang, melakukan checkout dengan integrasi pembayaran berbasis wallet, dan melihat riwayat transaksi. Aplikasi mendukung verifikasi email, autentikasi biometrik (fingerprint / face ID), serta notifikasi sistem lokal setelah pembayaran selesai.

---

## Arsitektur Aplikasi

Proyek ini menggunakan pola arsitektur *Feature-First Clean Architecture* dengan pemisahan lapisan yang jelas:


lib/
├── main.dart                        # Entry point aplikasi
├── firebase_options.dart            # Konfigurasi Firebase
│
├── core/                            # Modul inti yang digunakan lintas fitur
│   ├── constants/                   # Konstanta string, warna, dan URL API
│   ├── guards/                      # AuthGuard untuk proteksi halaman
│   ├── routes/                      # AppRouter - definisi seluruh rute
│   ├── services/                    # Layanan global (Dio, Biometrik, Notifikasi, Secure Storage)
│   ├── shared/                      # Widget dan utilitas yang dapat digunakan ulang
│   └── theme/                       # Tema aplikasi (AppTheme)
│
└── features/                        # Modul berdasarkan fitur
    ├── auth/                        # Fitur autentikasi
    │   ├── data/                    # Repository dan sumber data auth
    │   ├── domain/                  # Model dan use case auth
    │   └── presentation/            # Halaman (Login, Register, Verify Email) dan Provider
    │
    ├── dashboard/                   # Fitur dashboard utama
    │   ├── data/                    # Repository produk
    │   ├── domain/                  # Model produk
    │   └── presentation/            # Halaman (Home, History, Profile) dan Provider
    │
    └── cart/                        # Fitur keranjang dan transaksi
        ├── data/                    # Repository cart dan checkout
        ├── domain/                  # Model cart dan transaksi
        └── presentation/            # Halaman (Cart, Checkout, Payment) dan Provider


*State Management:* Provider (ChangeNotifier)

*Komunikasi API:* Dio dengan interceptor token Bearer

*Autentikasi:* Firebase Auth (Email/Password + Google Sign-In) + JWT Token via Secure Storage

*Deep Link:* Callback pembayaran menggunakan skema tokomaterial://callback

---

## Cara Menjalankan Proyek

### Prasyarat

- Flutter SDK versi 3.x atau lebih baru
- Dart SDK ^3.9.2
- Android Studio / VS Code
- Akun Firebase (dengan project yang sudah dikonfigurasi)
- Backend API yang berjalan (lihat konfigurasi baseUrl di app_constants.dart)

### Langkah Instalasi

1. Clone repositori ini:

   bash
   git clone https://github.com/username/matrial_1123150086_uts.git
   cd matrial_1123150086_uts
   

2. Install semua dependensi:

   bash
   flutter pub get

3. Sesuaikan konfigurasi baseUrl di file lib/core/constants/app_constants.dart dengan alamat IP server backend yang digunakan:

   dart
   static const String baseUrl = 'http://<IP_SERVER>:8080/v1';

4. Pastikan file google-services.json (Android) dan GoogleService-Info.plist (iOS) sudah ditempatkan sesuai direktori platform masing-masing.

5. Jalankan aplikasi:

   bash
   flutter run

---

## Daftar Dependensi Utama

| Package | Versi | Kegunaan |
|---|---|---|
| provider | ^6.1.5 | State management (ChangeNotifier) |
| firebase_core | ^4.6.0 | Inisialisasi Firebase |
| firebase_auth | ^6.3.0 | Autentikasi pengguna via Firebase |
| google_sign_in | ^6.2.1 | Login menggunakan akun Google |
| dio | ^5.9.2 | HTTP client untuk komunikasi REST API |
| equatable | ^2.0.8 | Perbandingan objek model |
| email_validator | ^3.0.0 | Validasi format email |
| flutter_svg | ^2.2.4 | Render ikon format SVG |
| url_launcher | ^6.3.2 | Membuka URL eksternal (payment gateway) |
| app_links | ^6.1.1 | Deep link / universal link handler |
| flutter_secure_storage | ^10.0.0 | Penyimpanan token JWT secara aman |
| flutter_local_notifications | ^17.2.1 | Notifikasi lokal sistem (pembayaran) |
| local_auth | ^2.3.0 | Autentikasi biometrik (fingerprint / face ID) |
| cupertino_icons | ^1.0.8 | Ikon gaya iOS |

---

## Screenshot Aplikasi



---

## Link Video Presentasi YouTube