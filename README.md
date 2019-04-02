# dsc-linreg

A DSC for evaluating prediction accuracy of linear regression methods
in different scenarios.

## Instructions for use

First, install [DSC][dsc].

Next, install [R][R], and the R packages used. The devtools and glmnet
packages can be installed from CRAN:

```R
install.packages("devtools")
install.packages("glmnet")
install.packages("ggplot2")
install.packages("cowplot")
```

The susieR, varbvs and dscrutils packages can be installed from GitHub
using [devtools][devtools]:

```R
library(devtools)
install_github("stephenslab/dsc",subdir = "dscrutils")
install_github("stephenslab/susieR")
install_github("pcarbo/varbvs",subdir = "varbvs-R")
```

Clone or download this git repository.

Now you should have everything you need to run the DSC. Navigate to
the "dsc" directory inside your local copy of the git repository, and
run it with this command (here we have chosen 4 threads, but you may
want to adjust the number of threads to better suit your computer):

```bash
dsc -c 4 linreg.dsc
```

Go grab a coffee while you wait for the DSC to run. It will take some
time, perhaps as long as 10--20 minutes, for all the DSC pipelines
to complete.

Once the DSC has finished running, you work through
[this short analysis](https://stephenslab.github.io/dsc-linreg/index.html)
to explore the results of the DSC in R. When running the code in R,
make sure your working directory is set to the "analysis" directory in
the git repository.

Please revise or expand on our DSC as you see fit.

[dsc]: https://github.com/stephenslab/dsc
[R]: www.r-project.org
[devtools]: https://github.com/r-lib/devtools
