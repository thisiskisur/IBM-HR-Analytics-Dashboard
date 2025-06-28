# 🚀 Quick Deployment Guide - Dashboard HR Analytics

## ⚡ Langkah Cepat untuk Deployment

### 1. Daftar Shinyapps.io (5 menit)
1. Buka [shinyapps.io](https://www.shinyapps.io/)
2. Klik "Sign Up" dan daftar akun gratis
3. Verifikasi email Anda
4. Login ke dashboard

### 2. Dapatkan Token (2 menit)
1. Di dashboard shinyapps.io, klik "Tokens"
2. Klik "Show" untuk melihat token dan secret
3. Copy token, secret, dan nama akun Anda

### 3. Setup di RStudio (3 menit)
```r
# Install package
install.packages("rsconnect")

# Setup account (ganti dengan info Anda)
rsconnect::setAccountInfo(name='NAMA_AKUN_ANDA',
                         token='TOKEN_ANDA',
                         secret='SECRET_ANDA')

# Deploy aplikasi
rsconnect::deployApp()
```

### 4. Akses Dashboard
Setelah deployment berhasil, dashboard dapat diakses di:
```
https://NAMA_AKUN_ANDA.shinyapps.io/hr-analytics/
```

## 📋 Checklist Deployment

- [ ] Daftar akun shinyapps.io
- [ ] Dapatkan token dan secret
- [ ] Install rsconnect package
- [ ] Setup account di R
- [ ] Deploy aplikasi
- [ ] Test dashboard online
- [ ] Share URL dengan dosen

## 🎯 Untuk Presentasi UAS

### URL Dashboard
```
https://NAMA_AKUN_ANDA.shinyapps.io/hr-analytics/
```

### Demo Script
1. **Pembukaan** (2 menit)
   - Perkenalkan dashboard
   - Jelaskan tujuan proyek

2. **Demo Fitur** (10 menit)
   - Ringkasan Eksekutif
   - Analisis Detail
   - Demografi
   - Kompensasi
   - Data Lengkap
   - Rekomendasi

3. **Analisis Temuan** (5 menit)
   - Tingkat attrition 16.1%
   - Faktor risiko utama
   - Rekomendasi strategis

4. **Penutup** (3 menit)
   - Kesimpulan
   - Q&A

## 🔧 Troubleshooting

### Error "Package not found"
```r
install.packages(c("shiny", "shinydashboard", "tidyverse", "DT"))
```

### Error "Account not found"
- Pastikan nama akun, token, dan secret benar
- Cek di dashboard shinyapps.io

### Error "Deployment failed"
```r
# Cek log error
rsconnect::showLogs()
```

## 📞 Support

Jika ada masalah:
1. Cek log error di RStudio
2. Konsultasi dokumentasi shinyapps.io
3. Hubungi support shinyapps.io

---

**🎉 Selamat! Dashboard Anda siap untuk presentasi UAS!**

**Dibuat oleh: Rizky Surya Alfarizy (2113221022)**
**Universitas Sangga Buana YPKP Bandung** 