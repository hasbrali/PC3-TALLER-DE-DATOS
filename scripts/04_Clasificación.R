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
# 2. Exportación de la base analítica final
write_parquet(jefes_analitica, "Datos/procesados/enaho_jefes_analitica.parquet")
# 3. Generación del reporte analítico automatizado (Metadatos)
reporte_variables <- tibble(
  Variable_Nueva       = c("d_lengua_indigena", "d_jefa_mujer", "d_educ_superior", "ln_ingreso_bruto"),
  Variable_Origen      = c("p300a (lengua_materna)", "p207 (sexo)", "p301a (nivel_edu)", "ingmo1hd (ingreso_bruto)"),
  Sustento_Sociologico = c(
    "Mide la adscripción a identidades lingüísticas históricamente discriminadas.",
    "Permite analizar la penalidad económica o vulnerabilidad en hogares con jefatura femenina.",
    "Captura el umbral de acumulación de capital humano altamente valorado en el mercado laboral.",
    "Normaliza la distribución del ingreso eliminando el sesgo por valores atípicos extremos."
  )
)
write_csv(reporte_variables, "outputs/Reporte_Nuevas_Variables_Analiticas.csv")
