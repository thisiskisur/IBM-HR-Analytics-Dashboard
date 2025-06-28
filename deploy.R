# ============================================
# SCRIPT DEPLOYMENT DASHBOARD HR ANALYTICS
# Dibuat oleh Rizky Surya Alfarizy
# ============================================

# Install dan load rsconnect package
if (!require(rsconnect)) {
  install.packages("rsconnect")
}
library(rsconnect)

# ============================================
# KONFIGURASI DEPLOYMENT
# ============================================

# Ganti dengan informasi akun shinyapps.io Anda
# Dapatkan informasi ini dari dashboard shinyapps.io
ACCOUNT_NAME <- "your-account-name"  # Ganti dengan nama akun Anda
TOKEN <- "your-token"                # Ganti dengan token Anda
SECRET <- "your-secret"              # Ganti dengan secret Anda

# ============================================
# SETUP ACCOUNT
# ============================================

cat("🔧 Setting up Shinyapps.io account...\n")

# Setup account information
rsconnect::setAccountInfo(name = ACCOUNT_NAME,
                         token = TOKEN,
                         secret = SECRET)

cat("✅ Account setup completed!\n")

# ============================================
# DEPLOY APLIKASI
# ============================================

cat("🚀 Deploying HR Analytics Dashboard...\n")

# Deploy aplikasi
tryCatch({
  rsconnect::deployApp(
    appName = "hr-analytics",
    appTitle = "Dashboard Analisis Data HR IBM",
    appFiles = c("app.R", "Data_HR.csv"),
    forceUpdate = TRUE
  )
  
  cat("✅ Deployment successful!\n")
  cat("🌐 Dashboard dapat diakses di: https://", ACCOUNT_NAME, ".shinyapps.io/hr-analytics/\n", sep = "")
  
}, error = function(e) {
  cat("❌ Deployment failed!\n")
  cat("Error:", e$message, "\n")
  cat("🔍 Cek log untuk detail error:\n")
  rsconnect::showLogs()
})

# ============================================
# VERIFIKASI DEPLOYMENT
# ============================================

cat("\n📊 Checking deployment status...\n")

# Cek aplikasi yang sudah di-deploy
apps <- rsconnect::applications()
if (nrow(apps) > 0) {
  cat("📋 Aplikasi yang sudah di-deploy:\n")
  print(apps[, c("name", "url", "status")])
} else {
  cat("ℹ️ Tidak ada aplikasi yang ditemukan.\n")
}

# ============================================
# INFORMASI TAMBAHAN
# ============================================

cat("\n📝 Informasi Deployment:\n")
cat("• Platform: Shinyapps.io\n")
cat("• Akun: ", ACCOUNT_NAME, "\n")
cat("• Aplikasi: hr-analytics\n")
cat("• Dibuat oleh: Rizky Surya Alfarizy\n")
cat("• NIM: 2113221022\n")
cat("• Universitas: Universitas Sangga Buana YPKP Bandung\n")

cat("\n🎯 Langkah selanjutnya:\n")
cat("1. Akses dashboard di URL yang diberikan\n")
cat("2. Test semua fitur dashboard\n")
cat("3. Share URL dengan dosen untuk presentasi\n")
cat("4. Update README.md dengan URL yang benar\n")

cat("\n🔗 Link berguna:\n")
cat("• Dashboard: https://", ACCOUNT_NAME, ".shinyapps.io/hr-analytics/\n", sep = "")
cat("• Shinyapps.io Dashboard: https://www.shinyapps.io/\n")
cat("• GitHub Repository: https://github.com/rizky-alfarizy/hr-analytics-dashboard\n")

cat("\n🎉 Deployment selesai! Dashboard siap digunakan untuk presentasi UAS!\n") 