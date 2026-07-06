#=====================================================================================
#Proyecto: PC4-INGRESOS POR IDIOMA
#Autor: Raphael Esteba
#Fecha: 05-07-2026
#Script: EXPLORACIÓN DE DATOS (ENFOQUE: JEFES DE FAMILIA)
#=====================
#1.Carga de Librerias y Base de Datos-----------------------------------------------------------
library(tidyverse)
library(arrow)
library(scales)
#Base acondicionada
jefes_acondicionada <- read_parquet("Datos/procesados/enaho_jefes_acondicionada.parquet")

#2. Recodificación Metodológica--------------------------------------------------

#Creación de códigos numéricos a etiquetas---------------------------------------

jefes_explora <- jefes_acondicionada %>%
  mutate(
    # Lengua Materna (p300a)
    idioma_factor = case_when(
      lengua_materna == 1 ~ "Quechua",
      lengua_materna == 2 ~ "Aimara",
      lengua_materna %in% c(3, 4) ~ "Otras Lenguas Nativas",
      lengua_materna == 5 ~ "Castellano",
      TRUE ~ "Otros/No especificado"
    ),
    idioma_factor = factor(idioma_factor, levels = c("Castellano", "Quechua", "Aimara", "Otras Lenguas Nativas")),
    
    # Nivel Educativo (p301a)
    educ_factor = case_when(
      nivel_edu %in% c(1, 2, 3) ~ "Sin Educ / Primaria",
      nivel_edu %in% c(4, 5)    ~ "Secundaria",
      nivel_edu %in% c(6, 7, 8) ~ "Superior (Tec/Univ)",
      TRUE ~ "No especificado"
    ),
    educ_factor = factor(educ_factor, levels = c("Sin Educ / Primaria", "Secundaria", "Superior (Tec/Univ)")),
    
    # Sexo (p207)
    sexo_factor = case_when(
      sexo == 1 ~ "Hombre",
      sexo == 2 ~ "Mujer",
      TRUE ~ NA_character_
    )
  )

#3 Analisis exploratorio bivariado

#3.1 Idioma materno por ingreso
bivariado_idioma_ingreso <- jefes_explora %>%
  group_by(idioma_factor) %>%
  summarise(
    Total_Jefes      = n(),
    Ingreso_Promedio = round(mean(ingreso_bruto, na.rm = TRUE), 2),
    Ingreso_Mediano  = round(median(ingreso_bruto, na.rm = TRUE), 2)
  )
write_csv(bivariado_idioma_ingreso, "outputs/Tabla_Bivariado_Idioma_Ingreso.csv")
