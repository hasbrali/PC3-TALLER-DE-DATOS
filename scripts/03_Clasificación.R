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
    # Lengua Materna (p300a) - Ajuste estricto al diccionario oficial 2024
    idioma_factor = case_when(
      lengua_materna == 1 ~ "Quechua",
      lengua_materna == 2 ~ "Aymara",
      lengua_materna == 4 ~ "Castellano",
      lengua_materna %in% c(3, 10, 11, 12, 13, 14, 15) ~ "Otras Lenguas Nativas",
      TRUE ~ "Otros/No especificado"
    ),
    idioma_factor = factor(idioma_factor, levels = c("Castellano", "Quechua", "Aymara", "Otras Lenguas Nativas")),
    
    # Nivel Educativo (p301a) - Ajuste estricto a la codificación del módulo 300
    educ_factor = case_when(
      nivel_edu %in% c(1, 2, 3, 4) ~ "Sin Educ / Primaria", # Incluye primaria completa (4)
      nivel_edu %in% c(5, 6)       ~ "Secundaria",           # Secundaria incompleta (5) y completa (6)
      nivel_edu %in% c(7, 8, 9, 10, 11) ~ "Superior (Tec/Univ)", # Superiores y posgrados (7 al 11)
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
#3 Analisis exploratorio bivariado y univariado---------------------------------

#3.1 Idioma materno por ingreso--------------------------------------------------
bivariado_idioma_ingreso <- jefes_explora %>%
  group_by(idioma_factor) %>%
  summarise(
    Total_Jefes      = n(),
    Ingreso_Promedio = round(mean(ingreso_bruto, na.rm = TRUE), 2),
    Ingreso_Mediano  = round(median(ingreso_bruto, na.rm = TRUE), 2)
  )
write_csv(bivariado_idioma_ingreso, "outputs/Tabla_Bivariado_Idioma_Ingreso.csv")

#3.2 Gráfico Univariado---------------------------------------------------------
#Histograma de la variable continua ingreso bruto.
grafico_uni_ingreso <- ggplot(jefes_explora, aes(x = ingreso_bruto)) +
  geom_histogram(fill = "steelblue", color = "white", bins = 40) +
  scale_x_log10(labels = dollar_format(prefix = "S/. ")) +
  labs(
    title = "Distribución Univariada del Ingreso Bruto Mensual (Escala Log10)",
    subtitle = "PC4: Estructura de ingresos en Jefes de Familia (2024)",
    x = "Ingreso Disponible Mensual del Hogar (Soles)",
    y = "Frecuencia de Hogares"
  ) +
  theme_minimal()
ggsave("outputs/Grafico_Univariado_Ingreso.png", plot = grafico_uni_ingreso, width = 8, height = 5, bg = "white")

#3.3 Tabla de distribución de jefes por idioma materno--------------------------
univariado_idioma <- jefes_explora %>%
  count(idioma_factor, name = "frecuencia_absoluta") %>%
  mutate(porcentaje = round((frecuencia_absoluta / sum(frecuencia_absoluta)) * 100, 2))

write_csv(univariado_idioma, "outputs/Tabla_Univariado_Idioma.csv")

#3.4 Tabla de cruce de idioma con nivel educativo-----------------------------
bivariado_educ_idioma <- jefes_explora %>%
  tabyl(idioma_factor, educ_factor) %>%
  adorn_percentages("row") %>%
  adorn_pct_formatting(digits = 2) %>%
  adorn_ns()

write_csv(bivariado_educ_idioma, "outputs/Tabla_Bivariado_Cruce_Educacion.csv")

# 3.5 Gráfico Bivariado: Barras de Ingreso Promedio según Idioma Materno
grafico_bi_barras <- ggplot(bivariado_idioma_ingreso, aes(x = idioma_factor, y = Ingreso_Promedio, fill = idioma_factor)) +
  geom_col(color = "black", width = 0.5, show.legend = FALSE) +
  geom_text(aes(label = paste("S/.", format(Ingreso_Promedio, big.mark=","))), vjust = -0.5, fontface = "bold") +
  labs(
    title = "Ingreso Promedio Mensual por Lengua Materna del Jefe de Familia",
    subtitle = "PC4: Brechas de ingresos según adscripción lingüística (2024)",
    x = "Lengua Materna",
    y = "Ingreso Promedio (Soles)",
    caption = "Fuente: ENAHO 2024 - Instituto Nacional de Estadística e Informática"
  ) +
  scale_y_continuous(labels = dollar_format(prefix = "S/. "), limits = c(0, max(bivariado_idioma_ingreso$Ingreso_Promedio) * 1.15)) +
  theme_minimal()

ggsave("outputs/Grafico_Bivariado_Barras.png", plot = grafico_bi_barras, width = 9, height = 6, bg = "white")

# 4. EXPORTACIÓN DE LA NUEVA BASE DE DATOS ACTUALIZADA
write_parquet(jefes_explora, "Datos/procesados/enaho_jefes_exploratoria.parquet")
