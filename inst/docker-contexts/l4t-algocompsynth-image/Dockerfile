FROM nvcr.io/nvidia/l4t-base:r32.4.2
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

ARG DEBIAN_FRONTEND=noninteractive
ARG BUILDING_DOCKER_IMAGE=yes
ARG SOURCE_DIR=/usr/local/src
ENV PAPERSIZE=letter

USER root
WORKDIR $SOURCE_DIR/

RUN locale-gen en_US.UTF-8 \
  && update-locale \
    LANG=en_US.UTF-8 \
    LC_CTYPE=en_US.UTF-8 \
    LC_NUMERIC=en_US.UTF-8 \
    LC_TIME=en_US.UTF-8 \
    LC_COLLATE=en_US.UTF-8 \
    LC_MONETARY=en_US.UTF-8 \
    LC_MESSAGES=en_US.UTF-8 \
    LC_PAPER=en_US.UTF-8 \
    LC_NAME=en_US.UTF-8 \
    LC_ADDRESS=en_US.UTF-8 \
    LC_TELEPHONE=en_US.UTF-8 \
    LC_MEASUREMENT=en_US.UTF-8 \
    LC_IDENTIFICATION=en_US.UTF-8 \
  && cat /etc/default/locale

# upgrade the OS
COPY apt-upgrade $SOURCE_DIR/
RUN $SOURCE_DIR/apt-upgrade > apt-upgrade.log 2>&1; \
  gzip -9 apt-upgrade.log

# install R
COPY install-r R.conf $SOURCE_DIR/
RUN $SOURCE_DIR/install-r > install-r.log 2>&1; \
  gzip -9 install-r.log

# install RStudio Server
ARG RSTUDIO_VERSION_MAJOR=1
ARG RSTUDIO_VERSION_MINOR=3
ARG RSTUDIO_VERSION_PATCH=959
ARG RSTUDIO_VERSION=$RSTUDIO_VERSION_MAJOR.$RSTUDIO_VERSION_MINOR.$RSTUDIO_VERSION_PATCH
ARG RSTUDIO_TAG=v$RSTUDIO_VERSION

COPY install-rstudio-server $SOURCE_DIR/
RUN $SOURCE_DIR/install-rstudio-server > install-rstudio-server.log 2>&1; \
  gzip -9 install-rstudio-server.log

# configure RStudio Server
COPY rstudio-configure rserver.conf $SOURCE_DIR/
RUN $SOURCE_DIR/rstudio-configure

# create non-root user with 'sudo' privilege
RUN useradd \
  --shell /bin/bash \
  --user-group \
  --groups sudo \
  --create-home \
  --uid 1000 algocompsynth \
  && echo "algocompsynth:algocompsynth" | chpasswd

# set up the user
ARG HOME=/home/algocompsynth

# Populate 'algocompsynth' home
COPY --chown=algocompsynth:algocompsynth bash_aliases $HOME/.bash_aliases
COPY --chown=algocompsynth:algocompsynth Rprofile $HOME/.Rprofile
COPY --chown=algocompsynth:algocompsynth Renviron $HOME/.Renviron
COPY --chown=algocompsynth:algocompsynth Installers $HOME/Installers

# install dependencies for Python and R packages
RUN $HOME/Installers/apt-packages > $HOME/Installers/apt-packages.log 2>&1; \
  gzip -9 $HOME/Installers/apt-packages.log
RUN chown -R algocompsynth:algocompsynth $HOME/

ENV PROJECT_HOME=$HOME/Projects
ENV WORKON_HOME=$HOME/.virtualenvs

USER algocompsynth
WORKDIR $HOME/

# set up Python virtulaenv and R library
RUN $HOME/Installers/create-venvs > $HOME/Installers/create-venvs.log 2>&1; \
  gzip -9 $HOME/Installers/create-venvs.log

# install Python packages
RUN $HOME/Installers/pip-installs > $HOME/Installers/pip-installs.log 2>&1; \
  gzip -9 $HOME/Installers/pip-installs.log

# install R packages
RUN $HOME/Installers/R-installs > $HOME/Installers/R-installs.log 2>&1; \
  gzip -9 $HOME/Installers/R-installs.log

# switch back to root
USER root
WORKDIR $SOURCE_DIR/

# set up entry point
COPY docker-entrypoint.sh /
CMD [ "/docker-entrypoint.sh" ]
