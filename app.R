# Aplicación Shiny para Gestión de Horas de Facturación
# App: Time Tracking and Billing Management

library(shiny)
library(DT)
library(ggplot2)
library(dplyr)
library(lubridate)
library(writexl)

# Source utility functions
source("utils.R")

# UI Definition
ui <- fluidPage(
  titlePanel("Sistema de Gestión de Horas para Facturación"),
  
  sidebarLayout(
    sidebarPanel(
      h3("Nueva Entrada de Tiempo"),
      
      textInput("client_name", "Nombre del Cliente:", ""),
      textInput("project_name", "Proyecto:", ""),
      dateInput("work_date", "Fecha:", value = Sys.Date()),
      numericInput("hours", "Horas Trabajadas:", value = 1, min = 0.25, step = 0.25),
      numericInput("hourly_rate", "Tarifa por Hora ($):", value = 50, min = 0),
      textAreaInput("description", "Descripción:", "", rows = 3),
      
      actionButton("add_entry", "Agregar Entrada", class = "btn-primary"),
      hr(),
      
      h3("Exportar Datos"),
      downloadButton("download_csv", "Descargar CSV"),
      downloadButton("download_excel", "Descargar Excel"),
      hr(),
      
      h3("Filtros"),
      dateRangeInput("date_range", "Rango de Fechas:",
                     start = Sys.Date() - 30,
                     end = Sys.Date()),
      selectInput("filter_client", "Filtrar por Cliente:",
                  choices = c("Todos" = "all")),
      selectInput("filter_project", "Filtrar por Proyecto:",
                  choices = c("Todos" = "all"))
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Entradas de Tiempo",
                 br(),
                 DTOutput("time_entries_table"),
                 br(),
                 fluidRow(
                   column(4, actionButton("edit_entry", "Editar Seleccionada")),
                   column(4, actionButton("delete_entry", "Eliminar Seleccionada")),
                   column(4, actionButton("clear_all", "Limpiar Todo"))
                 )),
        
        tabPanel("Resumen de Facturación",
                 br(),
                 h3("Resumen Total"),
                 verbatimTextOutput("billing_summary"),
                 br(),
                 h3("Resumen por Cliente"),
                 DTOutput("client_summary_table"),
                 br(),
                 h3("Resumen por Proyecto"),
                 DTOutput("project_summary_table")),
        
        tabPanel("Visualizaciones",
                 br(),
                 h3("Horas por Cliente"),
                 plotOutput("hours_by_client_plot"),
                 br(),
                 h3("Ingresos por Proyecto"),
                 plotOutput("revenue_by_project_plot"),
                 br(),
                 h3("Tendencia de Horas en el Tiempo"),
                 plotOutput("hours_trend_plot"))
      )
    )
  )
)

# Server Logic
server <- function(input, output, session) {
  
  # Reactive values to store time entries
  time_data <- reactiveVal(data.frame(
    id = integer(),
    client = character(),
    project = character(),
    date = as.Date(character()),
    hours = numeric(),
    hourly_rate = numeric(),
    total = numeric(),
    description = character(),
    stringsAsFactors = FALSE
  ))
  
  # Add entry function
  observeEvent(input$add_entry, {
    req(input$client_name, input$project_name, input$hours)
    
    new_entry <- create_time_entry(
      client = input$client_name,
      project = input$project_name,
      date = input$work_date,
      hours = input$hours,
      hourly_rate = input$hourly_rate,
      description = input$description
    )
    
    current_data <- time_data()
    new_entry$id <- ifelse(nrow(current_data) == 0, 1, max(current_data$id) + 1)
    
    updated_data <- rbind(current_data, new_entry)
    time_data(updated_data)
    
    # Update filter choices
    update_filter_choices(session, updated_data)
    
    showNotification("Entrada agregada exitosamente", type = "message")
  })
  
  # Delete entry function
  observeEvent(input$delete_entry, {
    selected_row <- input$time_entries_table_rows_selected
    if (length(selected_row) > 0) {
      current_data <- time_data()
      filtered_data <- get_filtered_data(current_data, input$date_range, 
                                         input$filter_client, input$filter_project)
      entry_to_delete <- filtered_data[selected_row, ]
      
      updated_data <- current_data[current_data$id != entry_to_delete$id, ]
      time_data(updated_data)
      
      update_filter_choices(session, updated_data)
      showNotification("Entrada eliminada", type = "warning")
    } else {
      showNotification("Por favor seleccione una entrada para eliminar", type = "error")
    }
  })
  
  # Clear all entries
  observeEvent(input$clear_all, {
    showModal(modalDialog(
      title = "Confirmar",
      "¿Está seguro que desea eliminar todas las entradas?",
      footer = tagList(
        modalButton("Cancelar"),
        actionButton("confirm_clear", "Sí, eliminar todo")
      )
    ))
  })
  
  observeEvent(input$confirm_clear, {
    time_data(data.frame(
      id = integer(),
      client = character(),
      project = character(),
      date = as.Date(character()),
      hours = numeric(),
      hourly_rate = numeric(),
      total = numeric(),
      description = character(),
      stringsAsFactors = FALSE
    ))
    removeModal()
    showNotification("Todas las entradas han sido eliminadas", type = "warning")
  })
  
  # Get filtered data
  filtered_data <- reactive({
    get_filtered_data(time_data(), input$date_range, 
                     input$filter_client, input$filter_project)
  })
  
  # Update filter choices when data changes
  observe({
    update_filter_choices(session, time_data())
  })
  
  # Render time entries table
  output$time_entries_table <- renderDT({
    data <- filtered_data()
    if (nrow(data) > 0) {
      display_data <- data %>%
        select(client, project, date, hours, hourly_rate, total, description)
      
      datatable(display_data,
                options = list(pageLength = 10, scrollX = TRUE),
                selection = "single",
                rownames = FALSE,
                colnames = c("Cliente", "Proyecto", "Fecha", "Horas", 
                           "Tarifa/Hora", "Total", "Descripción"))
    } else {
      datatable(data.frame(Mensaje = "No hay entradas registradas"))
    }
  })
  
  # Billing summary
  output$billing_summary <- renderText({
    data <- filtered_data()
    if (nrow(data) > 0) {
      summary <- calculate_billing_summary(data)
      paste0(
        "Total de Horas: ", round(summary$total_hours, 2), " horas\n",
        "Total a Facturar: $", format(summary$total_revenue, big.mark = ",", nsmall = 2), "\n",
        "Tarifa Promedio: $", format(summary$avg_rate, big.mark = ",", nsmall = 2), "/hora\n",
        "Número de Entradas: ", summary$num_entries
      )
    } else {
      "No hay datos para mostrar"
    }
  })
  
  # Client summary table
  output$client_summary_table <- renderDT({
    data <- filtered_data()
    if (nrow(data) > 0) {
      summary <- calculate_client_summary(data)
      datatable(summary,
                options = list(pageLength = 5, scrollX = TRUE),
                rownames = FALSE,
                colnames = c("Cliente", "Horas Totales", "Ingresos Totales", 
                           "Tarifa Promedio", "Num. Entradas"))
    }
  })
  
  # Project summary table
  output$project_summary_table <- renderDT({
    data <- filtered_data()
    if (nrow(data) > 0) {
      summary <- calculate_project_summary(data)
      datatable(summary,
                options = list(pageLength = 5, scrollX = TRUE),
                rownames = FALSE,
                colnames = c("Proyecto", "Cliente", "Horas Totales", 
                           "Ingresos Totales", "Num. Entradas"))
    }
  })
  
  # Visualizations
  output$hours_by_client_plot <- renderPlot({
    data <- filtered_data()
    if (nrow(data) > 0) {
      plot_hours_by_client(data)
    }
  })
  
  output$revenue_by_project_plot <- renderPlot({
    data <- filtered_data()
    if (nrow(data) > 0) {
      plot_revenue_by_project(data)
    }
  })
  
  output$hours_trend_plot <- renderPlot({
    data <- filtered_data()
    if (nrow(data) > 0) {
      plot_hours_trend(data)
    }
  })
  
  # Download handlers
  output$download_csv <- downloadHandler(
    filename = function() {
      paste0("horas_facturacion_", format(Sys.Date(), "%Y%m%d"), ".csv")
    },
    content = function(file) {
      write.csv(filtered_data(), file, row.names = FALSE)
    }
  )
  
  output$download_excel <- downloadHandler(
    filename = function() {
      paste0("horas_facturacion_", format(Sys.Date(), "%Y%m%d"), ".xlsx")
    },
    content = function(file) {
      export_to_excel(filtered_data(), file)
    }
  )
}

# Run the application
shinyApp(ui = ui, server = server)
