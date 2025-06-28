# 📊 Dashboard Analisis Data HR IBM

## 🎯 Tentang Proyek

Dashboard interaktif untuk analisis data Human Resources (HR) IBM yang dibuat menggunakan R Shiny. Proyek ini merupakan bagian dari tugas UAS mata kuliah Sistem Media Interaktif di Universitas Sangga Buana YPKP Bandung.

**Dibuat oleh:** Rizky Surya Alfarizy  
**NIM:** 2113221022  
**Jurusan:** Teknik Informatika  
**Angkatan:** 2022  
**Universitas:** Universitas Sangga Buana YPKP Bandung

## 🌟 Fitur Utama

### 📈 Dashboard Interaktif
- **Ringkasan Eksekutif**: Statistik utama dan tren attrition
- **Analisis Detail**: Analisis mendalam faktor-faktor attrition
- **Demografi**: Distribusi karyawan berdasarkan usia, gender, pendidikan
- **Kompensasi**: Analisis gaji dan hubungannya dengan attrition
- **Data Lengkap**: Tabel interaktif dengan seluruh data karyawan
- **Rekomendasi**: Saran strategis berdasarkan analisis data

### 📊 Visualisasi Data
- Grafik batang, pie chart, dan line chart interaktif
- Value boxes dengan statistik real-time
- Tabel data yang dapat di-sort dan di-filter
- Responsive design untuk berbagai ukuran layar

### 🔍 Analisis yang Tersedia
- Tingkat attrition per departemen
- Faktor risiko attrition
- Distribusi demografi karyawan
- Analisis kompensasi dan gaji
- Tren attrition berdasarkan lama bekerja
- Analisis berdasarkan level jabatan

## 🚀 Demo Online

**Akses Dashboard:** [[https://rizky-alfarizy-hr-dashboard.shinyapps.io/hr-analytics/](https://rizky-alfarizy-hr-dashboard.shinyapps.io/hr-analytics/](https://thisiskisur-ibm-hr-analytics-employee-attrition-performance.shinyapps.io/Project_UAS_IBM_HR_RizkySurya/))

> **Catatan:** Dashboard dapat diakses secara online dan dapat digunakan untuk demo atau presentasi.

## 📋 Prasyarat

Sebelum menjalankan proyek ini, pastikan Anda telah menginstal:

- **R** (versi 4.0.0 atau lebih baru)
- **RStudio** (versi 1.4.0 atau lebih baru)
- **Git** (untuk clone repository)

## 🛠️ Instalasi

### 1. Clone Repository
```bash
git clone https://github.com/rizky-alfarizy/hr-analytics-dashboard.git
cd hr-analytics-dashboard
```

### 2. Install Dependencies
Buka RStudio dan jalankan perintah berikut di console R:

```r
# Install required packages
install.packages(c("shiny", "shinydashboard", "tidyverse", "DT", "ggplot2"))

# Load libraries
library(shiny)
library(shinydashboard)
library(tidyverse)
library(DT)
```

### 3. Jalankan Aplikasi
```r
# Di RStudio, buka file app.R dan klik "Run App"
# Atau jalankan dari console:
shiny::runApp()
```

## 📁 Struktur Proyek

```
hr-analytics-dashboard/
├── app.R                          # File utama aplikasi Shiny
├── Data_HR.csv                    # Dataset HR IBM
├── README.md                      # Dokumentasi proyek
├── Project_UAS_IBM HR_Rizky Surya Alfarizy.Rproj  # File proyek RStudio
└── .Rproj.user/                   # Konfigurasi RStudio
```

## 📊 Dataset

Dataset yang digunakan adalah **IBM HR Analytics Employee Attrition & Performance** yang berisi:
- **1,470** records karyawan
- **35** variabel termasuk demografi, kompensasi, dan performa
- Data attrition (karyawan yang keluar) untuk analisis prediktif

### Variabel Utama:
- `Age`: Usia karyawan
- `Attrition`: Status keluar (Yes/No)
- `Department`: Departemen kerja
- `MonthlyIncome`: Gaji bulanan
- `YearsAtCompany`: Lama bekerja di perusahaan
- `JobLevel`: Level jabatan
- `Gender`: Jenis kelamin
- `Education`: Tingkat pendidikan

## 🎨 Fitur Dashboard

### 1. 📊 Ringkasan Eksekutif
- Total karyawan dan tingkat attrition
- Usia rata-rata karyawan
- Grafik tren attrition per departemen
- Distribusi usia karyawan

### 2. 📈 Analisis Detail
- Analisis attrition per departemen dan gender
- Faktor risiko attrition
- Tren attrition vs lama bekerja
- Attrition per level jabatan

### 3. 👥 Demografi
- Distribusi gender
- Distribusi usia
- Pendidikan vs attrition
- Status pernikahan vs attrition

### 4. 💰 Kompensasi
- Distribusi gaji karyawan
- Attrition per rentang gaji
- Gaji vs lama bekerja
- Gaji vs level jabatan

### 5. 📋 Data Lengkap
- Tabel interaktif seluruh data karyawan
- Fitur search dan filter
- Pagination untuk navigasi data

### 6. 💡 Rekomendasi
- Saran strategis berdasarkan analisis
- Rekomendasi per departemen
- Kebijakan kompensasi
- Program pengembangan karyawan

## 🔧 Deployment

### Shinyapps.io (Gratis)
```r
# Install rsconnect package
install.packages("rsconnect")

# Setup account (hanya sekali)
rsconnect::setAccountInfo(name='<ACCOUNT>',
                         token='<TOKEN>',
                         secret='<SECRET>')

# Deploy aplikasi
rsconnect::deployApp()
```

### Shiny Server (Self-hosted)
```bash
# Install Shiny Server
sudo apt-get install r-base r-base-dev
sudo apt-get install shiny-server

# Copy aplikasi ke direktori Shiny
sudo cp -r hr-analytics-dashboard /srv/shiny-server/
```

## 📚 Dokumentasi Mata Kuliah

### Sistem Media Interaktif - Semester 6
**Dosen:** [Nama Dosen]  
**Mata Kuliah:** Sistem Media Interaktif  
**Tahun Ajaran:** 2024/2025  

### Mingguan:
- **Minggu 1**: Tutorial Looker Studio
- **Minggu 2**: Score Card, Pie Chart dan Time Series di Looker Studio
- **Minggu 3**: Membuat Calculated Field di Looker Studio
- **Minggu 4**: Dokumentasi Looker Studio Menghubungkan Sumber Data MySQL
- **Minggu 5**: Looker Studio Menghubungkan Sumber Daya PostgreSQL
- **Minggu 7**: Login ke Akun PostgreSQL
- **UTS**: Dashboard HR Analytics (PostgreSQL + Aiven + Looker Studio)
- **Minggu 9**: Instalasi R dan R Studio
- **Minggu 10**: Fungsi R & Latihan Soal
- **Minggu 11**: Tugas Minggu 11 - (Fungsi R & Latihan Soal)
- **Minggu 12**: Dashboard - Langkah Bagaimana Cara Membuat Dashboard Berbasis Web
- **UAS**: Pembuatan Dashboard Analisis Data HR IBM dengan R Shiny

## 🤝 Kontribusi

Proyek ini dibuat untuk tujuan akademis. Jika Anda ingin berkontribusi atau memberikan saran, silakan:

1. Fork repository ini
2. Buat branch fitur baru (`git checkout -b feature/AmazingFeature`)
3. Commit perubahan Anda (`git commit -m 'Add some AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buka Pull Request

## 📄 Lisensi

Proyek ini dibuat untuk tujuan akademis mata kuliah Sistem Media Interaktif. 

**Hak Cipta © 2024 Rizky Surya Alfarizy**

## 📞 Kontak

**Nama:** Rizky Surya Alfarizy  
**NIM:** 2113221022  
**Email:** [email@example.com]  
**Jurusan:** Teknik Informatika  
**Universitas:** Universitas Sangga Buana YPKP Bandung  

## 🙏 Ucapan Terima Kasih

Terima kasih kepada:
- Dosen mata kuliah Sistem Media Interaktif
- IBM untuk dataset yang digunakan
- Komunitas R dan Shiny untuk dokumentasi yang lengkap
- Universitas Sangga Buana YPKP Bandung

---

**⭐ Jika proyek ini bermanfaat, jangan lupa berikan star di repository ini!**

**📝 Catatan:** Dashboard ini dibuat dengan sepenuh hati untuk memenuhi tugas UAS Sistem Media Interaktif. Semua analisis dan rekomendasi dibuat berdasarkan data yang tersedia dan pengetahuan yang diperoleh selama perkuliahan. 
