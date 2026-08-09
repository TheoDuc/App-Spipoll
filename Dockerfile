FROM rocker/shiny:latest

# 1. Installation des dépendances système Linux de base
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

# 2. Configuration du miroir de binaires Linux Ubuntu (Posit Package Manager)
# Utiliser 'ubuntu-24.04' et 'binary' permet de télécharger des packages R pré-compilés en 2 secondes sans compilation C++
ENV CRAN_BINARY_REPO="https://packagemanager.posit.co/cran/__linux__/noble/2026-03-01"

# 3. Installation de l'ensemble des packages R sous forme de binaires
RUN R -e "options(repos = c(CRAN = '$CRAN_BINARY_REPO')); \
    install.packages(c( \
        'vctrs', \
        'pillar', \
        'tibble', \
        'shiny', \
        'bslib', \
        'bsicons', \
        'thematic', \
        'svglite', \
        'tidyr', \
        'dplyr', \
        'ggplot2', \
        'igraph', \
        'network', \
        'sna', \
        'bipartite', \
        'scales', \
        'ragg' \
    ))"

# 4. Copie des fichiers de ton application Shiny
COPY . /srv/shiny-server/

# 5. Configuration du port
EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/srv/shiny-server', host='0.0.0.0', port=3838)"]