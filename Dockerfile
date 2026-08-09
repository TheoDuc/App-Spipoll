FROM rocker/shiny:latest

# 1. Dépendances système Linux pour l'ensemble des packages (Réseaux, Graphiques, XML, Math)
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
    libcmake0 \
    && rm -rf /var/lib/apt/lists/*

# 2. Définition du miroir CRAN officiel Posit Snapshot (Source universelle)
RUN R -e "options(repos = c(CRAN = 'https://packagemanager.posit.co/cran/2026-03-01'))"

# 3. Étape A : Socle de base C++ et dépendances fondamentales
RUN R -e "install.packages(c('cpp11', 'Rcpp', 'RcppEigen', 'vctrs', 'pillar', 'cli', 'rlang', 'lifecycle', 'pkgconfig', 'S7', 'isoband'), repos='https://packagemanager.posit.co/cran/2026-03-01')"

# 4. Étape B : Moteur graphique et polices (systemfonts, textshaping, svglite, ragg, thematic)
RUN R -e "install.packages(c('systemfonts', 'textshaping', 'ragg', 'svglite', 'thematic'), repos='https://packagemanager.posit.co/cran/2026-03-01')"

# 5. Étape C : Manipulation de données et Shiny Interface (tibble, dplyr, tidyr, ggplot2, bslib, bsicons, scales)
RUN R -e "install.packages(c('tibble', 'purrr', 'tidyselect', 'generics', 'dplyr', 'tidyr', 'ggplot2', 'scales', 'shiny', 'bslib', 'bsicons'), repos='https://packagemanager.posit.co/cran/2026-03-01')"

# 6. Étape D : Analyse et graphiques de réseaux (igraph, statnet.common, network, sna, bipartite)
RUN R -e "install.packages(c('igraph', 'statnet.common', 'network', 'sna', 'bipartite'), repos='https://packagemanager.posit.co/cran/2026-03-01')"

# 7. Copie des fichiers de l'application
COPY . /srv/shiny-server/

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/srv/shiny-server', host='0.0.0.0', port=3838)"]