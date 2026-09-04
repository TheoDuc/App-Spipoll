choix_echelle <- c("ordre/famille", "genre")
choix_affichage <- c("graphe", "matrice")
choix_filtre <- c("plante", "insecte")

contenu_sidebar_p2 <- list(
  numericInput(
    "annee_p2",
    "Saisissez une année",
    min = min(years),
    max = max(years),
    value = min(years),
    step = 1
  ),
  p("Cette page permet de visualiser le réseau de pollinisation de façon brute, selon l'année."),
  p("L'un des gros objectifs du stage a été de simplifier ce réseau pour le rendre plus lisible grace au modèle dynSBM.")
)

contenu_sidebar_p3 <- list(
  selectInput(
    "echelle_p3",
    "Sélectionnez une échelle",
    choices = choix_echelle,
    selected = "order/family",
    multiple = FALSE
  ),
  numericInput(
    "annee_p3",
    "Saisissez une année",
    min = min(years),
    max = max(years),
    value = min(years),
    step = 1
  ),
  p("Cette page regroupe les analyses exploratoires effectuées sur le réseau. Elle est composée de deux sélecteurs."),
  p("Le premier permet de choisir l'échelle (entre l'ordre / la famille et le genre). Le genre est l'échelle la plus précise"),
  p("La seconde agit uniquement sur les valeurs simples. Elle affiche précisément les valeurs pour chaque statistique à l'année sélectionnée"),
  p("Il y a deux statistiques spéciales plus difficiles à comprendre."),
  p("La première est la connectance, et est un pourcentage de connexion observées sur le total de connexion possible dans le réseau"),
  p("La seconde est le niveau d'emboîtement, ici calculé en utilisant l'indicateur NODF.")
)

contenu_sidebar_p4 <- list(
  selectInput(
    "echelle_p4",
    "Sélectionnez une échelle",
    choices = choix_echelle,
    selected = "order/family",
    multiple = FALSE
  ),
  numericInput(
    "annee_p4",
    "Saisissez une année",
    min = min(years),
    max = max(years),
    value = min(years),
    step = 1
  ),
  selectInput(
    "affichage_p4",
    "Sélectionnez un affichage",
    choices = choix_affichage,
    selected = "graphe",
    multiple = FALSE
  ),
  p("Cette page regroupe les résultats importants des deux modèles SBM dynamique (un par échelle). Il y a 3 sélecteurs."),
  p("Le premier est l'échelle et permet de passer d'un modèle à l'autre."),
  p("Le deuxième est l'année et agit sur les effectifs des insectes dans les groupes."),
  p("Le dernier permet de passer d'un affichage en graphe à une matrice pour la connectivité entre groupes."),
  p("Les deux tableaux dans la partie haute de la page montrent la répartition des individus dans les groupes créés par le modèle."),
  p("Le graphe et la matrice de connectivité révèlent la probabilité de connexion entre individus issus d'un certain groupe."),
  p("La matrice de transition représente la probabilité de changer de groupe l'année suivante, pour les individus d'un certain groupe."),
  p("Il est bon de noté qu'un individu placé dans le groupe 0 n'est pas observée à l'année sélectionnée.")
)

contenu_sidebar_p5 <- list(
  selectInput(
    "echelle_p5",
    "Sélectionnez une échelle",
    choices = choix_echelle,
    selected = "order/family",
    multiple = FALSE
  ),
  selectInput(
    "filtre_p5",
    "Sélectionnez un filtre",
    choices = choix_filtre,
    selected = "plante",
    multiple = FALSE
  ),
  selectInput(
    "individu_p5",
    "Sélectionnez un individu",
    choices = NULL,
    selected = NULL,
    multiple = FALSE
  ),
  p("Cette page présente les résultats d'analyse sur l'individu spécifiquement sélectionné."),
  p("Les degrés présenté dans le graphique en barre représentent le nombre de connexions avec d'autres individus."),
  p("Plus un individu a un degré élevé, plus il est connecté et plus on va dire qu'il est généraliste. L'inverse étant spécialiste."),
  p("Les statistiques en dessous sont calculés sur les degrés de l'individu. Il y a la moyenne, l'écart type et le nombre d'années sans observer l'individu."),
  p("Enfin, le graphique empilé répertorie le groupe d'appartenance de l'individu, selon le SBM dynamique?."),
  p("Les groupes sont de couleurs plus foncé pour ceux regroupant les individus plus généralistes, et plus claires pour les groupes plus spécialistes."),
  p("Pour les deux échelles, voici le classement des groupes du plus généraliste au plus spécialiste :"),
  p("ordre / famille : 2 - 1 pour les insectes, 3 - 4 pour les plantes."),
  p("genre : 4 - 1 - 3 - 2 - 5 pour les insectes, 7 - 8 - 6 - 10 - 9 pour les plantes.")
)