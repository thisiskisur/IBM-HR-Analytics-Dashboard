# ============================================
# DASHBOARD ANALISIS DATA HR IBM
# Dibuat oleh Rizky Surya Alfarizy untuk Laporan UAS Sistem Media Interaktif
# ============================================

# Load libraries yang diperlukan
library(shiny)
library(shinydashboard)
library(tidyverse)
library(DT)

# Load dan preprocessing data
hr <- read.csv("Data_HR.csv") %>%
  mutate(
    # Konversi Attrition ke binary
    Attrition_Bin = ifelse(Attrition == "Yes", 1, 0),
    
    # Kategorisasi usia
    AgeGroup = case_when(
      Age < 30 ~ "Muda (< 30)",
      Age < 40 ~ "Dewasa (30-39)",
      Age < 50 ~ "Senior (40-49)",
      TRUE ~ "Veteran (≥ 50)"
    ),
    
    # Kategorisasi gaji
    SalarySlab = case_when(
      MonthlyIncome < 3000 ~ "Rendah (< $3K)",
      MonthlyIncome < 6000 ~ "Menengah ($3K-$6K)",
      MonthlyIncome < 10000 ~ "Tinggi ($6K-$10K)",
      TRUE ~ "Sangat Tinggi (> $10K)"
    ),
    
    # Kategorisasi lama bekerja
    TenureGroup = case_when(
      YearsAtCompany < 2 ~ "Baru (< 2 tahun)",
      YearsAtCompany < 5 ~ "Menengah (2-5 tahun)",
      YearsAtCompany < 10 ~ "Senior (5-10 tahun)",
      TRUE ~ "Veteran (> 10 tahun)"
    )
  )

# ============================================
# USER INTERFACE (UI)
# ============================================

ui <- dashboardPage(
  skin = "blue",
  
  # Header Dashboard
  dashboardHeader(
    title = "Dashboard Analisis HR IBM",
    titleWidth = 350
  ),
  
  # Sidebar Menu
  dashboardSidebar(
    width = 250,
    sidebarMenu(
      menuItem("📊 Ringkasan Eksekutif", tabName = "ringkasan", icon = icon("dashboard")),
      menuItem("📈 Analisis Detail", tabName = "analisis", icon = icon("chart-line")),
      menuItem("👥 Demografi", tabName = "demografi", icon = icon("users")),
      menuItem("💰 Kompensasi", tabName = "kompensasi", icon = icon("money-bill")),
      menuItem("📋 Data Lengkap", tabName = "data", icon = icon("table")),
      menuItem("💡 Rekomendasi", tabName = "rekomendasi", icon = icon("lightbulb"))
    )
  ),
  
  # Body Dashboard
  dashboardBody(
    tabItems(
      
      # Tab 1: Ringkasan Eksekutif
      tabItem("ringkasan",
              fluidRow(
                # Value Boxes - Statistik Utama
                valueBoxOutput("total_karyawan", width = 3),
                valueBoxOutput("total_attrition", width = 3),
                valueBoxOutput("rate_attrition", width = 3),
                valueBoxOutput("usia_rata2", width = 3)
              ),
              fluidRow(
                # Grafik Ringkasan
                box(
                  title = "Tren Attrition per Departemen",
                  status = "primary",
                  solidHeader = TRUE,
                  plotOutput("plot_dept_summary", height = 300),
                  width = 6
                ),
                box(
                  title = "Distribusi Usia Karyawan",
                  status = "success",
                  solidHeader = TRUE,
                  plotOutput("plot_age_dist", height = 300),
                  width = 6
                )
              ),
              fluidRow(
                box(
                  title = "Ringkasan Statistik HR",
                  status = "info",
                  solidHeader = TRUE,
                  tableOutput("summary_stats"),
                  width = 12
                )
              )
      ),
      
      # Tab 2: Analisis Detail
      tabItem("analisis",
              fluidRow(
                box(
                  title = "Analisis Attrition per Kategori",
                  status = "primary",
                  solidHeader = TRUE,
                  plotOutput("plot_attrition_analysis", height = 400),
                  width = 8
                ),
                box(
                  title = "Faktor Risiko Attrition",
                  status = "warning",
                  solidHeader = TRUE,
                  plotOutput("plot_risk_factors", height = 400),
                  width = 4
                )
              ),
              fluidRow(
                box(
                  title = "Tren Attrition vs Lama Bekerja",
                  status = "info",
                  solidHeader = TRUE,
                  plotOutput("plot_tenure_trend", height = 300),
                  width = 6
                ),
                box(
                  title = "Attrition per Level Jabatan",
                  status = "danger",
                  solidHeader = TRUE,
                  plotOutput("plot_job_level", height = 300),
                  width = 6
                )
              )
      ),
      
      # Tab 3: Demografi
      tabItem("demografi",
              fluidRow(
                box(
                  title = "Distribusi Gender",
                  status = "primary",
                  solidHeader = TRUE,
                  plotOutput("plot_gender_dist", height = 300),
                  width = 6
                ),
                box(
                  title = "Distribusi Usia",
                  status = "success",
                  solidHeader = TRUE,
                  plotOutput("plot_age_group", height = 300),
                  width = 6
                )
              ),
              fluidRow(
                box(
                  title = "Pendidikan vs Attrition",
                  status = "info",
                  solidHeader = TRUE,
                  plotOutput("plot_education", height = 300),
                  width = 6
                ),
                box(
                  title = "Status Pernikahan vs Attrition",
                  status = "warning",
                  solidHeader = TRUE,
                  plotOutput("plot_marital", height = 300),
                  width = 6
                )
              )
      ),
      
      # Tab 4: Kompensasi
      tabItem("kompensasi",
              fluidRow(
                box(
                  title = "Distribusi Gaji Karyawan",
                  status = "primary",
                  solidHeader = TRUE,
                  plotOutput("plot_salary_dist", height = 300),
                  width = 6
                ),
                box(
                  title = "Attrition per Rentang Gaji",
                  status = "danger",
                  solidHeader = TRUE,
                  plotOutput("plot_salary_attrition", height = 300),
                  width = 6
                )
              ),
              fluidRow(
                box(
                  title = "Gaji vs Lama Bekerja",
                  status = "info",
                  solidHeader = TRUE,
                  plotOutput("plot_salary_tenure", height = 300),
                  width = 6
                ),
                box(
                  title = "Gaji vs Level Jabatan",
                  status = "success",
                  solidHeader = TRUE,
                  plotOutput("plot_salary_joblevel", height = 300),
                  width = 6
                )
              )
      ),
      
      # Tab 5: Data Lengkap
      tabItem("data",
              fluidRow(
                box(
                  title = "Dataset HR IBM - Seluruh Data Karyawan",
                  status = "primary",
                  solidHeader = TRUE,
                  width = 12,
                  DTOutput("data_hr")
                )
              )
      ),
      
      # Tab 6: Rekomendasi
      tabItem("rekomendasi",
              fluidRow(
                box(
                  title = "🎯 Rekomendasi Strategis",
                  status = "primary",
                  solidHeader = TRUE,
                  width = 12,
                  tags$div(
                    style = "font-size: 16px; line-height: 1.6;",
                    tags$h4("Berdasarkan Analisis Data HR IBM, Berikut Rekomendasi:"),
                    tags$br(),
                    tags$h5("1. 🏢 Manajemen Departemen"),
                    tags$ul(
                      tags$li("Fokus pada peningkatan retensi di departemen Research & Development"),
                      tags$li("Tinjau ulang kebijakan HR di departemen Sales"),
                      tags$li("Buat program khusus untuk departemen dengan attrition tinggi")
                    ),
                    tags$h5("2. 💰 Kebijakan Kompensasi"),
                    tags$ul(
                      tags$li("Tinjau kembali struktur gaji untuk karyawan dengan penghasilan < $3K"),
                      tags$li("Implementasi sistem bonus berbasis kinerja"),
                      tags$li("Buat program equity untuk karyawan senior")
                    ),
                    tags$h5("3. 👥 Program Pengembangan"),
                    tags$ul(
                      tags$li("Buat program onboarding dan mentoring untuk karyawan baru (< 2 tahun)"),
                      tags$li("Sesuaikan program pengembangan berdasarkan latar belakang pendidikan"),
                      tags$li("Implementasi sistem career path yang jelas")
                    ),
                    tags$h5("4. ⚖️ Kesetaraan Gender"),
                    tags$ul(
                      tags$li("Perhatikan kesenjangan gender dalam tingkat attrition"),
                      tags$li("Buat program khusus untuk mendukung diversity"),
                      tags$li("Evaluasi bias dalam sistem promosi")
                    ),
                    tags$h5("5. 📈 Sistem Promosi"),
                    tags$ul(
                      tags$li("Evaluasi sistem promosi untuk Job Level 1 dan 2"),
                      tags$li("Buat kriteria promosi yang transparan"),
                      tags$li("Implementasi sistem feedback berkala")
                    )
                  )
                )
              )
      )
    )
  )
)

# ============================================
# SERVER LOGIC
# ============================================

server <- function(input, output) {
  
  # Filter data attrition
  attr <- hr %>% filter(Attrition == "Yes")
  
  # ============================================
  # VALUE BOXES - Statistik Utama
  # ============================================
  
  output$total_karyawan <- renderValueBox({
    valueBox(
      value = format(nrow(hr), big.mark = ","),
      subtitle = "Total Karyawan",
      icon = icon("users"),
      color = "aqua"
    )
  })
  
  output$total_attrition <- renderValueBox({
    valueBox(
      value = sum(attr$Attrition_Bin),
      subtitle = "Karyawan Keluar",
      icon = icon("user-times"),
      color = "red"
    )
  })
  
  output$rate_attrition <- renderValueBox({
    rate <- round(mean(hr$Attrition_Bin) * 100, 1)
    valueBox(
      value = paste0(rate, "%"),
      subtitle = "Tingkat Attrition",
      icon = icon("percent"),
      color = "yellow"
    )
  })
  
  output$usia_rata2 <- renderValueBox({
    valueBox(
      value = round(mean(hr$Age), 1),
      subtitle = "Usia Rata-rata",
      icon = icon("birthday-cake"),
      color = "green"
    )
  })
  
  # ============================================
  # PLOTS - Ringkasan Eksekutif
  # ============================================
  
  output$plot_dept_summary <- renderPlot({
    hr %>%
      group_by(Department) %>%
      summarise(
        Total = n(),
        Attrition_Count = sum(Attrition_Bin),
        Attrition_Rate = mean(Attrition_Bin) * 100
      ) %>%
      ggplot(aes(x = reorder(Department, -Attrition_Rate), y = Attrition_Rate, fill = Department)) +
      geom_col() +
      geom_text(aes(label = paste0(round(Attrition_Rate, 1), "%")), vjust = -0.5) +
      labs(x = "Departemen", y = "Tingkat Attrition (%)", title = "") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            legend.position = "none")
  })
  
  output$plot_age_dist <- renderPlot({
    hr %>%
      count(AgeGroup) %>%
      ggplot(aes(x = AgeGroup, y = n, fill = AgeGroup)) +
      geom_col() +
      geom_text(aes(label = n), vjust = -0.5) +
      labs(x = "Kelompok Usia", y = "Jumlah Karyawan", title = "") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            legend.position = "none")
  })
  
  output$summary_stats <- renderTable({
    hr %>%
      summarise(
        "Total Karyawan" = n(),
        "Tingkat Attrition" = paste0(round(mean(Attrition_Bin) * 100, 1), "%"),
        "Usia Rata-rata" = round(mean(Age), 1),
        "Lama Bekerja Rata-rata" = round(mean(YearsAtCompany), 1),
        "Gaji Rata-rata" = paste0("$", format(round(mean(MonthlyIncome)), big.mark = ",")),
        "Jumlah Departemen" = n_distinct(Department),
        "Jumlah Job Level" = n_distinct(JobLevel)
      ) %>%
      t() %>%
      as.data.frame() %>%
      setNames("Nilai")
  }, rownames = TRUE, colnames = FALSE)
  
  # ============================================
  # PLOTS - Analisis Detail
  # ============================================
  
  output$plot_attrition_analysis <- renderPlot({
    hr %>%
      group_by(Department, Gender) %>%
      summarise(Attrition_Rate = mean(Attrition_Bin) * 100) %>%
      ggplot(aes(x = Department, y = Attrition_Rate, fill = Gender)) +
      geom_col(position = "dodge") +
      geom_text(aes(label = paste0(round(Attrition_Rate, 1), "%")), 
                position = position_dodge(width = 0.9), vjust = -0.5) +
      labs(x = "Departemen", y = "Tingkat Attrition (%)", title = "Attrition per Departemen dan Gender") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  output$plot_risk_factors <- renderPlot({
    risk_factors <- data.frame(
      Faktor = c("Gaji Rendah", "Lama Bekerja < 2 tahun", "Job Level 1", "Usia < 30"),
      Risiko = c(
        mean(hr$Attrition_Bin[hr$MonthlyIncome < 3000]) * 100,
        mean(hr$Attrition_Bin[hr$YearsAtCompany < 2]) * 100,
        mean(hr$Attrition_Bin[hr$JobLevel == 1]) * 100,
        mean(hr$Attrition_Bin[hr$Age < 30]) * 100
      )
    )
    
    risk_factors %>%
      ggplot(aes(x = reorder(Faktor, -Risiko), y = Risiko, fill = Risiko)) +
      geom_col() +
      geom_text(aes(label = paste0(round(Risiko, 1), "%")), vjust = -0.5) +
      labs(x = "Faktor Risiko", y = "Tingkat Attrition (%)", title = "Faktor Risiko Attrition") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            legend.position = "none")
  })
  
  output$plot_tenure_trend <- renderPlot({
    hr %>%
      group_by(YearsAtCompany) %>%
      summarise(Attrition_Rate = mean(Attrition_Bin) * 100) %>%
      ggplot(aes(x = YearsAtCompany, y = Attrition_Rate)) +
      geom_line(color = "blue", size = 1) +
      geom_point(color = "red", size = 3) +
      labs(x = "Tahun Bekerja", y = "Tingkat Attrition (%)", title = "Tren Attrition vs Lama Bekerja") +
      theme_minimal()
  })
  
  output$plot_job_level <- renderPlot({
    hr %>%
      group_by(JobLevel) %>%
      summarise(Attrition_Rate = mean(Attrition_Bin) * 100) %>%
      ggplot(aes(x = factor(JobLevel), y = Attrition_Rate, fill = factor(JobLevel))) +
      geom_col() +
      geom_text(aes(label = paste0(round(Attrition_Rate, 1), "%")), vjust = -0.5) +
      labs(x = "Job Level", y = "Tingkat Attrition (%)", title = "Attrition per Level Jabatan") +
      theme_minimal() +
      theme(legend.position = "none")
  })
  
  # ============================================
  # PLOTS - Demografi
  # ============================================
  
  output$plot_gender_dist <- renderPlot({
    hr %>%
      count(Gender) %>%
      mutate(Percentage = n / sum(n) * 100) %>%
      ggplot(aes(x = Gender, y = n, fill = Gender)) +
      geom_col() +
      geom_text(aes(label = paste0(n, " (", round(Percentage, 1), "%)")), vjust = -0.5) +
      labs(x = "Gender", y = "Jumlah Karyawan", title = "Distribusi Gender") +
      theme_minimal() +
      theme(legend.position = "none")
  })
  
  output$plot_age_group <- renderPlot({
    hr %>%
      count(AgeGroup) %>%
      mutate(Percentage = n / sum(n) * 100) %>%
      ggplot(aes(x = AgeGroup, y = n, fill = AgeGroup)) +
      geom_col() +
      geom_text(aes(label = paste0(n, " (", round(Percentage, 1), "%)")), vjust = -0.5) +
      labs(x = "Kelompok Usia", y = "Jumlah Karyawan", title = "Distribusi Usia") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            legend.position = "none")
  })
  
  output$plot_education <- renderPlot({
    hr %>%
      group_by(Education) %>%
      summarise(Attrition_Rate = mean(Attrition_Bin) * 100) %>%
      ggplot(aes(x = factor(Education), y = Attrition_Rate, fill = factor(Education))) +
      geom_col() +
      geom_text(aes(label = paste0(round(Attrition_Rate, 1), "%")), vjust = -0.5) +
      labs(x = "Tingkat Pendidikan", y = "Tingkat Attrition (%)", title = "Attrition per Tingkat Pendidikan") +
      theme_minimal() +
      theme(legend.position = "none")
  })
  
  output$plot_marital <- renderPlot({
    hr %>%
      group_by(MaritalStatus) %>%
      summarise(Attrition_Rate = mean(Attrition_Bin) * 100) %>%
      ggplot(aes(x = MaritalStatus, y = Attrition_Rate, fill = MaritalStatus)) +
      geom_col() +
      geom_text(aes(label = paste0(round(Attrition_Rate, 1), "%")), vjust = -0.5) +
      labs(x = "Status Pernikahan", y = "Tingkat Attrition (%)", title = "Attrition per Status Pernikahan") +
      theme_minimal() +
      theme(legend.position = "none")
  })
  
  # ============================================
  # PLOTS - Kompensasi
  # ============================================
  
  output$plot_salary_dist <- renderPlot({
    hr %>%
      count(SalarySlab) %>%
      ggplot(aes(x = SalarySlab, y = n, fill = SalarySlab)) +
      geom_col() +
      geom_text(aes(label = n), vjust = -0.5) +
      labs(x = "Rentang Gaji", y = "Jumlah Karyawan", title = "Distribusi Gaji Karyawan") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            legend.position = "none")
  })
  
  output$plot_salary_attrition <- renderPlot({
    hr %>%
      group_by(SalarySlab) %>%
      summarise(Attrition_Rate = mean(Attrition_Bin) * 100) %>%
      ggplot(aes(x = SalarySlab, y = Attrition_Rate, fill = SalarySlab)) +
      geom_col() +
      geom_text(aes(label = paste0(round(Attrition_Rate, 1), "%")), vjust = -0.5) +
      labs(x = "Rentang Gaji", y = "Tingkat Attrition (%)", title = "Attrition per Rentang Gaji") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            legend.position = "none")
  })
  
  output$plot_salary_tenure <- renderPlot({
    hr %>%
      group_by(TenureGroup) %>%
      summarise(Avg_Salary = mean(MonthlyIncome)) %>%
      ggplot(aes(x = TenureGroup, y = Avg_Salary, fill = TenureGroup)) +
      geom_col() +
      geom_text(aes(label = paste0("$", format(round(Avg_Salary), big.mark = ","))), vjust = -0.5) +
      labs(x = "Kelompok Lama Bekerja", y = "Gaji Rata-rata ($)", title = "Gaji vs Lama Bekerja") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            legend.position = "none")
  })
  
  output$plot_salary_joblevel <- renderPlot({
    hr %>%
      group_by(JobLevel) %>%
      summarise(Avg_Salary = mean(MonthlyIncome)) %>%
      ggplot(aes(x = factor(JobLevel), y = Avg_Salary, fill = factor(JobLevel))) +
      geom_col() +
      geom_text(aes(label = paste0("$", format(round(Avg_Salary), big.mark = ","))), vjust = -0.5) +
      labs(x = "Job Level", y = "Gaji Rata-rata ($)", title = "Gaji vs Level Jabatan") +
      theme_minimal() +
      theme(legend.position = "none")
  })
  
  # ============================================
  # DATA TABLE
  # ============================================
  
  output$data_hr <- renderDT({
    datatable(
      hr,
      options = list(
        pageLength = 15,
        scrollX = TRUE
      ),
      caption = "Dataset HR IBM - Data Lengkap Karyawan"
    )
  })
}

# ============================================
# JALANKAN APLIKASI
# ============================================

shinyApp(ui, server)