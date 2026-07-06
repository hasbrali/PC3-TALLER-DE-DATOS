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
gc()
# Cargamos la base integrada
base_unida <- read_parquet("Datos/procesados/enaho_total_2024_050726.parquet")

# Seleccionamos y renombramos de acuerdo con las dimensiones del proyecto
base_acondicionada <- base_unida %>%
  select(
    # Keys
    aÑo,
    mes,
    conglome,
    vivienda,
    hogar,
    codperso,
    ubigeo,
    dominio,
    estrato,
    
    # Variables
    ingmo1hd,      # Ingreso disponible mensual del hogar
    p203,   # Parentesco (Filtro Jefe)
    p208a, # Edad 
    p207,   # Sexo
    p300a, # Lengua materna / Idioma
    p301a, # Nivel educativo alcanzado
    p510   # Sector de empleo institucional
  )

