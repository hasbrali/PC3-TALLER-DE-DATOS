# PC3-INGRESOS POR IDIOMA

## Descripción del proyecto
Este repositorio incluye el código y el flujo de trabajo completo para el procesamiento de la **Práctica Calificada 3 (PC3)** del curso **Taller de Procesamiento de Datos**. 

El objetivo principal del proyecto es analizar los **ingresos de los jefes de familia** en el Perú utilizando los datos oficiales de la **Encuesta Nacional de Hogares (ENAHO) 2024**. El análisis integra factores de empleo, condiciones de salud e ingresos para evaluar las brechas socioeconómicas.

## Programas y librerías utilizadas
El proyecto está desarrollado utilizando la versión **4.5.3** de R, controlando la reproducibilidad del entorno a través de la librería `renv`. Las librerías principales empleadas son:
* **`tidyverse`**: Para la manipulación de datos (`dplyr`, `stringr`) y visualización.
* **`rio`**: Importación rápida de datos multiformato.
* **`arrow`**: Exportación y manejo eficiente de bases de datos masivas en formato `.parquet`.
* **`janitor`**: Limpieza y tabulación de datos.
* **`readr`**: Soporte para la lectura de datos rectangulares.
# PC4 - INGRESOS POR IDIOMA Y CLASIFICACIÓN ANALÍTICA

## Descripción del proyecto
Este repositorio incluye el código y el flujo de trabajo completo para el procesamiento de la **Práctica Calificada 4 (PC4)** del curso **Taller de Procesamiento de Datos**. 

El objetivo principal es evaluar las brechas socioeconómicas analizando los **ingresos de los jefes de familia** en el Perú según su adscripción lingüística, utilizando los datos oficiales de la **Encuesta Nacional de Hogares (ENAHO) 2024**. El flujo actual incorpora el diagnóstico de valores perdidos, análisis exploratorio bivariado (EDA) y la operacionalización de variables analíticas avanzadas.
## Estructura del directorio 
El directorio se organiza de la siguiente manera:
```text
├── PC3 TALLER DE DATOS.Rproj         # Inicialización del entorno R Project
├── 01_Carga_Union_Modulos.R          # Importación, estandarización de variables y consolidación (Joins)
├── scripts/
│   ├── 02_Acondicionamiento_Jefes.R  # Filtro muestral estricto de jefes, selección y diagnóstico de NAs
│   ├── 03_Exploracion_Jefes.R        # Recodificación estricta según diccionario INEI 2024 y gráficos del EDA
│   └── 04_Clasificacion_Jefes.R      # Construcción indexada de variables dummies y logaritmo de ingresos
├── Datos/
│   ├── Crudos/                       # Módulos originales en formato .dta de la ENAHO 2024
│   └── procesados/
│       ├── enaho_jefes_acondicionada.parquet # Base filtrada limpia post-diagnóstico
│       ├── enaho_jefes_exploratoria.parquet  # Base enriquecida con factores lingüísticos y educativos
│       └── enaho_jefes_analitica.parquet     # Base final con variables dummies y escala logarítmica
├── outputs/                          # Reportes CSV (Brechas, NAs) e histogramas/gráficos de barras generados
├── renv/                             # Entorno local aislado de paquetes del proyecto
├── renv.lock                         # Registro exacto del estado de dependencias del entorno
└── .gitignore                        # Configuración de exclusión para omitir archivos de datos pesados
