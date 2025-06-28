# 🚀 Panduan Deployment Dashboard HR Analytics

## 📋 Daftar Isi
1. [Deployment ke Shinyapps.io (Gratis)](#shinyappsio)
2. [Deployment ke Shiny Server](#shiny-server)
3. [Deployment ke Heroku](#heroku)
4. [Deployment ke Docker](#docker)
5. [Troubleshooting](#troubleshooting)

## 🌐 Shinyapps.io (Gratis)

### Langkah 1: Daftar Akun
1. Kunjungi [shinyapps.io](https://www.shinyapps.io/)
2. Daftar akun gratis (5 aplikasi aktif)
3. Verifikasi email Anda

### Langkah 2: Install rsconnect Package
```r
# Install package untuk deployment
install.packages("rsconnect")
```

### Langkah 3: Setup Account
```r
# Masukkan informasi akun dari shinyapps.io
rsconnect::setAccountInfo(name='<YOUR_ACCOUNT_NAME>',
                         token='<YOUR_TOKEN>',
                         secret='<YOUR_SECRET>')
```

### Langkah 4: Deploy Aplikasi
```r
# Pastikan Anda berada di direktori proyek
setwd("path/to/your/project")

# Deploy aplikasi
rsconnect::deployApp()
```

### Langkah 5: Akses Dashboard
Setelah deployment berhasil, Anda akan mendapatkan URL seperti:
```
https://your-username.shinyapps.io/hr-analytics/
```

## 🖥️ Shiny Server (Self-hosted)

### Prasyarat
- Ubuntu/Debian server
- R versi 4.0.0+
- Root access

### Langkah 1: Install R
```bash
# Update package list
sudo apt-get update

# Install R
sudo apt-get install r-base r-base-dev

# Install RStudio Server (opsional)
sudo apt-get install gdebi-core
wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-2021.09.0-351-amd64.deb
sudo gdebi rstudio-server-2021.09.0-351-amd64.deb
```

### Langkah 2: Install Shiny Server
```bash
# Install Shiny Server
sudo apt-get install shiny-server

# Start dan enable service
sudo systemctl start shiny-server
sudo systemctl enable shiny-server
```

### Langkah 3: Install R Packages
```r
# Install required packages
install.packages(c("shiny", "shinydashboard", "tidyverse", "DT"))
```

### Langkah 4: Deploy Aplikasi
```bash
# Copy aplikasi ke direktori Shiny
sudo cp -r /path/to/your/project /srv/shiny-server/hr-analytics

# Set permissions
sudo chown -R shiny:shiny /srv/shiny-server/hr-analytics
sudo chmod -R 755 /srv/shiny-server/hr-analytics
```

### Langkah 5: Akses Dashboard
```
http://your-server-ip:3838/hr-analytics/
```

## ☁️ Heroku

### Langkah 1: Install Heroku CLI
```bash
# Download dan install Heroku CLI
curl https://cli-assets.heroku.com/install.sh | sh
```

### Langkah 2: Login ke Heroku
```bash
heroku login
```

### Langkah 3: Buat Aplikasi Heroku
```bash
# Buat aplikasi baru
heroku create your-hr-dashboard

# Set buildpack
heroku buildpacks:set https://github.com/virtualstaticvoid/heroku-buildpack-r.git
```

### Langkah 4: Setup Files
Buat file `init.R` di root direktori:
```r
# init.R
install.packages(c("shiny", "shinydashboard", "tidyverse", "DT"))
```

### Langkah 5: Deploy
```bash
# Commit perubahan
git add .
git commit -m "Deploy to Heroku"

# Deploy ke Heroku
git push heroku main
```

## 🐳 Docker

### Langkah 1: Buat Dockerfile
```dockerfile
# Dockerfile
FROM rocker/shiny:latest

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install R packages
RUN R -e "install.packages(c('shiny', 'shinydashboard', 'tidyverse', 'DT'), repos='https://cran.rstudio.com/')"

# Copy aplikasi
COPY . /srv/shiny-server/hr-analytics

# Set permissions
RUN chown -R shiny:shiny /srv/shiny-server/hr-analytics

# Expose port
EXPOSE 3838

# Run aplikasi
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server/hr-analytics', host = '0.0.0.0', port = 3838)"]
```

### Langkah 2: Build dan Run Docker
```bash
# Build image
docker build -t hr-analytics-dashboard .

# Run container
docker run -p 3838:3838 hr-analytics-dashboard
```

### Langkah 3: Akses Dashboard
```
http://localhost:3838
```

## 🔧 Troubleshooting

### Masalah Umum

#### 1. Package Tidak Terinstall
```r
# Cek package yang terinstall
installed.packages()

# Install package yang diperlukan
install.packages(c("shiny", "shinydashboard", "tidyverse", "DT"))
```

#### 2. Error Deployment ke Shinyapps.io
```r
# Cek koneksi
rsconnect::showLogs()

# Re-authenticate
rsconnect::setAccountInfo(name='<ACCOUNT>',
                         token='<TOKEN>',
                         secret='<SECRET>')
```

#### 3. Permission Error di Shiny Server
```bash
# Set permissions yang benar
sudo chown -R shiny:shiny /srv/shiny-server/hr-analytics
sudo chmod -R 755 /srv/shiny-server/hr-analytics
```

#### 4. Port Already in Use
```bash
# Cek port yang digunakan
sudo netstat -tlnp | grep :3838

# Kill process yang menggunakan port
sudo kill -9 <PID>
```

### Log Files

#### Shinyapps.io
```r
# View logs
rsconnect::showLogs()
```

#### Shiny Server
```bash
# View logs
sudo tail -f /var/log/shiny-server.log
```

#### Heroku
```bash
# View logs
heroku logs --tail
```

## 📊 Monitoring

### Shinyapps.io
- Dashboard monitoring tersedia di dashboard shinyapps.io
- Cek usage dan performance

### Shiny Server
```bash
# Cek status service
sudo systemctl status shiny-server

# Restart service jika diperlukan
sudo systemctl restart shiny-server
```

### Heroku
```bash
# Cek status aplikasi
heroku ps

# Scale aplikasi jika diperlukan
heroku ps:scale web=1
```

## 🔒 Security

### HTTPS
- Shinyapps.io menyediakan HTTPS secara otomatis
- Untuk Shiny Server, setup SSL certificate

### Authentication
```r
# Tambahkan authentication di app.R
library(shinymanager)

# Setup credentials
credentials <- data.frame(
  user = c("admin", "user"),
  password = c("admin123", "user123"),
  stringsAsFactors = FALSE
)

# Wrap UI dengan secure_app
ui <- secure_app(ui, enable_admin = TRUE)
```

## 📈 Performance Optimization

### 1. Optimize Data Loading
```r
# Load data sekali di awal
hr_data <- reactive({
  read.csv("Data_HR.csv") %>%
    mutate(
      Attrition_Bin = ifelse(Attrition == "Yes", 1, 0),
      # ... other transformations
    )
})
```

### 2. Cache Expensive Computations
```r
# Use reactive expressions
attrition_summary <- reactive({
  hr_data() %>%
    group_by(Department) %>%
    summarise(
      Total = n(),
      Attrition_Rate = mean(Attrition_Bin) * 100
    )
})
```

### 3. Optimize Plots
```r
# Reduce plot complexity
output$plot_dept_summary <- renderPlot({
  attrition_summary() %>%
    ggplot(aes(x = reorder(Department, -Attrition_Rate), y = Attrition_Rate)) +
    geom_col() +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
})
```

## 🎯 Best Practices

1. **Backup Data**: Selalu backup dataset dan kode
2. **Version Control**: Gunakan Git untuk version control
3. **Testing**: Test aplikasi sebelum deployment
4. **Documentation**: Update dokumentasi setelah perubahan
5. **Monitoring**: Monitor performa aplikasi secara berkala

## 📞 Support

Jika mengalami masalah deployment, silakan:

1. Cek log files untuk error messages
2. Konsultasi dokumentasi platform yang digunakan
3. Hubungi support platform jika diperlukan
4. Buat issue di repository GitHub

---

**🎉 Selamat! Dashboard Anda sudah siap diakses secara online!** 