# <<<<<<<<<<<< [ User Interface (UI) ] >>>>>>>>>>>>

ui <- page_navbar(
  
  # <<<<<<<<<<<< [ Theme ] >>>>>>>>>>>>
  
  theme = bs_theme(
    version = 5,
    bootswatch = "darkly",
    success = "#01224a"
  ),
  
  # Les lignes suivantes résolvent un problème de dimension des box au lancement de l'application
  tags$head(
    # 1. CSS : Empêche la création de scrollbars parasites dans les cartes
    tags$style(HTML("
      .card, .card-body {
        overflow: hidden !important;
      }
      .shiny-plot-output {
        max-height: 100% !important;
        max-width: 100% !important;
      }
    ")),
    
    # 2. JS : Ajuste automatiquement la taille des plots dès que le DOM Shiny est stable
    tags$script(HTML("
      $(document).on('shiny:visualchange', function(event) {
        window.dispatchEvent(new Event('resize'));
      });
    "))
  ),
  
  
  
  
  
  # <<<<<<<<<<<< [ Page 1 : Accueil ] >>>>>>>>>>>>
  
  nav_panel(
    title = "Accueil",
    
    # Grille ou conteneur centré
    layout_columns(
      col_widths = c(12),
      
      card(
        card_header(
          class = "bg-primary text-white",
          h4("Présentation du Projet & Contexte", class = "m-0")
        ),
        
        # Utilisation du Markdown (ultra propre et lisible dans le code !)
        markdown("
        ##### Données & Objectifs
        
        Les données proviennent de la base de données **Spipoll**, une campagne de science participative à l'échelle de la France. 
            
        Cette application a été réalisée en **Août 2026** et s'appuie sur les données récoltées de **2010 à 2025**. Son objectif principal est d'analyser la structure du réseau de pollinisation à travers :
        * Des **analyses exploratoires** globales.
        * L'application du modèle **dynSBM** (clustering des plantes et insectes selon la similarité de leurs interactions).
        
        ---
        
        ##### Échelles d'Analyse
        Deux échelles taxonomiques ont été explorées :
        1. **Ordre / Famille** : Les familles de plantes avec les ordres d'insectes.
        2. **Genre / Genre** : Le genre d'insecte avec le genre de plante.
        
        > *Vous pourrez passer d'une échelle à l'autre à tout moment dans les différentes pages grâce au champ de sélection dédié.*
        ")
      )
    ),
    
    layout_columns(
      col_widths = c(6, 6),
      
      # Profil Théo Duchateau
      card(
        card_header(
          class = "bg-primary text-white",
          h5("Auteur de l'application")
        ),
        card_body(
          class = "d-flex align-items-center gap-3",
          
          # Ta photo en bulle (placée dans le dossier www/)
          tags$img(
            src = "Le_Theox.jpg", 
            class = "rounded-circle border border-2 border-primary",
            style = "width: 120px; height: 120px; object-fit: cover;"
          ),
          
          # Mes infos
          div(
            h5("Théo Duchâteau", class = "mb-1"),
            p("Étudiant - Stagiaire ENSAI", class = "text-muted mb-1"),
            p("Rôle : Développement de l'application & Modélisation dynSBM", class = "small m-0")
          )
        )
      ),
      
      # 2. Profil Emré Anakok
      card(
        card_header(
          class = "bg-primary text-white",
          h5("Encadrant")
        ),
        card_body(
          class = "d-flex align-items-center gap-3",
          
          # Sa photo en bulle
          tags$img(
            src = "photo_emre_anakok.jpg", 
            class = "rounded-circle border border-2 border-info",
            style = "width: 120px; height: 120px; object-fit: cover;"
          ),
          
          div(
            h5("Emré Anakok", class = "mb-1"),
            p("Maitre de Stage / Chercheur MAP5", class = "text-muted mb-1"),
            p("Encadrement : Supervision scientifique & Spipoll", class = "small m-0")
          )
        )
      )
    )
  ),
  
  
  
  
  
  
  
  
  
  
  # <<<<<<<<<<<< [ Page 2 : Le réseau brut ] >>>>>>>>>>>>
  
  nav_panel(
    title = "Le réseau brut",
    
    layout_sidebar(
      sidebar = sidebar(
        contenu_sidebar_p2
        ),
      
      layout_columns(
        card(
          card_header(
            class = "bg-primary text-white",
            h4(textOutput("titre_reseau_brut"))
            ),
          plotOutput("plot_general_reseau")
        ),
        col_widths = c(12)
      )
    )
  ),
  
  
  
  
  
  
  
  
  
  
  # <<<<<<<<<<<< [ Page 3 : Analyses exploratoires ] >>>>>>>>>>>>
  
  nav_panel(
    title = "Analyses exploratoires",
    
    layout_sidebar(
      sidebar = sidebar(
        contenu_sidebar_p3
      ),
      
      layout_columns(
        card(
          card_header(
            class = "bg-primary text-white",
            h4("Session d'observation par an")
          ),
            plotOutput("plot_nb_obs")
        ),
        
        card(
          card_header(
            class = "bg-primary text-white",
            h4(textOutput("titre_pourcentage_na_graphique"))
          ),
          plotOutput("plot_valeur_manquante")
        ),
        
        value_box(
          title = textOutput("titre_valeur_obs"),
          textOutput("valeur_obs_annee"),
          showcase = bs_icon("eye"),
          theme = "primary"
        ),
        
        value_box(
          title = textOutput("titre_valeur_NA_plante"),
          textOutput("valeur_NA_plante"),
          showcase = bs_icon("flower2"),
          theme = "secondary"
        ),
        
        value_box(
          title = textOutput("titre_valeur_NA_insecte"),
          textOutput("valeur_NA_insecte"),
          showcase = bs_icon("bug"),
          theme = "secondary"
        ),
        
        card(
          card_header(
            class = "bg-secondary text-white",
            h4(textOutput("titre_plot_connectance"))
          ),
          plotOutput("plot_connectance")
        ),
        
        card(
          card_header(
            class = "bg-secondary text-white",
            h4(textOutput("titre_plot_emboitement"))
          ),
          plotOutput("plot_emboitement")
        ),
        
        value_box(
          title = textOutput("titre_valeur_connectance"),
          textOutput("valeur_connectance"),
          showcase = bs_icon("share"),
          theme = "primary"
        ),
        
        value_box(
          title = textOutput("titre_valeur_emboitement"),
          textOutput("valeur_emboitement"),
          showcase = bs_icon("box-seam"),
          theme = "primary"
        ),
        
        col_widths = c(4, 8, 4, 4, 4, 6, 6, 6, 6),
        row_heights = c(4, 1, 4, 1)
      )
    )
  ),
  
  
  
  
  
  
  
  
  
  
  # <<<<<<<<<<<< [ Page 4 : Le modèle SBM dynamique ] >>>>>>>>>>>>
  
  nav_panel(
    title = "Le SBM dynamique",
    
    layout_sidebar(
      sidebar = sidebar(
        contenu_sidebar_p4
      ),
      
      layout_columns(
        value_box(
          title = textOutput("titre_nb_groupes"),
          textOutput("valeur_nb_groupes"),
          showcase = bs_icon("people"),
          theme = "primary"
        ),
        
        card(
          card_header(
            class = "bg-primary text-white",
            h4(textOutput("titre_tableau_insectes"))
          ),
          tableOutput("tableau_insectes")
        ),
        
        card(
          card_header(
            class = "bg-primary text-white",
            h4(textOutput("titre_tableau_plantes"))
          ),
          tableOutput("tableau_plantes")
        ),
        
        card(
          card_header(
            class = "bg-primary text-white",
            h4(textOutput("titre_plot_connectivite"))
          ),
          plotOutput("plot_connectivite_groupes")
        ),
        
        card(
          card_header(
            class = "bg-primary text-white",
            h4(textOutput("titre_plot_transition"))
          ),
          plotOutput("plot_matrice_transition")
        ),
        
        col_widths = c(4, 4, 4, 6, 6),
        row_heights = c(2, 6)
      )
    )
  ),
  
  
  
  
  
  
  
  
  
  
  # <<<<<<<<<<<< [ Page 5 : Analyse par individu ] >>>>>>>>>>>>
  
  nav_panel(
    title = "Analyse par individu",
    
    layout_sidebar(
      sidebar = sidebar(
        contenu_sidebar_p5
      ),
      
      layout_columns(
        card(
          card_header(
            class = "bg-primary text-white",
            h4(textOutput("titre_plot_degres"))
          ),
          plotOutput("plot_degres")
        ),
        
        card(
          card_header(
            class = "bg-primary text-white",
            h4(textOutput("titre_graphique_groupes"))
          ),
          plotOutput("plot_groupes")
        ),
        
        value_box(
          title = "Degrés moyens",
          textOutput("valeur_moyenne_degres"),
          showcase = bs_icon("star"),
          theme = "primary"
        ),
        
        value_box(
          title = "Ecart type",
          textOutput("valeur_sd_degres"),
          showcase = bs_icon("arrows-angle-expand"),
          theme = "primary"
        ),
        
        value_box(
          title = "Années d'absence",
          textOutput("valeur_annee_0_degres"),
          showcase = bs_icon("eye-slash"),
          theme = "primary"
        ),
        
        col_widths = c(10, 2, 4, 4, 4),
        row_heights = c(9, 1)
      )
    )
  )
)