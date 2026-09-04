# <<<<<<<<<<<< [ Packages ] >>>>>>>>>>>>

library(shiny)
library(bslib)
library(bsicons)
library(thematic)

library(svglite)
library(tidyr)
library(dplyr)
library(ggplot2)
library(bipartite)
library(igraph)



# <<<<<<<<<<<< [ data ] >>>>>>>>>>>>

thematic_shiny()
res_base <- 96

# Graphiques nets
options(shiny.plot.output.type = "svg")

# Variable générale
years <- c(2010:2025)

# Page 2
load("data/liste_matrice_order.rds")

# Page 3
load("data/sessions_obs.rds")
load("data/prop_na_order.rds")
load("data/prop_na_genus.rds")
load("data/connectances_order.rds")
load("data/connectances_genus.rds")
load("data/nodf_order.rds")
load("data/nodf_genus.rds")

# Page 4
load("data/repartition_groupe_plante_family.rds")
load("data/repartition_groupe_insecte_order.rds")
load("data/repartition_groupe_plante_genus.rds")
load("data/repartition_groupe_insecte_genus.rds")
load("data/graph_connexion_order.rds")
load("data/graph_connexion_genus.rds")
load("data/matrice_connexion_order.rds")
load("data/matrice_connexion_genus.rds")
ordre_groupes <- paste0("G", 1:10)

load("data/meilleur_model_order.rds")
load("data/meilleur_model_genus.rds")

# Page 5
load("data/tout_plant_family.rds")
load("data/tout_insect_order.rds")
load("data/tout_plant_genus.rds")
load("data/tout_insect_genus_trie.rds")

load("data/df_degres_annuels_order.rds")
load("data/df_degres_annuels_genus.rds")

load("data/df_long_insectes_order.rds")
load("data/df_long_plant_family.rds")
load("data/df_long_insect_genus.rds")
load("data/df_long_plant_genus.rds")

couleur_i_o <- c("0" = "grey30", "1" = "#FD974C", "2" = "#A63603")
couleur_p_f <- c("0" = "grey30", "3" = "#00682A", "4" = "#ADDEA7")
couleur_i_g <- c(
  "0" = "grey30", 
  "1" = "#DE510B", 
  "2" = "#FD974C", 
  "3" = "#F78031", 
  "4" = "#A63603", 
  "5" = "#FDC38E"
)
couleur_p_g <- c(
  "0"  = "grey30", 
  "6"  = "#5DB86A", 
  "7"  = "#00682A", 
  "8"  = "#1B843F", 
  "9"  = "#CDEBC7", 
  "10" = "#ADDEA7"
)



# <<<<<<<<<<<< [ Vider le cache ] >>>>>>>>>>>>

# sass::sass_cache_get()$reset()