# Sistema de Gestión de Horas para Facturación

Una aplicación Shiny desarrollada en R para gestionar el seguimiento de horas de trabajo y facturación por proyecto y cliente.

## Características

### Funciones Principales

1. **Gestión de Entradas de Tiempo**
   - Agregar nuevas entradas de tiempo con cliente, proyecto, fecha, horas y tarifa
   - Editar entradas existentes
   - Eliminar entradas individuales o todas las entradas
   - Descripción detallada de cada entrada

2. **Cálculo de Facturación**
   - Cálculo automático del total a facturar (horas × tarifa)
   - Resumen total de horas y facturación
   - Tarifa promedio calculada
   - Resúmenes por cliente y por proyecto

3. **Filtros y Búsqueda**
   - Filtrar por rango de fechas
   - Filtrar por cliente específico
   - Filtrar por proyecto específico
   - Combinación de múltiples filtros

4. **Visualizaciones**
   - Gráfico de horas trabajadas por cliente
   - Gráfico de ingresos por proyecto
   - Tendencia de horas en el tiempo

5. **Exportación de Datos**
   - Exportar a CSV
   - Exportar a Excel con múltiples hojas:
     - Entradas de tiempo detalladas
     - Resumen por cliente
     - Resumen por proyecto

## Instalación

### Requisitos Previos

- R (versión 3.5.0 o superior)
- RStudio (recomendado)

### Instalación de Paquetes

```r
# Instalar paquetes necesarios
install.packages(c(
  "shiny",
  "DT",
  "ggplot2",
  "dplyr",
  "lubridate",
  "writexl",
  "scales"
))
```

## Uso

### Iniciar la Aplicación

#### Opción 1: Desde RStudio
1. Abrir el archivo `app.R` en RStudio
2. Hacer clic en el botón "Run App" en la esquina superior derecha

#### Opción 2: Desde la consola de R
```r
library(shiny)
runApp("/ruta/a/la/aplicacion")
```

#### Opción 3: Directamente desde GitHub
```r
library(shiny)
runGitHub("hora_para_facturaci-n", "coordinadormicrobiologia-prog")
```

### Flujo de Trabajo

1. **Agregar Entradas de Tiempo**
   - Complete los campos en el panel lateral:
     - Nombre del Cliente
     - Nombre del Proyecto
     - Fecha de trabajo
     - Horas trabajadas
     - Tarifa por hora
     - Descripción (opcional)
   - Haga clic en "Agregar Entrada"

2. **Ver y Gestionar Entradas**
   - En la pestaña "Entradas de Tiempo", verá todas sus entradas
   - Seleccione una fila y use los botones para:
     - Editar la entrada seleccionada
     - Eliminar la entrada seleccionada
     - Limpiar todas las entradas

3. **Analizar Facturación**
   - Vaya a la pestaña "Resumen de Facturación"
   - Vea el resumen total, por cliente y por proyecto

4. **Visualizar Datos**
   - Vaya a la pestaña "Visualizaciones"
   - Explore gráficos de:
     - Horas por cliente
     - Ingresos por proyecto
     - Tendencia de horas

5. **Exportar Datos**
   - Use los botones "Descargar CSV" o "Descargar Excel"
   - Los archivos se guardarán con la fecha actual

## Estructura del Proyecto

```
hora_para_facturaci-n/
├── app.R           # Archivo principal de la aplicación Shiny
├── utils.R         # Funciones utilitarias
├── DESCRIPTION     # Descripción del paquete
├── README.md       # Este archivo
└── .gitignore      # Archivos a ignorar en git
```

## Funciones Específicas Implementadas

### En `utils.R`

1. **create_time_entry()**: Crea una nueva entrada de tiempo
2. **calculate_billing_summary()**: Calcula resumen total de facturación
3. **calculate_client_summary()**: Calcula resumen por cliente
4. **calculate_project_summary()**: Calcula resumen por proyecto
5. **get_filtered_data()**: Filtra datos según criterios
6. **update_filter_choices()**: Actualiza opciones de filtros dinámicamente
7. **plot_hours_by_client()**: Genera gráfico de horas por cliente
8. **plot_revenue_by_project()**: Genera gráfico de ingresos por proyecto
9. **plot_hours_trend()**: Genera gráfico de tendencia temporal
10. **export_to_excel()**: Exporta datos a Excel con múltiples hojas
11. **validate_time_entry()**: Valida entradas de tiempo
12. **search_entries()**: Busca entradas por palabra clave
13. **calculate_statistics()**: Calcula estadísticas generales

## Ejemplos de Uso

### Ejemplo 1: Agregar una entrada
```r
# Los datos se ingresan a través de la interfaz
# Cliente: "Empresa ABC"
# Proyecto: "Desarrollo Web"
# Fecha: 2026-01-31
# Horas: 8
# Tarifa: 75
# Total calculado automáticamente: 600
```

### Ejemplo 2: Filtrar por fechas
```r
# Use el selector de rango de fechas en el panel lateral
# Ejemplo: Desde 2026-01-01 hasta 2026-01-31
# La tabla se actualizará automáticamente
```

### Ejemplo 3: Exportar datos
```r
# Haga clic en "Descargar Excel"
# Se generará un archivo con el nombre:
# horas_facturacion_20260131.xlsx
# Con tres hojas: Entradas, Resumen Cliente, Resumen Proyecto
```

## Personalización

### Modificar la tarifa predeterminada
En `app.R`, línea con `numericInput("hourly_rate"...)`:
```r
numericInput("hourly_rate", "Tarifa por Hora ($):", value = 50, min = 0)
# Cambie 'value = 50' al valor deseado
```

### Modificar colores de gráficos
En `utils.R`, en las funciones `plot_*()`:
```r
# Cambiar "steelblue" a otro color
geom_bar(stat = "identity", fill = "steelblue")
```

## Solución de Problemas

### Error: Paquete no encontrado
```r
# Reinstalar el paquete faltante
install.packages("nombre_del_paquete")
```

### La aplicación no se inicia
- Verifique que todos los archivos (`app.R` y `utils.R`) estén en el mismo directorio
- Asegúrese de que todos los paquetes estén instalados

### Los gráficos no se muestran
- Verifique que haya datos ingresados
- Asegúrese de que el rango de fechas incluya sus entradas

## Contribuciones

Las contribuciones son bienvenidas. Por favor, abra un issue o pull request.

## Licencia

MIT License

## Contacto

coordinadormicrobiologia@sanbritanico.com.ar

## Historial de Versiones

### Versión 1.0.0 (2026-01-31)
- Lanzamiento inicial
- Gestión completa de entradas de tiempo
- Cálculos de facturación
- Visualizaciones interactivas
- Exportación a CSV y Excel
- Sistema de filtros