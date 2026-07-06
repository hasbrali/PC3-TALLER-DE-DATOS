#=====================================================================================
#Proyecto: PC4-INGRESOS POR IDIOMA
#Autor: Raphael Esteba
#Fecha: 05-07-2026
#Script: CLASIFICACIÓN DE DATOS (ENFOQUE: JEFES DE FAMILIA)
#=====================
#1.Carga de Librerias-----------------------------------------------------------
library(tidyverse)
library(arrow)
# 1. Carga de datos y creación compacta de variables analíticas-------------------
jefes_analitica <- read_parquet("Datos/procesados/enaho_jefes_exploratoria.parquet") %>%
  mutate(
    d_lengua_indigena = ifelse(lengua_materna %in% c(1, 2, 3, 10:15), 1, 0), # 1 = Indígena, 0 = Castellano
    d_jefa_mujer       = ifelse(sexo == 2, 1, 0),                           # 1 = Mujer, 0 = Hombre
    d_educ_superior   = ifelse(nivel_edu %in% c(7:11), 1, 0),              # 1 = Superior, 0 = Secundaria o menos
    ln_ingreso_bruto  = log(ingreso_bruto)                                 # Logaritmo para normalizar distribución
  )
