FROM rocker/shiny:latest

# 1. Dépendances système Linux
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
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

# 2. FIGEAGE DU CRAN : Utilisation d'un Snapshot Posit daté au 1er mars 2026
RUN echo "options(repos = c(CRAN = 'https://packagemanager.posit.co/cran/2026-08-01'), Ncpus = 1)" >> /usr/local/lib/R/etc/Rprofile.site

# 3. Étape 1 : Socle C++ & dépendances fondamentales
RUN R -e "install.packages(c('cpp11', 'Rcpp', 'RcppEigen', 'vctrs', 'pillar', 'cli', 'rlang', 'lifecycle', 'pkgconfig', 'S7', 'isoband'))"

# 4. Étape 2 : Graphiques et polices
RUN R -e "install.packages(c('systemfonts', 'textshaping', 'ragg', 'svglite', 'thematic'))"

# 5. Étape 3 : Tidyverse & Shiny UI
RUN R -e "install.packages(c('tibble', 'purrr', 'tidyselect', 'generics', 'dplyr', 'tidyr', 'ggplot2', 'scales', 'shiny', 'bslib', 'bsicons'))"

# 6. Étape 4 : Réseaux et calculs complexes
RUN R -e "install.packages(c('igraph', 'statnet.common', 'network', 'sna', 'bipartite'))"

# 7. Copie des fichiers de l'application
COPY . /srv/shiny-server/

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/srv/shiny-server', host='0.0.0.0', port=3838)"]