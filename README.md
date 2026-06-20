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

## Estructura del directorio
El directorio se organiza de la siguiente manera:
'''text
├── PC3 TALLER DE DATOS.Rproj   # Archivo de inicialización del entorno R Project
├── 01_Carga_Union_Modulos.R    # Script principal: Importación, estandarización de eñes, filtrado de jefes de hogar (p203 == 1) y joins institucionales
├── PC3_Enlace.R                # Script complementario de enlace y flujos de trabajo
├── Datos/
│   ├── Crudos/                 # Módulos originales de la ENAHO 2024 en formato .dta (Stata)
│   │   ├── enaho01a-2024-400.dta   # Módulo de Salud
│   │   ├── enaho01a-2024-500.dta   # Módulo de Empleo
│   │   └── sumaria-2024-12g.dta    # Módulo de Pobreza e Ingresos
│   └── procesados/             # Base maestra integrada final en formato eficiente .parquet
├── docs/                       # Documentación adicional del proyecto
├── outputs/                    # Resultados, tablas y gráficos generados
├── scripts/                    # Scripts secundarios o de respaldo
├── renv/                       # Carpeta aislada del entorno local de paquetes privados
├── renv.lock                   # Registro exacto ("cápsula del tiempo") de las versiones de las librerías (`arrow`, `assertthat`, etc.)
└── .gitignore                  # Configuración de exclusión para evitar subir las bases pesadas a GitHub
