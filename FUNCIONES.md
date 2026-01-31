# Guía de Funciones Específicas
# Guide to Specific Functions in the Time Tracking App

## Resumen de Funciones Implementadas

Esta aplicación de Shiny incluye 13 funciones específicas principales, organizadas en dos archivos:
- **app.R**: Lógica de la aplicación y UI
- **utils.R**: Funciones utilitarias y de procesamiento

---

## Funciones en utils.R

### 1. create_time_entry()
**Propósito**: Crear una nueva entrada de tiempo con todos los campos necesarios.

**Parámetros**:
- `client`: Nombre del cliente (texto)
- `project`: Nombre del proyecto (texto)
- `date`: Fecha del trabajo (Date)
- `hours`: Horas trabajadas (numérico)
- `hourly_rate`: Tarifa por hora (numérico)
- `description`: Descripción opcional (texto)

**Retorna**: Data frame con una fila conteniendo la entrada

**Ejemplo de uso**:
```r
entrada <- create_time_entry(
  client = "Empresa ABC",
  project = "Desarrollo Web",
  date = as.Date("2026-01-31"),
  hours = 8,
  hourly_rate = 75,
  description = "Desarrollo de landing page"
)
```

---

### 2. calculate_billing_summary()
**Propósito**: Calcular resumen general de facturación.

**Parámetros**:
- `data`: Data frame con entradas de tiempo

**Retorna**: Lista con:
- `total_hours`: Total de horas trabajadas
- `total_revenue`: Total de ingresos
- `avg_rate`: Tarifa promedio por hora
- `num_entries`: Número de entradas

**Ejemplo de uso**:
```r
resumen <- calculate_billing_summary(time_data)
# Resultado: list(total_hours = 36, total_revenue = 3097.5, ...)
```

---

### 3. calculate_client_summary()
**Propósito**: Calcular resumen de facturación agrupado por cliente.

**Parámetros**:
- `data`: Data frame con entradas de tiempo

**Retorna**: Data frame con columnas:
- `client`: Nombre del cliente
- `total_hours`: Horas totales por cliente
- `total_revenue`: Ingresos totales por cliente
- `avg_rate`: Tarifa promedio por cliente
- `num_entries`: Número de entradas por cliente

**Características**:
- Ordenado por ingresos totales (descendente)
- Agrupación automática por cliente

---

### 4. calculate_project_summary()
**Propósito**: Calcular resumen de facturación agrupado por proyecto.

**Parámetros**:
- `data`: Data frame con entradas de tiempo

**Retorna**: Data frame con columnas:
- `project`: Nombre del proyecto
- `client`: Cliente asociado
- `total_hours`: Horas totales por proyecto
- `total_revenue`: Ingresos totales por proyecto
- `num_entries`: Número de entradas por proyecto

**Características**:
- Ordenado por ingresos totales (descendente)
- Mantiene relación proyecto-cliente

---

### 5. get_filtered_data()
**Propósito**: Filtrar entradas según múltiples criterios.

**Parámetros**:
- `data`: Data frame con entradas de tiempo
- `date_range`: Vector con fecha inicio y fecha fin
- `client_filter`: Cliente a filtrar ("all" para todos)
- `project_filter`: Proyecto a filtrar ("all" para todos)

**Retorna**: Data frame filtrado

**Ejemplo de uso**:
```r
filtrado <- get_filtered_data(
  data = time_data,
  date_range = c(as.Date("2026-01-01"), as.Date("2026-01-31")),
  client_filter = "Empresa ABC",
  project_filter = "all"
)
```

---

### 6. update_filter_choices()
**Propósito**: Actualizar dinámicamente las opciones de los filtros en la UI.

**Parámetros**:
- `session`: Sesión de Shiny
- `data`: Data frame con entradas de tiempo

**Efecto**: Actualiza los selectores de cliente y proyecto con valores únicos de los datos

**Uso**: Automático cuando se agregan/eliminan entradas

---

### 7. plot_hours_by_client()
**Propósito**: Generar gráfico de barras de horas trabajadas por cliente.

**Parámetros**:
- `data`: Data frame con entradas de tiempo

**Retorna**: Objeto ggplot2

**Características**:
- Barras horizontales ordenadas por horas
- Color: steelblue
- Título: "Horas Trabajadas por Cliente"

**Ejemplo de visualización**:
```
Empresa ABC      ████████████ 20h
Corporación XYZ  ████████ 13.5h
Startup Tech     ██████ 10h
```

---

### 8. plot_revenue_by_project()
**Propósito**: Generar gráfico de barras de ingresos por proyecto (top 10).

**Parámetros**:
- `data`: Data frame con entradas de tiempo

**Retorna**: Objeto ggplot2

**Características**:
- Muestra solo los 10 proyectos con mayores ingresos
- Barras horizontales ordenadas por ingresos
- Color: forestgreen
- Formato de moneda en eje Y

---

### 9. plot_hours_trend()
**Propósito**: Generar gráfico de línea mostrando tendencia de horas en el tiempo.

**Parámetros**:
- `data`: Data frame con entradas de tiempo

**Retorna**: Objeto ggplot2

**Características**:
- Línea con puntos
- Agrupación diaria de horas
- Color: darkblue
- Título: "Tendencia de Horas Trabajadas"

---

### 10. export_to_excel()
**Propósito**: Exportar datos a Excel con múltiples hojas.

**Parámetros**:
- `data`: Data frame con entradas de tiempo
- `filename`: Ruta del archivo de salida

**Genera**: Archivo Excel con 3 hojas:
1. "Entradas de Tiempo": Todas las entradas detalladas
2. "Resumen por Cliente": Resumen agrupado por cliente
3. "Resumen por Proyecto": Resumen agrupado por proyecto

**Ejemplo de uso**:
```r
export_to_excel(time_data, "facturacion_enero_2026.xlsx")
```

---

### 11. validate_time_entry()
**Propósito**: Validar entrada de tiempo antes de agregarla.

**Parámetros**:
- `client`: Nombre del cliente
- `project`: Nombre del proyecto
- `hours`: Horas trabajadas
- `hourly_rate`: Tarifa por hora

**Retorna**: Lista con:
- `valid`: TRUE si es válido, FALSE si no
- `errors`: Vector de mensajes de error

**Validaciones**:
- Cliente no vacío
- Proyecto no vacío
- Horas > 0
- Tarifa >= 0

---

### 12. search_entries()
**Propósito**: Buscar entradas por palabra clave.

**Parámetros**:
- `data`: Data frame con entradas de tiempo
- `keyword`: Palabra clave a buscar

**Retorna**: Data frame filtrado

**Busca en**:
- Nombre del cliente
- Nombre del proyecto
- Descripción

**Características**:
- Búsqueda case-insensitive
- Búsqueda parcial (encuentra subcadenas)

**Ejemplo de uso**:
```r
resultados <- search_entries(time_data, "desarrollo")
# Encuentra: "Desarrollo Web", "desarrollo de app", etc.
```

---

### 13. calculate_statistics()
**Propósito**: Calcular estadísticas generales del conjunto de datos.

**Parámetros**:
- `data`: Data frame con entradas de tiempo

**Retorna**: Lista con:
- `total_clients`: Número de clientes únicos
- `total_projects`: Número de proyectos únicos
- `avg_hours_per_entry`: Promedio de horas por entrada
- `max_hours_single_entry`: Máximo de horas en una entrada
- `min_hours_single_entry`: Mínimo de horas en una entrada
- `most_common_client`: Cliente con más entradas
- `date_range`: Rango de fechas de los datos

**Ejemplo de uso**:
```r
stats <- calculate_statistics(time_data)
# stats$total_clients: 3
# stats$avg_hours_per_entry: 7.2
# stats$most_common_client: "Empresa ABC"
```

---

## Funciones de la Interfaz (app.R)

### Observadores de Eventos

#### observeEvent(input$add_entry)
- Agrega nueva entrada de tiempo
- Valida datos de entrada
- Actualiza tabla y filtros
- Muestra notificación de éxito

#### observeEvent(input$delete_entry)
- Elimina entrada seleccionada
- Requiere selección en tabla
- Actualiza filtros
- Muestra notificación

#### observeEvent(input$clear_all)
- Limpia todas las entradas
- Requiere confirmación modal
- Reinicia datos completamente

### Outputs Reactivos

#### output$time_entries_table
- Tabla interactiva de entradas
- Selección de filas individual
- Paginación (10 por página)
- Columnas traducidas al español

#### output$billing_summary
- Resumen textual de facturación
- Actualización automática con filtros
- Formato de números con separadores

#### output$client_summary_table
- Tabla de resumen por cliente
- Paginación (5 por página)
- Ordenado por ingresos

#### output$project_summary_table
- Tabla de resumen por proyecto
- Paginación (5 por página)
- Incluye cliente asociado

#### output$hours_by_client_plot
- Gráfico de barras horizontales
- Actualización automática
- Solo se muestra si hay datos

#### output$revenue_by_project_plot
- Gráfico de ingresos por proyecto
- Top 10 proyectos
- Formato de moneda

#### output$hours_trend_plot
- Gráfico de línea temporal
- Agrupa horas por fecha
- Muestra tendencias

### Download Handlers

#### output$download_csv
- Descarga datos en formato CSV
- Nombre de archivo con fecha actual
- Incluye todos los datos filtrados

#### output$download_excel
- Descarga Excel con múltiples hojas
- Nombre de archivo con fecha actual
- 3 hojas: Entradas, Cliente, Proyecto

---

## Flujo de Datos en la Aplicación

```
1. Usuario ingresa datos → validate_time_entry()
                          ↓
2. Datos válidos → create_time_entry()
                          ↓
3. Entrada creada → Se agrega a time_data()
                          ↓
4. Actualización → update_filter_choices()
                          ↓
5. Visualización → get_filtered_data()
                          ↓
6. Renderizado → DT tables y ggplot2 charts
```

---

## Características Avanzadas

### Reactividad
- Todos los filtros son reactivos
- Gráficos se actualizan automáticamente
- Resúmenes recalculados en tiempo real

### Validación
- Validación de entrada de datos
- Prevención de datos inválidos
- Mensajes de error informativos

### Exportación
- Múltiples formatos (CSV, Excel)
- Nombres de archivo con timestamp
- Exportación de datos filtrados

### UI/UX
- Interfaz en español
- Notificaciones de acciones
- Confirmaciones para acciones destructivas
- Diseño responsivo con Bootstrap

---

## Requisitos de Paquetes

```r
shiny      # Framework de la aplicación
DT         # Tablas interactivas
ggplot2    # Gráficos
dplyr      # Manipulación de datos
lubridate  # Manejo de fechas
writexl    # Exportación a Excel
scales     # Formato de números
```

---

## Extensibilidad

La arquitectura modular permite fácil extensión:

1. **Nuevas funciones de cálculo**: Agregar en utils.R
2. **Nuevas visualizaciones**: Usar plantilla de plot_*()
3. **Nuevos filtros**: Agregar en sidebarPanel
4. **Nuevas exportaciones**: Crear nuevo downloadHandler

---

## Ejemplo de Sesión Completa

```r
# 1. Iniciar aplicación
library(shiny)
runApp()

# 2. Agregar entrada
# Cliente: "Empresa ABC"
# Proyecto: "Desarrollo Web"
# Horas: 8, Tarifa: 75
# → Total calculado: $600

# 3. Aplicar filtros
# Fecha: 2026-01-01 a 2026-01-31
# Cliente: "Empresa ABC"

# 4. Ver visualizaciones
# Tab "Visualizaciones" → Ver gráficos

# 5. Exportar datos
# Clic "Descargar Excel" → Archivo descargado
```

---

## Mejoras Futuras Sugeridas

1. Persistencia de datos (base de datos)
2. Autenticación de usuarios
3. Reportes en PDF
4. Integración con APIs de facturación
5. Predicción de ingresos con ML
6. Multi-idioma
7. Temas personalizables
8. Notificaciones por email
9. Backup automático
10. Dashboard ejecutivo
