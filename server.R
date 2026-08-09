# <<<<<<<<<<<< [ Logique serveur ] >>>>>>>>>>>>

server <- function(input, output, session) {
  
  # Pour ajouter un menu de sélection des thèmes
  # bs_themer()
  
  # <<<<<<<<<<<< [ Page 2 ] >>>>>>>>>>>>
  
  output$titre_reseau_brut <- renderText(
    titre_reseau_brut(input$annee_p2)
  )
  
  output$plot_general_reseau <- renderPlot(
    plot_general_reseau(input$annee_p2)
  )
  
  # <<<<<<<<<<<< [ Page 3 ] >>>>>>>>>>>>
  
  output$plot_nb_obs <- renderPlot(
    plot_nb_obs(),
    res = res_base
  )
  
  output$titre_pourcentage_na_graphique <- renderText(
    titre_pourcentage_na_graphique(input$echelle_p3)
  )
  
  output$plot_valeur_manquante <- renderPlot(
    plot_valeur_manquante(input$echelle_p3),
    res = res_base
  )
  
  output$titre_valeur_obs <- renderText(
    titre_valeur_obs(input$annee_p3)
  )
  
  output$valeur_obs_annee <- renderText(
    valeur_obs_annee(input$annee_p3)
  )
  
  output$titre_valeur_NA_plante <- renderText(
    titre_valeur_NA_plante(input$annee_p3, input$echelle_p3)
  )
  
  output$valeur_NA_plante <- renderText(
    valeur_NA_plante(input$echelle_p3, input$annee_p3)
  )
  
  output$titre_valeur_NA_insecte <- renderText(
    titre_valeur_NA_insecte(input$annee_p3, input$echelle_p3)
  )
  
  output$valeur_NA_insecte <- renderText(
    valeur_NA_insecte(input$echelle_p3, input$annee_p3)
  )
  
  output$titre_plot_connectance <- renderText(
    titre_plot_connectance(input$echelle_p3)
  )
  
  output$plot_connectance <- renderPlot(
    plot_connectance(input$echelle_p3),
    res = res_base
  )
  
  output$titre_plot_emboitement <- renderText(
    titre_plot_emboitement(input$echelle_p3)
  )
  
  output$plot_emboitement <- renderPlot(
    plot_emboitement(input$echelle_p3),
    res = res_base
  )
  
  output$titre_valeur_connectance <- renderText(
    titre_valeur_connectance(input$echelle_p3, input$annee_p3)
  )
  
  output$valeur_connectance <- renderText(
    valeur_connectance(input$echelle_p3, input$annee_p3)
  )
  
  output$titre_valeur_emboitement <- renderText(
    titre_valeur_emboitement(input$echelle_p3, input$annee_p3)
  )
  
  output$valeur_emboitement <- renderText(
    valeur_emboitement(input$echelle_p3, input$annee_p3)
  )
  
  # <<<<<<<<<<<< [ Page 4 ] >>>>>>>>>>>>
  
  output$titre_nb_groupes <- renderText(
    titre_nb_groupes(input$echelle_p4)
  )
  
  output$valeur_nb_groupes <- renderText(
    valeur_nb_groupes(input$echelle_p4)
  )
  
  output$titre_tableau_plantes <- renderText(
    titre_tableau_plantes(input$echelle_p4, input$annee_p4)
  )
  
  output$tableau_plantes <- renderTable(
    tableau_plantes(input$echelle_p4, input$annee_p4)
  )
  
  output$titre_tableau_insectes <- renderText(
    titre_tableau_insectes(input$echelle_p4, input$annee_p4)
  )
  
  output$tableau_insectes <- renderTable(
    tableau_insectes(input$echelle_p4, input$annee_p4)
  )
  
  output$titre_plot_connectivite <- renderText(
    titre_plot_connectivite(input$echelle_p4, input$annee_p4, input$affichage_p4)
  )
  
  output$plot_connectivite_groupes <- renderPlot(
    plot_connectivite_groupes(input$echelle_p4, input$annee_p4, input$affichage_p4),
    res = res_base
  )
  
  output$titre_plot_transition <- renderText(
    titre_plot_transition(input$echelle_p4, input$annee_p4)
  )
  
  output$plot_matrice_transition <- renderPlot(
    plot_matrice_transition(input$echelle_p4),
    res = res_base
  )
  
  # <<<<<<<<<<<< [ Page 5 ] >>>>>>>>>>>>
  
  update_selecteur_p5(input)
  
  output$titre_plot_degres <- renderText(
    titre_plot_degres(input$echelle_p5, input$individu_p5)
  )
  
  output$plot_degres <- renderPlot(
    plot_degres(input$echelle_p5, input$filtre_p5, input$individu_p5),
    res = res_base
  )
  
  output$titre_graphique_groupes <- renderText(
    titre_graphique_groupes(input$echelle_p5, input$individu_p5)
  )
  
  output$plot_groupes <- renderPlot(
    plot_groupes(input$echelle_p5, input$filtre_p5, input$individu_p5),
    res = res_base
  )
  
  output$valeur_moyenne_degres <- renderText(
    valeur_moyenne_degres(input$echelle_p5, input$individu_p5)
  )
  
  output$valeur_sd_degres <- renderText(
    valeur_sd_degres(input$echelle_p5, input$individu_p5)
  )
  
  output$valeur_annee_0_degres <- renderText(
    valeur_annee_0_degres(input$echelle_p5, input$individu_p5)
  )
}