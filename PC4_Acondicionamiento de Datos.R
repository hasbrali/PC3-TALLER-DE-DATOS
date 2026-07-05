#=====================================================================================
#Proyecto: PC4-INGRESOS POR IDIOMA
#Autor: Raphael Esteba
#Fecha: 05-07-2026
#Script: ACONDICIONAMIENTO DE DATOS (ENFOQUE: JEFES DE FAMILIA)
#=====================

#1.Carga de Librerias-----------------------------------------------------------
library(tidyverse)
library(arrow)
library(janitor)
library(naniar)

renv::snapshot()

#2.Carga, selección y renombrado de variables de interés------------------------

# Cargamos la base integrada
base_unida <- read_parquet("Datos/procesados/enaho_jefes_2024_190626.parquet")


