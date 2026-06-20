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
