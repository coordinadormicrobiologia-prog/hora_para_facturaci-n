# Guía de Inicio Rápido
# Quick Start Guide

## ¡Bienvenido al Sistema de Gestión de Horas para Facturación!

Esta guía te ayudará a comenzar a usar la aplicación en 5 minutos.

---

## Paso 1: Instalar Dependencias (Solo Primera Vez)

Abre R o RStudio y ejecuta:

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

**Tiempo estimado**: 2-3 minutos

---

## Paso 2: Iniciar la Aplicación

### Opción A: Desde RStudio (Recomendado)
1. Abrir el archivo `app.R`
2. Hacer clic en "Run App" (botón verde en la esquina superior derecha)
3. La aplicación se abrirá en una ventana nueva o en el navegador

### Opción B: Desde la Consola de R
```r
library(shiny)
setwd("/ruta/a/la/aplicacion")  # Cambiar a tu ruta
runApp()
```

---

## Paso 3: Primera Entrada de Tiempo (30 segundos)

En el panel lateral izquierdo:

1. **Nombre del Cliente**: Escribe el nombre (ej: "Empresa ABC")
2. **Proyecto**: Escribe el proyecto (ej: "Desarrollo Web")
3. **Fecha**: Selecciona la fecha (por defecto hoy)
4. **Horas Trabajadas**: Ingresa las horas (ej: 8)
5. **Tarifa por Hora**: Ingresa tu tarifa (ej: 75)
6. **Descripción**: Opcional - describe el trabajo
7. Haz clic en **"Agregar Entrada"**

✅ ¡Listo! Verás tu primera entrada en la tabla.

---

## Paso 4: Explorar las Pestañas

### Pestaña 1: "Entradas de Tiempo"
- Ver todas tus entradas en una tabla
- Seleccionar filas para editar o eliminar
- Ver datos actualizados en tiempo real

### Pestaña 2: "Resumen de Facturación"
- **Resumen Total**: Horas totales y monto a facturar
- **Por Cliente**: Cuánto facturaste a cada cliente
- **Por Proyecto**: Cuánto generó cada proyecto

### Pestaña 3: "Visualizaciones"
- **Gráfico 1**: Horas por cliente (barras horizontales)
- **Gráfico 2**: Ingresos por proyecto (top 10)
- **Gráfico 3**: Tendencia de horas en el tiempo

---

## Paso 5: Usar Filtros

En el panel lateral, sección "Filtros":

1. **Rango de Fechas**: Selecciona inicio y fin
   - Por defecto: últimos 30 días
   - Cambia según necesites

2. **Filtrar por Cliente**: Selecciona un cliente específico
   - "Todos" muestra todos los clientes

3. **Filtrar por Proyecto**: Selecciona un proyecto específico
   - "Todos" muestra todos los proyectos

Los filtros se aplican automáticamente a:
- Tabla de entradas
- Todos los resúmenes
- Todas las visualizaciones
- Archivos exportados

---

## Paso 6: Exportar Datos

### Exportar a CSV
1. Haz clic en **"Descargar CSV"**
2. Se descarga un archivo: `horas_facturacion_YYYYMMDD.csv`
3. Ábrelo con Excel, Google Sheets, etc.

### Exportar a Excel
1. Haz clic en **"Descargar Excel"**
2. Se descarga un archivo: `horas_facturacion_YYYYMMDD.xlsx`
3. El archivo contiene 3 hojas:
   - Entradas de Tiempo
   - Resumen por Cliente
   - Resumen por Proyecto

---

## Casos de Uso Comunes

### Caso 1: Facturación Mensual
```
1. Establecer filtro de fechas: 1º del mes al último día
2. Ir a pestaña "Resumen de Facturación"
3. Ver "Resumen Total" → Este es tu monto a facturar
4. Descargar Excel para adjuntar a facturas
```

### Caso 2: Reporte por Cliente
```
1. Filtrar por cliente específico
2. Ir a pestaña "Resumen de Facturación"
3. Ver "Resumen por Proyecto" para ese cliente
4. Descargar Excel para enviar al cliente
```

### Caso 3: Análisis de Productividad
```
1. Ir a pestaña "Visualizaciones"
2. Ver "Tendencia de Horas en el Tiempo"
3. Identificar días/períodos más productivos
4. Ajustar planificación según tendencias
```

### Caso 4: Múltiples Entradas Diarias
```
1. Para cada tarea del día:
   - Agregar entrada con horas específicas
   - Usar descripciones detalladas
2. Al final del día:
   - Filtrar por fecha de hoy
   - Ver resumen de horas trabajadas
```

---

## Atajos y Tips

### ⌨️ Atajos de Teclado (en campos de entrada)
- `Tab`: Moverse al siguiente campo
- `Shift + Tab`: Moverse al campo anterior
- `Enter`: En el último campo, equivale a "Agregar Entrada"

### 💡 Tips de Uso
1. **Usa descripciones claras**: Te ayudarán a recordar qué hiciste
2. **Registra tiempo diariamente**: Evita olvidar horas trabajadas
3. **Revisa el resumen semanalmente**: Mantente al tanto de tus ingresos
4. **Exporta mensualmente**: Mantén backups de tus datos
5. **Usa filtros para análisis**: Identifica tus mejores clientes/proyectos

### 🎯 Mejores Prácticas
1. **Nombres consistentes**: Usa siempre el mismo nombre para cada cliente
2. **Proyectos específicos**: Crea proyectos distintos para tareas diferentes
3. **Horas en decimales**: Usa 0.25 para 15 min, 0.5 para 30 min, etc.
4. **Tarifas por proyecto**: Puedes usar diferentes tarifas para diferentes trabajos
5. **Backup regular**: Descarga Excel al menos una vez al mes

---

## Solución Rápida de Problemas

### ❌ "Paquete no encontrado"
```r
# Instalar el paquete faltante
install.packages("nombre_paquete")
```

### ❌ "Error al cargar utils.R"
- Verifica que `app.R` y `utils.R` estén en la misma carpeta
- Verifica que tu working directory sea correcto

### ❌ "No veo mis datos"
- Revisa los filtros de fecha (pueden estar excluyendo tus entradas)
- Cambia a "Todos" en filtros de cliente y proyecto

### ❌ "El gráfico no se muestra"
- Necesitas al menos una entrada para ver gráficos
- Verifica que el filtro de fechas incluya tus entradas

### ❌ "No puedo eliminar entrada"
- Asegúrate de seleccionar una fila en la tabla primero
- Haz clic en la fila para resaltarla, luego en "Eliminar"

---

## Próximos Pasos

Una vez que domines lo básico:

1. **Personaliza tarifas**: Ajusta tarifas por tipo de proyecto
2. **Crea categorías**: Usa nombres de proyectos como categorías
3. **Análisis avanzado**: Combina filtros para insights profundos
4. **Automatiza reportes**: Programa exportaciones regulares
5. **Comparte con equipo**: Exporta para compartir con contadores/gestión

---

## Recursos Adicionales

- **README.md**: Documentación completa
- **FUNCIONES.md**: Guía técnica de todas las funciones
- **example_data.R**: Datos de ejemplo para practicar

---

## Soporte

Si tienes problemas o preguntas:
- Revisa el README.md
- Consulta FUNCIONES.md para detalles técnicos
- Contacta: coordinadormicrobiologia@sanbritanico.com.ar

---

## ¡Empieza Ahora!

```r
# Copia y pega esto en R/RStudio:
library(shiny)
runApp()
```

**¡Feliz facturación! 💰📊**
