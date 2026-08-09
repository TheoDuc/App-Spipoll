FROM rocker/shiny:latest

# 1. Dépendances système Linux complètes (Graphiques, Compilateurs, Réseaux)
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
    libharfbuzz-dev \
    libfribidi-dev \
    libgsl-dev \
    && rm -rf /var/lib/apt/lists/*

# 2. Variable pour casser le cache Docker et forcer une réinstallation propre
ARG CACHE_DATE=2026-03-01

# 3. Installation robuste et exhaustive de TOUS tes packages et DE TOUTES leurs dépendances
RUN R -e "options(repos = c(CRAN = 'https://packagemanager.posit.co/cran/__linux__/noble/2026-03-01')); \
    target_pkgs <- c('shiny', 'bslib', 'bsicons', 'thematic', 'svglite', 'tidyr', 'dplyr', 'ggplot2', 'bipartite', 'igraph', 'scales', 'ragg'); \
    install.packages(target_pkgs, dependencies = c('Depends', 'Imports', 'LinkingTo')); \
    missing <- target_pkgs[!target_pkgs %in% installed.packages()[, 'Package']]; \
    if (length(missing) > 0) { stop(paste('ERREUR CRITIQUE - Packages non installés :', paste(missing, collapse = ', '))); }"

# 4. Copie des fichiers de l'application
COPY . /srv/shiny-server/

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/srv/shiny-server', host='0.0.0.0', port=3838)"]