#=====================================================================================
#Proyecto: PC3-INGRESOS POR IDIOMA
#Autor: Raphael Esteba
#Fecha: 19-06-2026
#Script: Cargar los módulos-realización de joins
#=====================

#1.Carga de Librerias--------------------------------------------------------
library(rio)
library(tidyverse)
library(janitor)
library(readr)
renv::snapshot()


#2 Importacion de datos------------------------------------------------------
mod500  <- import("Datos/Crudos/enaho01a-2024-500.dta") %>% 
  mutate(across(where(is.character), str_to_lower))

mod400  <- import("Datos/Crudos/enaho01a-2024-400.dta") %>% 
  mutate(across(where(is.character), str_to_lower))

sumaria <- import("Datos/Crudos/sumaria-2024-12g.dta") %>% 
  mutate(across(where(is.character), str_to_lower))
#3. Union de bases y filtrado---------------------------------------------------------

keys_hogar    <- c("aÑo", "mes", "conglome", "vivienda", "hogar", "ubigeo", "dominio", "estrato")
keys_personas <- c(keys_hogar, "codperso")

enaho_jefes_2024 <- mod500 %>% 
  filter(p203 == 1) %>% 
  left_join(mod400, by = keys_personas) %>% 
  left_join(sumaria, by = keys_hogar)
#Verificacion de filas
nrow(enaho_jefes_2024) == nrow(sumaria)

gc()

#4. Exportacion de base de datos creada-----------------------------------------
install.packages("arrow")
library(arrow)
renv::snapshot()
write_parquet(enaho_jefes_2024, "Datos/procesados/enaho_jefes_2024_190626.parquet")

renv::snapshot()
