FROM rocker/shiny:latest

# 1. Installation de TOUTES les dépendances système Linux pour les packages R graphiques et réseaux
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

# 2. Configuration du miroir de binaires Linux Ubuntu (Posit Package Manager)
ENV CRAN_BINARY_REPO="https://packagemanager.posit.co/cran/__linux__/noble/2026-03-01"

# 3. Installation ordonnée de tous les packages R
RUN R -e "options(repos = c(CRAN = '$CRAN_BINARY_REPO')); \
    install.packages(c( \
        'cpp11', \
        'systemfonts', \
        'textshaping', \
        'ragg', \
        'svglite', \
        'vctrs', \
        'pillar', \
        'tibble', \
        'isoband', \
        'S7', \
        'shiny', \
        'bslib', \
        'bsicons', \
        'thematic', \
        'tidyr', \
        'dplyr', \
        'ggplot2', \
        'igraph', \
        'network', \
        'sna', \
        'bipartite', \
        'scales' \
    ))"

# 4. Copie des fichiers de ton application Shiny
COPY . /srv/shiny-server/

# 5. Configuration du port
EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/srv/shiny-server', host='0.0.0.0', port=3838)"]