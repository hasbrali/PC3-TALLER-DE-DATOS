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

# Seleccionamos y renombramos de acuerdo con las dimensiones del proyecto
jefes_acondicionada <- base_unida %>%
  select(
    # Llaves institucionales y geográficas obligatorias
    aÑo,
    mes,
    conglome,
    vivienda,
    hogar,
    codperso,
    ubigeo,
    dominio,
    estrato,
    
    # Dimensión Demográfica e Idioma 
    parentesco     = p203,    # Validar que todos sean 1 que son Jefes de familia
    sexo           = sexo,
    edad           = edad,
    lengua_materna = p300a,   # idioma / lengua materna
    etnicidad      = p558c,   # autoidentificación étnica
    
    # Dimensión Educación 
    nivel_edu      = p301a,   # Último año de estudios aprobado / Nivel educativo alcanzado
    
    # Dimensión Ingresos y Empleo 
    sector_empleo  = p510,    # Sector Formal / Informal institucional
    ingreso_hogar  = ingmo1hd # Ingreso disponible mensual
  )

