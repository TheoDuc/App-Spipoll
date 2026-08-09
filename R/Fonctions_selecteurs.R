# <<<<<<<<<<<< [ Fonctions sélecteurs ] >>>>>>>>>>>>

update_selecteur_p5 <- function(input){
  observeEvent(c(input$echelle_p5, input$filtre_p5), {
    
    echelle <- input$echelle_p5
    filtre <- input$filtre_p5
    
    if (ordre_famille_bool(echelle) && filtre == "insecte") {
      nouveaux_choix <- tout_insect_order
      
    } else if (ordre_famille_bool(echelle) && filtre == "plante") {
      nouveaux_choix <- tout_plant_family
      
    } else if (!ordre_famille_bool(echelle) && filtre == "insecte") {
      nouveaux_choix <- tout_insect_genus_trie
    } else {
      nouveaux_choix <- tout_plant_genus
    }
    
    updateSelectInput(
      inputId = "individu_p5",
      choices = nouveaux_choix,
      selected = nouveaux_choix[1]
    )
  })
}