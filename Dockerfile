FROM rocker/tidyverse:latest
MAINTAINER Christopher Peterson Christopher.R.Peterson@gmail.com

# Based off of jzelner/docker-rstan/
# This is updated to use the GitHub development version of Rstan 
# Plus brms

# Install clang to use as compiler
# clang seems to be more memory efficient with the templates than g++
# with g++ rstan cannot compile on docker hub due to memory issues
# Also install V8 & TBB, new dependencies for rstan
RUN apt-get update \ 
	&& apt-get install -y --no-install-recommends \
                   clang-6.0 \
		               libv8-dev \
		               libtbb-dev

RUN ln -s /usr/bin/clang++-6.0 /usr/bin/clang++ \
    && ln -s /usr/bin/clang-6.0 /usr/bin/clang

# Global site-wide config
RUN mkdir -p $HOME/.R/ \
    && echo "\nCXX=clang++ -ftemplate-depth-256\n" >> $HOME/.R/Makevars \
    && echo "CC=clang\n" >> $HOME/.R/Makevars
    
# Install rstan dependencies
RUN install2.r --error --deps TRUE\
    inline \
    RcppEigen \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

# Install up-to-date version of rstan
# Currently, it doesn't work on CRAN
# This comes from an answer here:
  # https://discourse.mc-stan.org/t/rstan-and-stan-2-20-0/13486/3
RUN Rscript -e 'install.packages("https://cran.r-project.org/src/contrib/Archive/StanHeaders/StanHeaders_2.21.0-1.tar.gz", repos = NULL); remotes::install_github("stan-dev/rstan", ref = "develop", subdir = "rstan/rstan")'

# Install other stan packages
RUN install2.r --error\
  loo \
  bayesplot \
  rstanarm \
  rstantools \
  brms \
  projpred \
  shinystan \
  tidybayes \
  && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

# Config for rstudio user
RUN mkdir -p /home/rstudio/.R/ \
    && echo "\nCXX=clang++ -ftemplate-depth-256\n" >> /home/rstudio/.R/Makevars \
    && echo "CC=clang\n" >> /home/rstudio/.R/Makevars \
    && echo "CXXFLAGS=-O3\n" >> /home/rstudio/.R/Makevars \
    && echo "\nrstan::rstan_options(auto_write = TRUE)" >> /home/rstudio/.Rprofile \
    && echo "options(mc.cores = parallel::detectCores())" >> /home/rstudio/.Rprofile
    

RUN apt-get update \ 
	&& apt-get install -y --no-install-recommends \
                   curl \
        && apt-get install -t unstable -y --no-install-recommends \
                   texlive-xetex \
                   texlive-fonts-extra
USER rstudio
