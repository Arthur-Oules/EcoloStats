# Descritpion des différents fichiers

TP_oiseaux-2.Rmd : fichier contenant le code et les commentaires de l'analyse des données.

data_oiseaux.csv : tableau regroupant les données aquises sur le terrain

Chants.csv : tableau regroupant les données issues de l'analyse des chants récoltés, analyse menée sur Audacity.

# Mise en route du code

Dans le TP_oiseaux-2.Rmd, modifier lignes 71 et 309 l'adresse où sont stockés tous les documents. (Les fichiers data_oiseaux.csv et Chants.csv, trouvés en pièce jointe du mail envoyé par Oscar.)

# Description du tableau de données data_oiseaux.csv obtenu par échantillonage sur le terrain

- JOUR : variable numérique désigant la date, prenant des valeurs de 1 à 4 avec le numéro 1 correspondant au 25/04/23 et ainsi de suite jusqu'au 28/04/23.

- HEURE : variable numérique désigant l'heure, écrite comme suit: 07h34 correspond à 734 dans le tableau par exemple.

- ID_MALE : variable numérique désignant l'identité du mâle, les mâles ayant été numérotés de 1 à 6 au préalable.

- VU : variable binaire prenant pour valeur 1 si le mâle a été vu/entendu (s'il s'est manifesté) pendant les 1min30 précédant la diffusion de l'enregistrement.

- DIFFUSION : le type d'enregistrement diffusé. Il y avait des enregistrements de 6 types: TN le témoin négatif, enregistrement de mésange charbonnière, FJ de fauvette des jardins, FG de fauvette grisette, FTNcomp de fauvette à tête noire avec à la fois les gazouillis et les sifflements, FTNgaz enregistrement contenant uniquement des gazouillis de fauvette à tête noire, FTNsif avec uniquement les sifflements.

- DIFFUSION_SOUS_TYPE : désigne l'enregistrement choisi dans la catégorie donnée parmi les 4 enregistrements différents disponibles. Prend une valeur de 1 à 4.

- SESSION_DIFF: désigne le nombre de fois où le mâle a été échantillonné (en comptant l'expérimentation en question). À la SESSION_DIFF n, l'oiseau a déjà été échantillonné n-1 fois.

- SESSION_TYPE : prend une valeur n entre 1 et 7 et désigne le nombre de fois où on a diffusé un type d'enregistrement à un mâle donné. À la SESSION_TYPE n, l'oiseau a été échantillonné n-1 fois avec un type d'enregistrement différent.  

- SESSION_SOUS_TYPE : prend une valeur n entre 1 et 3 et désigne le nombre de fois où on a diffusé un sous-type d'enregistrement à un mâle donné. À la SESSION_SOUS_TYPE n, l'oiseau a été échantillonné n-1 fois avec un sous-type d'enregistrement différent.

- STROPHES_AVANT : variable numérique comptant le nombre de strophes entendues pendant la 1min30 d'observation préalable. 

- DISTANCE_MIN : variable numérique désignant la distance minimale (en m) où le mâle s'est approché de l'enceinte.

- LATENCE : temps en secondes qu'a mis le mâle à réagir à partir du début de la diffusion. Une réaction peut-être un déplacement du mâle, un chant ou un cri.

- STROPHES_APRES : variable numérique comptant le nombre de strophes entendues pendant la 1min30 de diffusion et la 1min30 de période d'observation après diffusion (3min de diffusion et post)

- CRIS : variable numérique comptant les cris du mâle pendant les 3min de diffusion et post.

- SURVOLS : variable numérique qui compte le nombre de fois où le mâle passe au-dessus de l'enceinte en volant pendant les 3 min de diffusion et post.

- FEMELLE : variable binaire prenant pour valeur 1 si la femelle a réagi (mouvement ou cri) pendant les 3 min de diffusion et post, 0 sinon.

- PUBLIC : variable numérique qui compte le nombre de passages de personnes entre les expérimentateurs et l'enceinte pendant les 3 min de diffusion et post

- TEMPERATURE : variable numérique indiquant la température relevée par la station météo de Lyon 7. Les données météo sont fournies toutes les 1/2 heures.

- VENT_MOY : variable numérique indiquant la vitesse moyenne du vent (en km/h)

- VENT_MAX : variable numérique indiquant la vitesse maximale du vent (en km/h)

- PLUIE : variable numérique indiquandtla quantité de pluie (en mm/h)

- ENSOLEILLEMENT : variable numérique indiquant les radiations solaires (en W/m2)

- INDICE_REP : variable numérique issue d'une analyse aux composantes principales (ACP) évaluant la réponse d'un mâle. Il s'agit d'une combinaison linéaire des différentes variables traduisant une réponse du mâle : STROPHES_AVANT, STROPHES_APRES, CRIS, LATENCE, DISTANCE_MIN, FEMELLE, SURVOLS.

- INDICE_METEO : variable numérique issue d'une ACP, combinaison linéaire des variables météo relevées.

- INDICE_ENV : variable numérique issue d'une ACP, combinaison linéaires des variables météo ainsi que des variables relevant de l'environnement: public, jour et heure.

# Description du tableau de données Chants.csv

- JOUR, HEURE, DIFFUSION, ID_MALE: mêmes variables que dans le tableau data_oiseaux.csv

- NUMERO : variable numérique qui indique le numéro de la strophe dans un enregistrement donné

- DUREE : variable numérique indiquant la durée de la strophe en secondes.

- DUREE_SIF : indique la durée des sifflements dans la strophe en secondes.

- DUREE_GAZ : indique la durée des gazouillis dans la strophe en secondes.

- PROPORTION_SIF : variable numérique issue du calcul: DUREE_SIF / DUREE

