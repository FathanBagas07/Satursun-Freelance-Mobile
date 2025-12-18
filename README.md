# SaturSun Freelance

**SaturSun Freelance** adalah aplikasi mobile berbasis Flutter yang menjembatani Freelancer dan Klien untuk berkolaborasi dalam berbagai proyek pekerjaan secara efisien, aman, dan profesional.

---

## A. Identitas Kelompok

| Informasi | Detail |
| :--- | :--- |
| **Nama Kelompok** | **Ada Apanya** |
| **Mata Kuliah** | Pemrograman Mobile |
| **LAB** | 5 |
| **Anggota 1** | Bhenarezky Suranta Ginting (231401003) |
| **Anggota 2** | Alfatan Bagas Kurnia (231401012) |
| **Anggota 3** | Aryasatya Wicaksana (231401114) |

---

## B. Deskripsi Proyek (Project Description)

Aplikasi ini dikembangkan untuk memberikan solusi bagi pasar tenaga kerja lepas. Dengan sistem **Multi-Role**, satu aplikasi dapat melayani dua kebutuhan berbeda: **Freelancer** yang mencari pekerjaan dan **Klien** yang membutuhkan jasa. Proyek ini mengedepankan pengalaman pengguna (UX) yang bersih dan arsitektur kode yang rapi.

### Fitur Unggulan
1.  **Multi-Role System:** Pendaftaran akun fleksibel sebagai Freelancer atau Klien dengan antarmuka yang disesuaikan secara otomatis.
2.  **Autentikasi Terintegrasi:** Login dan Register aman menggunakan Firebase Auth disertai verifikasi OTP (*One-Time Password*).
3.  **Client Dashboard:** Memungkinkan klien memposting lowongan (*Job Posting*), menyeleksi pelamar, dan menyetujui hasil kerja.
4.  **Freelancer Workspace:** Fitur untuk mencari pekerjaan (*Explore Jobs*), melihat detail proyek, mengirim lamaran, dan mengunggah tugas (*Task Submission*).
5.  **E-Wallet Simulation:** Fitur dompet digital untuk memantau pemasukan (bagi Freelancer) dan pengeluaran (bagi Klien).
6.  **Modern UI:** Desain antarmuka menggunakan font *Nunito Sans* dan aset visual yang konsisten.

### Teknologi (Tech Stack)
* **Framework:** Flutter SDK (Dart)
* **Backend:** Firebase (Authentication, Cloud Firestore)
* **State Management:** Provider
* **Assets:** Custom Fonts (NunitoSans), SVG, & PNG
* **External Packages:** `image_picker` (Media Upload), `http`, `intl` (Formatting), `shared_preferences`

---

## C. Tampilan Aplikasi (Screenshots)

Berikut adalah dokumentasi visual dari seluruh fitur aplikasi SaturSun Freelance:

### 1. Autentikasi & Onboarding (Umum)
Halaman yang dilalui oleh semua pengguna sebelum masuk ke menu utama.

| **Get Started** | **Login** | **Register** | **Role Selection** |
|:---:|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/cc25904d-22db-423d-871c-791b89e9fd3b" width="160" alt="Get Started"> | <img src="https://github.com/user-attachments/assets/0c8e6ff8-156b-4c17-89d4-b4d9dedd7fd2" width="160" alt="Login"> | <img src="https://github.com/user-attachments/assets/bbd543eb-451c-464a-81e3-565f9270b281" width="160" alt="Register"> | <img src="https://github.com/user-attachments/assets/fae5e016-e11b-4455-b1da-0bc96189245a" width="160" alt="Select Role"> |
| *Halaman Awal* | *Masuk Akun* | *Daftar Akun* | *Pilih Peran* |

<br>

### 2. Tampilan Freelancer (Pencari Kerja)
Antarmuka khusus bagi pengguna yang mendaftar sebagai Freelancer.

| **Home / Dashboard** | **Explore Jobs** | **Job Detail** | **Task Submission** |
|:---:|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/b9c093e1-1225-43b2-b887-983ffd7412b8" width="160" alt="Home Freelancer"> | <img src="https://github.com/user-attachments/assets/fd4d7d21-378b-45b1-b2a7-ec97bfa1dd37" width="160" alt="Explore Jobs"> | <img src="https://github.com/user-attachments/assets/5c20e203-a52d-4fc6-bc51-4cdef73a02ec" width="160" alt="Job Detail"> | <img src="https://github.com/user-attachments/assets/bdba72a2-fa6b-46b2-9bc0-febc392d944e" width="160" alt="Task Submission"> |
| *Beranda Freelancer* | *Cari Pekerjaan* | *Detail Lowongan* | *Upload Tugas* |

| **Task List** | **My Wallet** | **Profile** |
|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/072f1e52-3043-4ca4-8883-67040945018e" width="160" alt="Task List"> | <img src="https://github.com/user-attachments/assets/7a879d3c-ecf9-4d6f-8e90-88a8dff0dd4f" width="160" alt="Freelancer Wallet"> | <img src="https://github.com/user-attachments/assets/5c6433f9-2b27-49de-96c5-08d665b7c9da" width="160" alt="Freelancer Profile"> |
| *Daftar Tugas Aktif* | *Dompet & Saldo* | *Profil Saya* |

<br>

### 3. Tampilan Klien (Pemberi Kerja)
Antarmuka khusus bagi pengguna yang mendaftar sebagai Klien.

| **Home / Dashboard** | **Explore Freelancer** | **List of Client Projects** | **Project Details** |
|:---:|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/31498698-65cb-446c-b99e-83ac3154797d" width="160" alt="Home Client"> | <img src="https://github.com/user-attachments/assets/cdc91e71-7267-4b3c-9775-140372899787" width="160" alt="Explore Talent"> | <img src="https://github.com/user-attachments/assets/4fd7ab04-69af-4b99-81b8-815ce05a800e" width="160" alt="My Job Detail"> | <img src="https://github.com/user-attachments/assets/f1c56e60-80ed-42b4-b457-39136a8a19d8" width="160" alt="Review Task"> |
| *Beranda Klien* | *Lihat Kandidat* | *Daftar Proyek Klien* | *Detail Projek Klien* |

| **Post Job (Step 1)** | **Post Job (Step 2)** | **My Wallet** | **Profile** |
|:---:|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/15157657-8550-4c48-ba5b-8bed30129ca0" width="160" alt="Post Job 1"> | <img src="https://github.com/user-attachments/assets/5f06af8f-3fd7-4060-a854-2aeca881151e" width="160" alt="Post Job 2"> | <img src="https://github.com/user-attachments/assets/b278d630-4b22-4694-ac6c-c4fa277fba3b" width="160" alt="Client Wallet"> | <img src="https://github.com/user-attachments/assets/a8440d6b-9164-488d-9935-3255c189b358" width="160" alt="Client Profile"> |
| *Buat Lowongan (1)* | *Buat Lowongan (2)* | *Dompet & Transaksi* | *Profil Klien* |

---

## D. Cara Menjalankan Project (Getting Started)

Ikuti langkah-langkah berikut untuk menjalankan aplikasi di lingkungan lokal Anda:

1.  **Clone Repositori:**
    ```bash
    git clone [https://github.com/username-anda/satursun-freelance-mobile.git](https://github.com/username-anda/satursun-freelance-mobile.git)
    ```

2.  **Install Dependencies:**
    Masuk ke folder project dan jalankan perintah:
    ```bash
    cd satursun-freelance-mobile
    flutter pub get
    ```

3.  **Konfigurasi Firebase:**
    * Pastikan file `google-services.json` (untuk Android) sudah diletakkan di direktori `android/app/`.
    * (Opsional) Untuk iOS, pastikan `GoogleService-Info.plist` ada di `ios/Runner/`.

4.  **Jalankan Aplikasi:**
    Hubungkan device atau emulator, lalu jalankan:
    ```bash
    flutter run
    ```
