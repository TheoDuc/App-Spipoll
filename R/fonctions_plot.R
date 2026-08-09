# <<<<<<<<<<<< [ Fonctions générales ] >>>>>>>>>>>>

index_annee <- function(annee){
  return(as.numeric(which(years == annee)))
}

ordre_famille_bool <- function(echelle){
  if(echelle == "ordre/famille"){
    return(TRUE)
  }
  if(echelle == "genre"){
    return(FALSE)
  }
  stop(paste("Nom d'échelle incorrecte :", echelle))
}

affichage_graphe_bool <- function(affichage){
  if(affichage == "graphe"){
    return(TRUE)
  }
  if(affichage == "matrice"){
    return(FALSE)
  }
  stop(paste("Nom d'échelle incorrecte :", echelle))
}

filtre_plante_bool <- function(filtre){
  if(filtre == "plante"){
    return(TRUE)
  }
  if(filtre == "insecte"){
    return(FALSE)
  }
  stop(paste("Nom d'échelle incorrecte :", echelle))
}





# <<<<<<<<<<<< [ Fonctions de texte et valeurs ] >>>>>>>>>>>>

# <<<<<<<<<<<< [ Page 2 ] >>>>>>>>>>>>

titre_reseau_brut <- function(annee){
  return(paste("Réseau brut : Intéraction entre les familles de plantes et l'ordre d'insectes en", annee))
}

# <<<<<<<<<<<< [ Page 3 ] >>>>>>>>>>>>

titre_pourcentage_na_graphique <- function(echelle){
  return(paste0("Pourcentage de valeur manquante par an (", echelle, ")"))
}

titre_valeur_obs <- function(annee){
  return(paste("Observations en", annee))
}

valeur_obs_annee <- function(annee){
  return(nb_sessions$compte[index_annee(annee) + 6])
}

titre_valeur_NA_plante <- function(annee, echelle){
  return(paste0("N.A chez les plantes en ", annee, " (", echelle, ")"))
}

valeur_NA_plante <- function(echelle, annee){
  if(ordre_famille_bool(echelle)){
    df <- df_prop_na_graphique_order
  }else{
    df <- df_prop_na_graphique_genus
  }
  
  prop <- df$Proportion[index_annee(annee)]
  
  return(paste0(round(prop * 100, digits = 2), "%"))
}

titre_valeur_NA_insecte <- function(annee, echelle){
  return(paste0("N.A chez les insectes en ", annee, " (", echelle, ")"))
}

valeur_NA_insecte <- function(echelle, annee){
  if(ordre_famille_bool(echelle)){
    df <- df_prop_na_graphique_order
  }else{
    df <- df_prop_na_graphique_genus
  }
  
  prop <- df$Proportion[index_annee(annee) + length(years)]
  
  return(paste0(round(prop * 100, digits = 2), "%"))
}

titre_plot_connectance <- function(echelle){
  return(paste0("Connectance au fil des ans (", echelle, ")"))
}

titre_plot_emboitement <- function(echelle){
  return(paste0("NODF au fil des ans (", echelle, ")"))
}

titre_valeur_connectance <- function(echelle, annee){
  return(paste0("Connectance en ", annee, " (", echelle, ")"))
}

valeur_connectance <- function(echelle, annee){
  if(ordre_famille_bool(echelle)){
    connectances <- connectances_order
  }else{
    connectances <- connectances_genus
  }
  
  return(paste0(round(connectances[index_annee(annee)] * 100, digits = 2), "%"))
}

titre_valeur_emboitement <- function(echelle, annee){
  return(paste0("NODF en ", annee, " (", echelle, ")"))
}

valeur_emboitement <- function(echelle, annee){
  if(ordre_famille_bool(echelle)){
    NODF <- NODF_order
  }else{
    NODF <- NODF_genus
  }
  
  return(paste0(round(NODF[index_annee(annee)], digits = 2), "%"))
}

# <<<<<<<<<<<< [ Page 4 ] >>>>>>>>>>>>

titre_nb_groupes <- function(echelle){
  return(paste0("Nombre de groupes (", echelle, ")"))
}

valeur_nb_groupes <- function(echelle){
  if(ordre_famille_bool(echelle)){
    return(4)
  }else{
    return(10)
  }
}

titre_tableau_plantes <- function(echelle, annee){
  return(paste0("Plantes par groupe en ", annee, " (", echelle, ")"))
}

tableau_plantes <- function(echelle, annee){
  if(ordre_famille_bool(echelle)){
    liste <- liste_repartition_groupe_plante_family
  }else{
    liste <- liste_repartition_groupe_plante_genus
  }
  
  return(liste[[index_annee(annee)]])
}

titre_tableau_insectes <- function(echelle, annee){
  return(paste0("Insectes par groupe en ", annee, " (", echelle, ")"))
}

tableau_insectes <- function(echelle, annee){
  if(ordre_famille_bool(echelle)){
    liste <- liste_repartition_groupe_insecte_order
  }else{
    liste <- liste_repartition_groupe_insecte_genus
  }
  
  return(liste[[index_annee(annee)]])
}

titre_plot_connectivite <- function(echelle, annee, affichage){
  if(affichage_graphe_bool(affichage)){
    return(paste0("Graphe de connectivité en ", annee, " (", echelle, ")"))
  }else{
    return(paste0("Matrice de connectivité en ", annee, " (", echelle, ")"))
  }
}

titre_plot_transition <- function(echelle, annee){
  return(paste0("Matrice de transition en ", annee, " (", echelle, ")"))
}

# <<<<<<<<<<<< [ Page 5 ] >>>>>>>>>>>>

titre_plot_degres <- function(echelle, individu){
  return(paste0("Evolution des degrés pour l'individu : ", individu, " (", echelle, ")"))
}

valeur_moyenne_degres <- function(echelle, individu){
  if(ordre_famille_bool(echelle)){
    df <- df_degres_annuels_order
  }else{
    df <- df_degres_annuels_genus
  }
  
  df <- data.frame(
    Annee = as.numeric(rownames(df)),
    Degre = ifelse(is.na(df[[individu]]), 0, df[[individu]])
  )
  
  return(round(mean(df$Degre), 2))
}

valeur_sd_degres <- function(echelle, individu){
  if(ordre_famille_bool(echelle)){
    df <- df_degres_annuels_order
  }else{
    df <- df_degres_annuels_genus
  }
  
  df <- data.frame(
    Annee = as.numeric(rownames(df)),
    Degre = ifelse(is.na(df[[individu]]), 0, df[[individu]])
  )
  
  return(round(sd(df$Degre), 2))
}

valeur_annee_0_degres <- function(echelle, individu){
  if(ordre_famille_bool(echelle)){
    df <- df_degres_annuels_order
  }else{
    df <- df_degres_annuels_genus
  }
  
  df <- data.frame(
    Annee = as.numeric(rownames(df)),
    Degre = ifelse(is.na(df[[individu]]), 0, df[[individu]])
  )
  
  return(sum(df$Degre == 0))
}

titre_graphique_groupes <- function(echelle, individu){
  return(paste0("Groupe par an : ", individu, " (", echelle, ")"))
}





# <<<<<<<<<<<< [ Fonctions de graphiques ] >>>>>>>>>>>>

# <<<<<<<<<<<< [ Page 2 ] >>>>>>>>>>>>

plot_general_reseau <- function(annee){
  
  matrice <- liste_matrice_order[[index_annee(annee)]]
  
  plotweb_deprecated(
    matrice,
    method = "normal",
    col.high = "brown",
    col.low = "green4",
    col.interaction = "gray60",
    bor.col.interaction = NA,
    text.rot = 90,
    labsize = 1.8,    
    y.lim = c(-1.5, 2.5),   
    y.width.low = 0.08,       
    y.width.high = 0.08,
    
    text.high.col = "white",
    text.low.col = "white"
  )
}

# <<<<<<<<<<<< [ Page 3 ] >>>>>>>>>>>>

plot_nb_obs <- function(){
  
  ggplot(data = nb_sessions, aes(x = year, y = compte)) +
    geom_bar(stat = "identity", fill = "pink2") +
    
    # Graduation des axes
    scale_x_continuous(breaks = seq(min(nb_sessions$year), max(nb_sessions$year), by = 2)) +
    scale_y_continuous(breaks = seq(0, max(nb_sessions$compte) + 2000, by = 2000)) +
    
    # Titre et titres des axes
    labs(x = "Année", y = "Sessions") +
    theme(
      axis.title.y = element_text(angle = 0, vjust = 0.5),
      plot.title = element_text(hjust = 0.5)
    )
  
}

plot_valeur_manquante <- function(echelle){
  if(ordre_famille_bool(echelle)){
    df <- df_prop_na_graphique_order
  }else{
    df <- df_prop_na_graphique_genus
  }
  
  ggplot(df, aes(x = Annee, y = Proportion, color = Type, group = Type)) +
    geom_line(linewidth = 1) +
    geom_point(shape = 15, size = 2) +
    
    # Couleur des groupes
    scale_color_manual(values = c("Plant family" = "green4", "Insect order" = "brown")) +
    
    scale_y_continuous(
      limits = c(0, max(df$Proportion)),
      labels = scales::percent_format(accuracy = 1)
    ) +
    scale_x_continuous(
      breaks = seq(min(years), max(years), by = 1)
    ) +
    
    labs(
      x = "Année",
      y = "Pourcentage de N.A",
      color = "Variables"
    ) +
    
    guides(
      color = guide_legend(
        title = NULL,
        direction = "vertical"
      )
    ) +
    
    theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 12),
          axis.title.y = element_text(angle = 0, vjust = 0.5),
          legend.position = "right",
          
          panel.grid.major = element_line(color = "grey70", linewidth = 0.5), # Grille principale légère
          panel.grid.minor = element_line(color = "grey70", linewidth = 0.25), # Grille secondaire très fine
          
          legend.key = element_rect(fill = "transparent", color = NA)
    )
}

plot_connectance <- function(echelle){
  if(ordre_famille_bool(echelle)){
    connectances <- connectances_order
  }else{
    connectances <- connectances_genus
  }
  
  ggplot(data.frame(Annee = years, Connectance = connectances), aes(x = Annee, y = Connectance)) +
    
    geom_line(color = "darkorange2", linewidth = 1) +
    
    geom_point(color = "darkorange2", size = 2) +
    
    scale_y_continuous(
      limits = c(0, 1),
      expand = c(0, 0),
      breaks = seq(0, 1, by = 0.2)
    ) +
    scale_x_continuous(
      breaks = seq(min(years), max(years), by = 1)
    ) +
    
    labs(
      x = "Année",
      y = "Connectance"
    ) +
    
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold", size = 12),
      axis.title.y = element_text(angle = 0, vjust = 0.5), # Axe Y horizontal
      
      # Ton quadrillage léger personnalisé
      panel.grid.major = element_line(color = "grey70", linewidth = 0.5),
      panel.grid.minor = element_line(color = "grey70", linewidth = 0.25),
      
      # On ne garde que la grille horizontale (plus lisible pour suivre l'évolution de la connectance)
      panel.grid.major.x = element_blank(),
      panel.grid.minor.x = element_blank()
    )
}


plot_emboitement <- function(echelle){
  if(ordre_famille_bool(echelle)){
    NODF <- NODF_order
  }else{
    NODF <- NODF_genus
  }
  
  ggplot(data.frame(Annee = years, NODF = NODF), aes(x = Annee, y = NODF)) +
    
    geom_line(color = "yellow3", linewidth = 1) +
    
    geom_point(color = "yellow3", size = 2) +
    
    scale_y_continuous(
      limits = c(0, 100),
      expand = c(0, 0),
      breaks = seq(0, 100, by = 20)
    ) +
    scale_x_continuous(
      breaks = seq(min(years), max(years), by = 1)
    ) +
    
    labs(
      x = "Année",
      y = "NODF"
    ) +
    
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold", size = 12),
      axis.title.y = element_text(angle = 0, vjust = 0.5), # Axe Y horizontal
      
      # Ton quadrillage gris léger personnalisé
      panel.grid.major = element_line(color = "grey70", linewidth = 0.5),
      panel.grid.minor = element_line(color = "grey70", linewidth = 0.25),
      
      # Uniquement la grille horizontale pour une lecture limpide des valeurs
      panel.grid.major.x = element_blank(),
      panel.grid.minor.x = element_blank()
    )
}

# <<<<<<<<<<<< [ Page 4 ] >>>>>>>>>>>>

plot_connectivite_groupes <- function(echelle, annee, affichage){
  if(affichage_graphe_bool(affichage)){
    if(ordre_famille_bool(echelle)){
      graphe <- liste_graphe_connectivite_order[[index_annee(annee)]]
    }else{
      graphe <- liste_graphe_connectivite_genus[[index_annee(annee)]]
    }
    
    plot(
      graphe, 
      layout = layout_as_bipartite(graphe, hgap = 2, vgap = 1),
      vertex.label.color = "white",
      vertex.label.font = 2,
      vertex.label.cex = 0.9
    )
    
  }else{
      if(ordre_famille_bool(echelle)){
        matrice <- matrice_filtree_order
      }else{
        matrice <- matrice_filtree_genus
      }
    
    df_trans <- matrice %>%
      t() %>%
      as.data.frame() %>%
      rename_with(~ paste0("G", 1:ncol(matrice))) %>%
      mutate(ligne = paste0("G", 1:nrow(matrice))) %>%
      pivot_longer(
        cols = -ligne, 
        names_to = "colonne", 
        values_to = "Probabilite"
      ) %>%
      mutate(
        ligne = factor(ligne, levels = ordre_groupes),
        colonne = factor(colonne, levels = ordre_groupes)
      )
    
    p <- ggplot(df_trans, aes(x = colonne, y = ligne, fill = Probabilite)) +
      geom_tile(color = "white", linewidth = 0.5) +
      
      scale_fill_gradientn(
        colors = c("#303030", "#34495e", "#2980b9", "#3498db"),
        values = c(0, 0.01, 0.5, 1),
        limits = c(0, 1),
        breaks = seq(0, 1, 0.2),
        labels = scales::percent
      ) +
      geom_text(
        aes(label = sprintf("%.2f", Probabilite)), 
        color = ifelse(df_trans$Probabilite > 0.4, "white", "#bdc3c7"),
        size = 4.5
      ) +
      scale_x_discrete(position = "top") +
      scale_y_discrete(limits = rev) + 
      labs(
        x = "Groupe",
        y = "Groupe", 
        fill = "Probabilité de connexion"
      ) +
      theme(
        panel.grid = element_blank(),
        axis.title.y = element_text(angle = 0, vjust = 0.5, hjust = 1)
      )
    
    return(p)
  }
}

plot_matrice_transition <- function(echelle){
  if(ordre_famille_bool(echelle)){
    matrice <- meilleur_model_order$trans
  }else{
    matrice <- meilleur_model_genus$trans
  }
  
  df_trans <- matrice %>%
    t() %>%
    as.data.frame() %>%
    rename_with(~ paste0("G", 1:ncol(matrice))) %>%
    mutate(ligne = paste0("G", 1:nrow(matrice))) %>%
    pivot_longer(
      cols = -ligne, 
      names_to = "colonne", 
      values_to = "Probabilite"
    ) %>%
    mutate(
      ligne = factor(ligne, levels = ordre_groupes),
      colonne = factor(colonne, levels = ordre_groupes)
    )
  
  p <- ggplot(df_trans, aes(x = colonne, y = ligne, fill = Probabilite)) +
    geom_tile(color = "white", linewidth = 0.5) +
    
    scale_fill_gradientn(
      colors = c("#303030", "#34495e", "#2980b9", "#3498db"),
      values = c(0, 0.01, 0.5, 1),
      limits = c(0, 1),
      breaks = seq(0, 1, 0.2),
      labels = scales::percent
    ) +
    geom_text(
      aes(label = sprintf("%.2f", Probabilite)), 
      color = ifelse(df_trans$Probabilite > 0.4, "white", "#bdc3c7"),
      size = 4.5
    ) +
    scale_x_discrete(position = "top") +
    scale_y_discrete(limits = rev) + 
    labs(
      x = "Groupe à l'année t + 1",
      y = "Groupe à l'année t", 
      fill = "Probabilité de connexion"
    ) +
    theme(
      panel.grid = element_blank(),
      axis.title.y = element_text(angle = 0, vjust = 0.5, hjust = 1)
    )
  
  return(p)
}

# <<<<<<<<<<<< [ Page 5 ] >>>>>>>>>>>>

plot_degres <- function(echelle, filtre, individu){
  if (filtre_plante_bool(filtre)){
    couleur <- "green4"
  } else{couleur <- "brown"}
  
  if(ordre_famille_bool(echelle)){
    df <- df_degres_annuels_order
  }else{
    df <- df_degres_annuels_genus
  }
  
  df_plot <- data.frame(
    Annee = as.numeric(rownames(df)),
    Degre = ifelse(is.na(df[[individu]]), 0, df[[individu]])
  )
  
  ggplot(df_plot, aes(x = Annee, y = Degre)) +
    geom_col(fill = couleur, color = "white", width = 0.7) +
    geom_text(aes(label = Degre), vjust = -1, size = 3.5) +
    
    scale_x_continuous(
      breaks = seq(min(df_plot$Annee), max(df_plot$Annee), by = 1)
    ) +
    scale_y_continuous(
      expand = expansion(mult = c(0, 0.1))
    ) +
    
    labs(
      x = "Année",
      y = "Degrés"
    ) +
    
    theme(
      plot.title = element_text(hjust = 0.5, face = "bold", size = 12),
      axis.title.y = element_text(angle = 0, vjust = 0.5),
      
      panel.grid.major = element_line(color = "grey92", linewidth = 0.5),
      panel.grid.minor = element_line(color = "grey96", linewidth = 0.25),
      
      panel.grid.major.x = element_blank(),
      panel.grid.minor.x = element_blank()
    )
}

plot_groupes <- function(echelle, filtre, individu){
  if (ordre_famille_bool(echelle) && filtre == "insecte") {
    df <- df_long_insectes_order
    couleurs <- couleur_i_o
    
  } else if (ordre_famille_bool(echelle) && filtre == "plante") {
    df <- df_long_plant_family
    couleurs <- couleur_p_f
    
  } else if (!ordre_famille_bool(echelle) && filtre == "insecte") {
    df <- df_long_insect_genus
    couleurs <- couleur_i_g
  } else {
    df <- df_long_plant_genus
    couleurs <- couleur_p_g
  }
  
  df <- df %>%
    filter(Espece == individu)
  
  ggplot(df, aes(x = Espece, y = Annee, fill = Groupe)) +
    geom_tile(color = "white", linewidth = 0.2) + 
    scale_fill_manual(
      values = couleurs,
      drop = FALSE
    ) +
    labs(
      x = individu,
      y = "Année",
      fill = "Groupe"
    ) +
    theme(
      axis.text.x = element_blank(),
      axis.text.y = element_text(face = "bold", size = 9),
      panel.grid = element_blank(),
      axis.title = element_text(face = "bold"),
      axis.title.y = element_text(angle = 0, vjust = 0.5, hjust = 1)
    )
}