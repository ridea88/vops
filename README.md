# VOPS - VPS Optimization & Security Assistant

VOPS adalah sebuah *command-line tool* (CLI) interaktif berbasis Bash script yang dirancang untuk membantu sistem administrator dan developer melakukan audit kesehatan, pemeriksaan keamanan, serta pembersihan log sampah pada server Linux (Ubuntu/Debian) secara instan.

## Fitur Utama

- **Server Health Check:** Memonitor penggunaan CPU, ketersediaan RAM, dan kapasitas sisa disk storage secara *real-time*.
- **Security Audit:** Memeriksa status UFW Firewall dan mendeteksi port jaringan yang sedang aktif (*listening*).
- **Server Optimizer:** Mengotomatisasi pembersihan cache `apt` dan merapikan file log `journald` lama untuk mengosongkan ruang disk.

## Cara Instalasi & Penggunaan

Berikut untuk menjalankan VOPS langsung di server atau komputer Linux:

### 1. Kloning Repositori
-buka terminal linux
git clone git@github.com:ridea88/vops.git
cd vops

### 2. Beri Akses Execute
chmod +x vops.sh

### 3. Jalankan Program
./vops.sh








Dikembangkan oleh Ridea Ariyanto sebagai bagian dari portofolio otomatisasi DevOps
