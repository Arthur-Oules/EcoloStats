library(readxl)
library(tidyverse)
library(FactoMineR)
library(factoextra)
library(corrplot)
library(ade4)
library(adegraphics)



fauvette <- read.csv("Les Guignols à Gerland.csv", sep = ";", header = TRUE, encoding = "UTF-8")


meteo <- read_csv2("export_infoclimat.csv", locale = locale(encoding = "UTF-8"))
meteo <- meteo[-1, ]

#convertie la date en format lisible par R
meteo <- meteo %>%
  mutate(dh_utc = trimws(dh_utc),         # supprime les espaces en trop
         dh_utc = dmy_hm(dh_utc))         # parse la date proprement

#crée une colonne jour et minute AM pour permettre de liée les tableaux
meteo <- meteo %>%
  mutate(
    date_seule = as_date(dh_utc),                             # garde juste la date
    jour = as.integer(factor(date_seule))                    # transforme les dates en jour 1, 2, 3...
  ) %>%
  mutate(
    minute.AM = hour(dh_utc) * 60 + minute(dh_utc) # minutes dans le jour courant
  )


#on rajoute un colonne type_diff
fauvette <- fauvette %>%
  mutate(type_diff = gsub("[0-9_]", "", diff))


#on rajoute une colonne dh_utc à fauvette pour encore mieux lié fauvette et météo

# Date de départ pour le jour 1
date_depart <- as.Date("2025-04-14")

# Ajout de la colonne dh_utc et dh_utc_arrondie
fauvette <- fauvette %>%
  mutate(
    dh_utc = as.POSIXct(date_depart + days(Jour - 1)) + minutes(Minute.AM),
    dh_utc_arrondi = round_date(dh_utc, unit = "10 minutes"),
  )

rm(date_depart)


fauvette <- fauvette %>% mutate(
  Jour = as.numeric(Jour),
  Minute.AM = as.numeric(Minute.AM),
  ID_male = as.numeric(ID_male),
  vu = as.numeric(vu),
  str_pre = as.numeric(str_pre),
  d_min = as.numeric(d_min),
  latence..en.s. = as.numeric(latence..en.s.),
  str_diff = as.numeric(str_diff),
  str_post_diff = as.numeric(str_post_diff),
  cris_toto = as.numeric(cris_toto),
  cris_pre = as.numeric(cris_pre),
  cris_diff= as.numeric(cris_diff),
  cris_post = as.numeric(cris_post),
  survols = as.numeric(survols),
  femelle = as.numeric(femelle),
)

meteo <- meteo %>% mutate(
  temperature = as.numeric(temperature),
  pression = as.numeric(pression),
  pression_variation_3h = as.numeric(pression_variation_3h),
  humidite = as.numeric(humidite),
  point_de_rosee = as.numeric(point_de_rosee),
  visibilite = as.numeric(visibilite),
  vent_moyen = as.numeric(vent_moyen),
  vent_rafales = as.numeric(vent_rafales),
  vent_rafales_10min = as.numeric(vent_rafales_10min),
  vent_direction = as.numeric(vent_direction),
  temperature_min = as.numeric(temperature_min),
  temperature_max = as.numeric(temperature_max),
  pluie_1h = as.numeric(pluie_1h),
  pluie_3h = as.numeric(pluie_3h),
  pluie_6h = as.numeric(pluie_6h),
  pluie_12h = as.numeric(pluie_6h),
  pluie_24h = as.numeric(pluie_24h),
  pluie_cumul_0h = as.numeric(pluie_cumul_0h),
  pluie_intensite = as.numeric(pluie_intensite),
  pluie_intensite_max_1h = as.numeric(pluie_intensite_max_1h),
  uv = as.numeric(uv),
  uv_index = as.numeric(uv_index),
  ensoleillement = as.numeric(ensoleillement),
  temperature_sol = as.numeric(temperature_sol),
  jour = as.numeric(jour),
  minute.AM = as.numeric(minute.AM)
)

fauvette <- fauvette %>% mutate(d_min = ifelse(is.na(d_min), 4, d_min))
fauvette <- fauvette %>% mutate(latence..en.s. = ifelse(is.na(latence..en.s.), 240, latence..en.s.))

donne <- fauvette %>% left_join(meteo, by = c("dh_utc_arrondi" = "dh_utc"))

donne <- donne %>% select(-c(temperature_sol, ensoleillement, pluie_12h, vent_rafales, visibilite))

saveRDS(meteo, file = "meteo.rds")
saveRDS(fauvette, file="fauvette.rds")
saveRDS(donne, file = "donne.rds")


fauvette <- fauvette %>% mutate(latence..en.s. = na_if(latence..en.s., 0))
fauvette_latenceNA_sanscristoto <- fauvette_latenceNA %>% select(-c(cris_toto))
fauvette_latenceNA_sanscristoto_sansjour <- fauvette_latenceNA_sanscristoto %>% select(-c(Jour))
fauvette_uniquement_comportementale <- fauvette %>% select(-c(ID_male, cris_toto, Jour, Minute.AM))

meteo_uniquement_meterologique <- meteo_sansNA %>% select(-c(jour, minute.AM))

# Sélection des colonnes numériques (juste au cas où certaines ne le sont pas)
df_numeric <- donne_fauvette_meteo[sapply(donne_fauvette_meteo, is.numeric)]


# Lancer l'ACP (centrage et réduction automatique)
res_acp <- PCA(df_numeric, scale.unit = TRUE, graph = FALSE)



fviz_pca_ind(res_acp,
             col.ind = "cos2", # Coloration par qualité de représentation
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE) # éviter le chevauchement des labels

fviz_pca_var(res_acp,
             col.var = "contrib", # colorer selon la contribution
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE)

fviz_pca_biplot(res_acp, axes= c(2,4), repel = TRUE,
                col.var = "#FC4E07", col.ind = "#00AFBB")

fviz_screeplot(res_acp, addlabels = TRUE, ylim = c(0, 50))

fviz_contrib(res_acp, choice = "var", axes = 1, top = 10)
fviz_contrib(res_acp, choice = "var", axes = 2, top = 10)
fviz_contrib(res_acp, choice = "var", axes = 3, top = 10)
fviz_contrib(res_acp, choice = "var", axes = 4, top = 10)
fviz_contrib(res_acp, choice = "var", axes = 5, top = 10)


#truc Arthur
var <- get_pca_var(res_acp)
corrplot(var$cos2, is.corr = FALSE)



#on recupere les dimensions 1, 2, 3 de l'acp de meteo
donne_meteo <- res_acp$ind$coord
donne_meteo <- as.data.frame(donne_meteo)
donne_meteo <- donne_meteo %>% select(-c(Dim.4, Dim.5))
donne_meteo <- rename(donne_meteo, temperature_vent_humidite = Dim.1)
donne_meteo <- rename(donne_meteo, pluie = Dim.2)
donne_meteo <- rename(donne_meteo, ensoleillement = Dim.3)
donne_meteo <- bind_cols(donne_meteo, meteo$dh_utc)
donne_meteo <- rename(donne_meteo, dh_utc = ...4)

saveRDS(donne_meteo, file = "output/donne_meteo.rds")

#on recupere les dimensions 1, 2, 3, 4 de l'acp de fauvette
donne_fauvette <- res_acp$ind$coord
donne_fauvette <- as.data.frame(donne_fauvette)
donne_fauvette <- donne_fauvette %>% select(-c(Dim.5, Dim.4))
donne_fauvette <- rename(donne_fauvette, d_min_latence_survol = Dim.1)
donne_fauvette <- rename(donne_fauvette, cris_pre_post_chant = Dim.2)
donne_fauvette <- rename(donne_fauvette, cris_diff = Dim.3)
donne_fauvette <- bind_cols(donne_fauvette, fauvette$dh_utc_arrondi)
donne_fauvette <- rename(donne_fauvette, dh_utc_arrondi = ...4)
saveRDS(donne_fauvette, file = "output/donne_fauvette.rds")

donne_fauvette_meteo <- donne_fauvette %>% left_join(donne_meteo, by = c("dh_utc_arrondi" = "dh_utc"))

donne_fauvette_meteo <- bind_cols(donne_fauvette_meteo, fauvette$ID_male)
donne_fauvette_meteo <- bind_cols(donne_fauvette_meteo, fauvette$Jour)
donne_fauvette_meteo <- bind_cols(donne_fauvette_meteo, fauvette$Minute.AM)
donne_fauvette_meteo <- rename(donne_fauvette_meteo, ID_male = ...8)
donne_fauvette_meteo <- rename(donne_fauvette_meteo, Jour = ...9)
donne_fauvette_meteo <- rename(donne_fauvette_meteo, Minute.AM = ...10)
donne_fauvette_meteo <- donne_fauvette_meteo %>% mutate(ID_male = as.factor(ID_male))

donne_fauvette_meteo <- bind_cols(donne_fauvette_meteo, fauvette$diff)
donne_fauvette_meteo <- bind_cols(donne_fauvette_meteo, fauvette$type_diff)
donne_fauvette_meteo <- rename(donne_fauvette_meteo, diff = ...11)
donne_fauvette_meteo <- rename(donne_fauvette_meteo, type_diff = ...12)
saveRDS(donne_fauvette_meteo, file = "output/donne_f)auvette_meteo.rds")

pc=dudi.pca(df_numeric)
bca(pc,as.factor(donne_fauvette_meteo$type_diff))
s.class(pc$li, as.factor(donne_fauvette_meteo$diff), xlim = c(-4, 8), ylim = c(-2, 4), col = TRUE)

donne_estim <- readRDS("données_estim.rds")
donnen <- donne %>% mutate(cris_post = donne_estim$cris_post,
                          cris_pre = donne_estim$cris_pre,
                          cris_diff = donne_estim$cris_diff,
                          cris_toto = donne_estim$cris_toto)

donnen <- bind_cols(donnen, donne_estim$indice_energy)
donnen <- rename(donnen, indice_energy = ...42)
donnen <- donnen %>% mutate(ID_male = as.factor(ID_male))

fauvette <- fauvette %>% mutate(cris_post = donne_estim$cris_post,
                           cris_pre = donne_estim$cris_pre,
                           cris_diff = donne_estim$cris_diff,
                           cris_toto = donne_estim$cris_toto)

