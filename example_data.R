# Example Data Generator for Testing
# This file demonstrates how to use the application with sample data

# Sample data that can be used for testing the application
example_entries <- data.frame(
  id = 1:5,
  client = c("Empresa ABC", "Empresa ABC", "Corporación XYZ", 
             "Startup Tech", "Corporación XYZ"),
  project = c("Desarrollo Web", "Consultoría", "Auditoría", 
              "App Móvil", "Auditoría"),
  date = as.Date(c("2026-01-15", "2026-01-20", "2026-01-22", 
                   "2026-01-25", "2026-01-28")),
  hours = c(8, 4.5, 6, 10, 7.5),
  hourly_rate = c(75, 100, 85, 90, 85),
  total = c(600, 450, 510, 900, 637.5),
  description = c(
    "Desarrollo de landing page",
    "Reunión de planificación estratégica",
    "Revisión de procesos internos",
    "Diseño de interfaz de usuario",
    "Implementación de mejoras"
  ),
  stringsAsFactors = FALSE
)

# You can load this data into the app for testing
# save(example_entries, file = "example_data.RData")

# Expected results for testing:
# Total Hours: 36 hours
# Total Revenue: $3,097.50
# Average Rate: $87/hour
# Number of Entries: 5
# Unique Clients: 3
# Unique Projects: 4
