FROM rocker/shiny:latest

# 1. Dépendances système (inclus libgsl-dev pour bipartite)
RUN apt-get update && apt-get install -y \
    libxml2-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-dev \
    libgsl-dev \
    && rm -rf /var/lib/apt/lists/*

# 2. Configurer le dépôt figé (Snapshot Posit)
ENV CRAN_REPO="https://packagemanager.posit.co/cran/2026-03-01"

# 3. Installation explicite des packages
RUN R -e "options(repos = c(CRAN = '$CRAN_REPO')); \
    pkgs <- c('shiny', 'bslib', 'bsicons', 'thematic', 'svglite', 'tidyr', 'dplyr', 'ggplot2', 'bipartite', 'igraph', 'scales', 'ragg'); \
    install.packages(pkgs, Ncpus = 2); \
    missing <- pkgs[!pkgs %in% installed.packages()[, 'Package']]; \
    if (length(missing) > 0) stop(paste('Packages manquants :', paste(missing, collapse = ', ')))"

# 4. Copie des fichiers et configuration Shiny
COPY . /srv/shiny-server/

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/srv/shiny-server', host='0.0.0.0', port=3838)"]