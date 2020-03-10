This repository contains a few Dockerfiles related to [Stan](http://mc-stan.org/).  This is based off of an initial container made by [Jeffrey Arnold](https://github.com/jrnold/docker-stan) and adjusted by [Jon Zelner](https://github.com/jzelner/docker-rstan).

This installs Rstan v. 2.21 and several associated packages. 

This builds from [rocker/tidyverse](https://registry.hub.docker.com/u/rocker/verse/) to provide an image with Rstudio and common **R** [tidyverse](https://tidyverse.com) packages.
See the [rocker](https://github.com/rocker-org/rocker) site for more information on using Rstudio with R. It inclues the following packages:

- [rstan](http://mc-stan.org/interfaces/rstan.html)
- [rstanarm](http://mc-stan.org/interfaces/rstanarm.html)
- [brms](http://mc-stan.org/interfaces/brms.html)
- [bayesplot](http://mc-stan.org/interfaces/bayesplot.html)
- [loo](http://mc-stan.org/interfaces/loo.html)
- [projpred](https://mc-stan.org/projpred/)
- [shinystan](http://mc-stan.org/interfaces/shinystan.html)
- [tidybayes](https://mjskay.github.io/tidybayes/index.html)

# Include a section on how to run it


# Containers and status

| Docker Container Source on GitHub             | Docker Hub Build Status and URL
| :---------------------------------------      | :-----------------------------------------
| rstan        | [good](https://registry.hub.docker.com/u/jrnold/rstan/)
