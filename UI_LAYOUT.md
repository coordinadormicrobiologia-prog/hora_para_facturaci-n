# App UI Layout - Visual Guide
# Guía Visual del Layout de la Aplicación

## Estructura de la Interfaz

```
┌─────────────────────────────────────────────────────────────────────────┐
│                                                                         │
│            Sistema de Gestión de Horas para Facturación                │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘

┌────────────────────────┬────────────────────────────────────────────────┐
│                        │                                                │
│  PANEL LATERAL         │          ÁREA PRINCIPAL                        │
│                        │                                                │
│ ┌────────────────────┐ │  ┌──────────────────────────────────────────┐ │
│ │ Nueva Entrada      │ │  │ Tabs:                                    │ │
│ │                    │ │  │ [Entradas] [Resumen] [Visualizaciones]   │ │
│ │ Cliente: _______   │ │  └──────────────────────────────────────────┘ │
│ │ Proyecto: ______   │ │                                                │
│ │ Fecha: [01/31/26]  │ │  ┌──────────────────────────────────────────┐ │
│ │ Horas: [___]       │ │  │                                          │ │
│ │ Tarifa: [___]      │ │  │     TABLA DE ENTRADAS                    │ │
│ │ Descripción:       │ │  │                                          │ │
│ │ [_____________]    │ │  │  Cliente  Proyecto  Fecha  Horas  Total │ │
│ │                    │ │  │  ────────────────────────────────────── │ │
│ │ [Agregar Entrada]  │ │  │  ABC      Web       01/15  8      $600  │ │
│ └────────────────────┘ │  │  ABC      Consult   01/20  4.5    $450  │ │
│                        │  │  XYZ      Audit     01/22  6      $510  │ │
│ ┌────────────────────┐ │  │                                          │ │
│ │ Exportar Datos     │ │  │  [Editar] [Eliminar] [Limpiar Todo]     │ │
│ │                    │ │  └──────────────────────────────────────────┘ │
│ │ [Descargar CSV]    │ │                                                │
│ │ [Descargar Excel]  │ │                                                │
│ └────────────────────┘ │                                                │
│                        │                                                │
│ ┌────────────────────┐ │                                                │
│ │ Filtros            │ │                                                │
│ │                    │ │                                                │
│ │ Fechas:            │ │                                                │
│ │ [01/01] - [01/31]  │ │                                                │
│ │                    │ │                                                │
│ │ Cliente:           │ │                                                │
│ │ [▼ Todos       ]   │ │                                                │
│ │                    │ │                                                │
│ │ Proyecto:          │ │                                                │
│ │ [▼ Todos       ]   │ │                                                │
│ └────────────────────┘ │                                                │
│                        │                                                │
└────────────────────────┴────────────────────────────────────────────────┘
```

## Tab 1: Entradas de Tiempo

```
┌─────────────────────────────────────────────────────────────────────────┐
│ Tabs: [Entradas de Tiempo] [Resumen de Facturación] [Visualizaciones]  │
└─────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────┐
│                                                                         │
│  Cliente    Proyecto       Fecha      Horas  Tarifa  Total  Descripción│
│  ────────────────────────────────────────────────────────────────────── │
│  Empresa ABC Desarrollo Web 2026-01-15  8.0   $75    $600  Landing page│
│  Empresa ABC Consultoría   2026-01-20  4.5  $100    $450  Planificación│
│  Corp XYZ    Auditoría     2026-01-22  6.0   $85    $510  Revisión     │
│  Startup     App Móvil     2026-01-25 10.0   $90    $900  UI Design    │
│  Corp XYZ    Auditoría     2026-01-28  7.5   $85    $638  Mejoras      │
│                                                                         │
│  < 1 2 3 > Mostrando 1 a 5 de 5 entradas                               │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘

         [Editar Seleccionada]  [Eliminar Seleccionada]  [Limpiar Todo]
```

## Tab 2: Resumen de Facturación

```
┌─────────────────────────────────────────────────────────────────────────┐
│ Tabs: [Entradas de Tiempo] [Resumen de Facturación] [Visualizaciones]  │
└─────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────┐
│  Resumen Total                                                          │
│  ─────────────────────────────────────────────────────────────────────  │
│                                                                         │
│  Total de Horas: 36 horas                                               │
│  Total a Facturar: $3,097.50                                            │
│  Tarifa Promedio: $87.00/hora                                           │
│  Número de Entradas: 5                                                  │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────┐
│  Resumen por Cliente                                                    │
│  ─────────────────────────────────────────────────────────────────────  │
│                                                                         │
│  Cliente      Horas Totales  Ingresos Totales  Tarifa Prom  Entradas   │
│  ──────────────────────────────────────────────────────────────────────│
│  Startup Tech      10.0           $900.00         $90.00        1      │
│  Empresa ABC       12.5         $1,050.00         $87.50        2      │
│  Corp XYZ          13.5         $1,147.50         $85.00        2      │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────┐
│  Resumen por Proyecto                                                   │
│  ─────────────────────────────────────────────────────────────────────  │
│                                                                         │
│  Proyecto        Cliente      Horas Totales  Ingresos Totales  Entradas│
│  ──────────────────────────────────────────────────────────────────────│
│  App Móvil       Startup Tech      10.0          $900.00           1   │
│  Auditoría       Corp XYZ          13.5        $1,147.50           2   │
│  Consultoría     Empresa ABC        4.5          $450.00           1   │
│  Desarrollo Web  Empresa ABC        8.0          $600.00           1   │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

## Tab 3: Visualizaciones

```
┌─────────────────────────────────────────────────────────────────────────┐
│ Tabs: [Entradas de Tiempo] [Resumen de Facturación] [Visualizaciones]  │
└─────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────┐
│  Horas por Cliente                                                      │
│  ─────────────────────────────────────────────────────────────────────  │
│                                                                         │
│  Corp XYZ        ████████████████ 13.5                                  │
│  Empresa ABC     ██████████████ 12.5                                    │
│  Startup Tech    ███████████ 10.0                                       │
│                                                                         │
│                  0    5    10   15   20   25                            │
│                       Horas Totales                                     │
└─────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────┐
│  Ingresos por Proyecto (Top 10)                                         │
│  ─────────────────────────────────────────────────────────────────────  │
│                                                                         │
│  Auditoría       ████████████████████ $1,147.50                         │
│  App Móvil       ████████████████ $900.00                               │
│  Desarrollo Web  ██████████ $600.00                                     │
│  Consultoría     ███████ $450.00                                        │
│                                                                         │
│                  $0  $250  $500  $750  $1000  $1250                     │
│                       Ingresos Totales ($)                              │
└─────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────┐
│  Tendencia de Horas en el Tiempo                                        │
│  ─────────────────────────────────────────────────────────────────────  │
│                                                                         │
│  10│                            ●                                       │
│    │                                                                    │
│   8│        ●                                                           │
│    │                                                                    │
│   6│                  ●                    ●                            │
│    │                                                                    │
│   4│                                                                    │
│    │                                                                    │
│   0└────┬────────┬────────┬────────┬────────┬────                      │
│       01/15    01/20    01/22    01/25    01/28                        │
│                         Fecha                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

## Características de la Interfaz

### Panel Lateral (Sidebar)
- **Ancho fijo**: ~25% del ancho de pantalla
- **Scroll independiente**: Si el contenido es largo
- **Siempre visible**: Acceso constante a funciones principales

### Área Principal (Main Panel)
- **Ancho flexible**: ~75% del ancho de pantalla
- **Tabs navegables**: 3 pestañas principales
- **Contenido dinámico**: Se actualiza automáticamente

### Colores y Estilo
- **Tema**: Bootstrap default (azul y blanco)
- **Botones primarios**: Azul (#007bff)
- **Gráficos**:
  - Horas por cliente: Azul acero (steelblue)
  - Ingresos por proyecto: Verde bosque (forestgreen)
  - Tendencia: Azul oscuro (darkblue)

### Interactividad
- **Tablas**: Selección de filas, ordenamiento por columnas
- **Filtros**: Actualización instantánea sin botón "Aplicar"
- **Gráficos**: Tooltips con información al pasar el mouse
- **Notificaciones**: Toast en esquina superior derecha

### Responsividad
- **Desktop**: Layout de dos columnas
- **Tablet**: Sidebar se colapsa
- **Mobile**: Vista de una columna

## Flujo de Usuario Típico

```
1. Usuario ingresa datos en Panel Lateral
   ↓
2. Hace clic en "Agregar Entrada"
   ↓
3. Tabla se actualiza automáticamente
   ↓
4. Usuario navega a tab "Resumen de Facturación"
   ↓
5. Ve resúmenes calculados automáticamente
   ↓
6. Usuario aplica filtros en Panel Lateral
   ↓
7. Todas las vistas se actualizan instantáneamente
   ↓
8. Usuario hace clic en "Descargar Excel"
   ↓
9. Archivo se descarga con datos filtrados
```

## Estados de la Interfaz

### Estado Inicial (Sin datos)
```
┌───────────────────────────────────┐
│                                   │
│  No hay entradas registradas      │
│                                   │
│  Agregue su primera entrada       │
│  usando el formulario lateral →   │
│                                   │
└───────────────────────────────────┘
```

### Estado con Datos
- Tabla poblada con entradas
- Resúmenes calculados
- Gráficos renderizados
- Filtros con opciones disponibles

### Estado de Carga
- Spinners durante procesamiento
- Mensajes de estado
- Barra de progreso para exportaciones

### Estado de Error
- Mensajes de error claros
- Sugerencias de solución
- No bloquea otras funcionalidades

## Accesibilidad

- **Contraste**: WCAG AA compliant
- **Navegación por teclado**: Tab, Enter, Flechas
- **Etiquetas**: Todos los campos tienen labels
- **Feedback**: Visual y textual para todas las acciones

## Rendimiento

- **Carga inicial**: < 2 segundos
- **Actualización de filtros**: < 100ms
- **Renderizado de gráficos**: < 500ms
- **Exportación**: Depende del tamaño de datos

## Personalización Futura

Elementos fácilmente personalizables:
1. Colores del tema (CSS)
2. Logo en el título
3. Idioma (traducción de strings)
4. Campos adicionales
5. Nuevas visualizaciones
6. Temas (light/dark)
