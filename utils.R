# Utility Functions for Time Tracking and Billing App

library(dplyr)
library(ggplot2)
library(writexl)

# Function to create a new time entry
create_time_entry <- function(client, project, date, hours, hourly_rate, description = "") {
  data.frame(
    id = 0,  # Will be set by the calling function
    client = client,
    project = project,
    date = as.Date(date),
    hours = hours,
    hourly_rate = hourly_rate,
    total = hours * hourly_rate,
    description = description,
    stringsAsFactors = FALSE
  )
}

# Function to calculate billing summary
calculate_billing_summary <- function(data) {
  if (nrow(data) == 0) {
    return(list(
      total_hours = 0,
      total_revenue = 0,
      avg_rate = 0,
      num_entries = 0
    ))
  }
  
  list(
    total_hours = sum(data$hours, na.rm = TRUE),
    total_revenue = sum(data$total, na.rm = TRUE),
    avg_rate = mean(data$hourly_rate, na.rm = TRUE),
    num_entries = nrow(data)
  )
}

# Function to calculate summary by client
calculate_client_summary <- function(data) {
  data %>%
    group_by(client) %>%
    summarise(
      total_hours = sum(hours, na.rm = TRUE),
      total_revenue = sum(total, na.rm = TRUE),
      avg_rate = mean(hourly_rate, na.rm = TRUE),
      num_entries = n(),
      .groups = 'drop'
    ) %>%
    arrange(desc(total_revenue))
}

# Function to calculate summary by project
calculate_project_summary <- function(data) {
  data %>%
    group_by(project, client) %>%
    summarise(
      total_hours = sum(hours, na.rm = TRUE),
      total_revenue = sum(total, na.rm = TRUE),
      num_entries = n(),
      .groups = 'drop'
    ) %>%
    arrange(desc(total_revenue))
}

# Function to filter data based on date range and filters
get_filtered_data <- function(data, date_range, client_filter, project_filter) {
  if (nrow(data) == 0) {
    return(data)
  }
  
  # Filter by date range
  filtered <- data %>%
    filter(date >= date_range[1] & date <= date_range[2])
  
  # Filter by client
  if (client_filter != "all" && client_filter != "") {
    filtered <- filtered %>%
      filter(client == client_filter)
  }
  
  # Filter by project
  if (project_filter != "all" && project_filter != "") {
    filtered <- filtered %>%
      filter(project == project_filter)
  }
  
  return(filtered)
}

# Function to update filter choices
update_filter_choices <- function(session, data) {
  if (nrow(data) > 0) {
    clients <- c("Todos" = "all", unique(data$client))
    projects <- c("Todos" = "all", unique(data$project))
    
    updateSelectInput(session, "filter_client", choices = clients)
    updateSelectInput(session, "filter_project", choices = projects)
  }
}

# Plot: Hours by client
plot_hours_by_client <- function(data) {
  summary_data <- data %>%
    group_by(client) %>%
    summarise(total_hours = sum(hours, na.rm = TRUE), .groups = 'drop') %>%
    arrange(desc(total_hours))
  
  ggplot(summary_data, aes(x = reorder(client, total_hours), y = total_hours)) +
    geom_bar(stat = "identity", fill = "steelblue") +
    coord_flip() +
    labs(title = "Horas Trabajadas por Cliente",
         x = "Cliente",
         y = "Horas Totales") +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))
}

# Plot: Revenue by project
plot_revenue_by_project <- function(data) {
  summary_data <- data %>%
    group_by(project) %>%
    summarise(total_revenue = sum(total, na.rm = TRUE), .groups = 'drop') %>%
    arrange(desc(total_revenue)) %>%
    head(10)  # Top 10 projects
  
  ggplot(summary_data, aes(x = reorder(project, total_revenue), y = total_revenue)) +
    geom_bar(stat = "identity", fill = "forestgreen") +
    coord_flip() +
    labs(title = "Ingresos por Proyecto (Top 10)",
         x = "Proyecto",
         y = "Ingresos Totales ($)") +
    scale_y_continuous(labels = scales::dollar_format()) +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))
}

# Plot: Hours trend over time
plot_hours_trend <- function(data) {
  summary_data <- data %>%
    group_by(date) %>%
    summarise(total_hours = sum(hours, na.rm = TRUE), .groups = 'drop') %>%
    arrange(date)
  
  ggplot(summary_data, aes(x = date, y = total_hours)) +
    geom_line(color = "darkblue", size = 1) +
    geom_point(color = "darkblue", size = 2) +
    labs(title = "Tendencia de Horas Trabajadas",
         x = "Fecha",
         y = "Horas") +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))
}

# Function to export data to Excel with multiple sheets
export_to_excel <- function(data, filename) {
  if (nrow(data) == 0) {
    # Create empty workbook if no data
    write_xlsx(list("Entradas" = data.frame(Mensaje = "No hay datos")), filename)
    return()
  }
  
  # Prepare sheets
  sheets <- list(
    "Entradas de Tiempo" = data %>% 
      select(client, project, date, hours, hourly_rate, total, description),
    "Resumen por Cliente" = calculate_client_summary(data),
    "Resumen por Proyecto" = calculate_project_summary(data)
  )
  
  write_xlsx(sheets, filename)
}

# Function to validate time entry
validate_time_entry <- function(client, project, hours, hourly_rate) {
  errors <- c()
  
  if (is.null(client) || client == "") {
    errors <- c(errors, "El nombre del cliente es requerido")
  }
  
  if (is.null(project) || project == "") {
    errors <- c(errors, "El nombre del proyecto es requerido")
  }
  
  if (is.null(hours) || hours <= 0) {
    errors <- c(errors, "Las horas deben ser mayores a 0")
  }
  
  if (is.null(hourly_rate) || hourly_rate < 0) {
    errors <- c(errors, "La tarifa por hora no puede ser negativa")
  }
  
  return(list(
    valid = length(errors) == 0,
    errors = errors
  ))
}

# Function to search entries by keyword
search_entries <- function(data, keyword) {
  if (is.null(keyword) || keyword == "") {
    return(data)
  }
  
  keyword_lower <- tolower(keyword)
  
  data %>%
    filter(
      grepl(keyword_lower, tolower(client)) |
      grepl(keyword_lower, tolower(project)) |
      grepl(keyword_lower, tolower(description))
    )
}

# Function to calculate statistics
calculate_statistics <- function(data) {
  if (nrow(data) == 0) {
    return(NULL)
  }
  
  list(
    total_clients = length(unique(data$client)),
    total_projects = length(unique(data$project)),
    avg_hours_per_entry = mean(data$hours, na.rm = TRUE),
    max_hours_single_entry = max(data$hours, na.rm = TRUE),
    min_hours_single_entry = min(data$hours, na.rm = TRUE),
    most_common_client = names(sort(table(data$client), decreasing = TRUE))[1],
    date_range = paste(min(data$date), "to", max(data$date))
  )
}
