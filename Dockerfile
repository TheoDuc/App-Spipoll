FROM rocker/shiny:latest

# 1. Installation des dépendances système Linux nécessaires aux packages R (igraph, bipartite, etc.)
RUN apt-get update && apt-get install -y \
    build-essential \
    libxml2-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-dev \
    libtiff5-dev \
    libgsl-dev \
    && rm -rf /var/lib/apt/lists/*

# 2. Installation de tous les packages R depuis le snapshot Posit (figé au 1er mars 2026)
RUN R -e "options(repos = c(CRAN = 'https://packagemanager.posit.co/cran/2026-03-01')); \
    pkgs <- c('shiny', 'bslib', 'bsicons', 'thematic', 'svglite', 'tidyr', 'dplyr', 'ggplot2', 'bipartite', 'igraph', 'scales', 'ragg'); \
    install.packages(pkgs, dependencies = TRUE, Ncpus = 2); \
    missing <- pkgs[!pkgs %in% installed.packages()[, 'Package']]; \
    if (length(missing) > 0) stop(paste('Packages manquants :', paste(missing, collapse = ', ')))"

# 3. Copie des fichiers de ton application dans le répertoire Shiny
COPY . /srv/shiny-server/

# 4. Port d'exposition pour le serveur
EXPOSE 3838

# 5. Commande de lancement de l'application Shiny sur le port 3838
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server', host='0.0.0.0', port=3838)"]