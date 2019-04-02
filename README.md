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
```

The susieR, varbvs and dscrutils packages can be installed from GitHub
using [devtools][devtools]:

```R
library(devtools)
install_github("stephenslab/dsc",subdir = "dscrutils")
install_github("stephenslab/susieR")
install_github("pcarbo/varbvs",subdir = "varbvs-R")
```

Clone or download this repository.

Now you should have everything you need to run the DSC. Navigate to
the `dsc` directory inside your local copy of the repository, and run
it with this command (here we have chosen 4 threads, but you may want
to adjust the number of threads to better suit your computer):

```bash
dsc -c 4 linreg.dsc
```

Go grab a coffee while you wait for the DSC to run. It will take some
time, perhaps as long as, for all the DSC pipelines to complete.

Once the DSC has finished running, you work through [this short
vignette] to explore the results of the DSC in R.

Revise or expand on the DSC as you see fit.

## Run benchmark

First install the R packages used by the DSC. Then change your working
directory to the "dsc" subdirectory, and run:

```bash
cd dsc
dsc -c 4 linreg.dsc
```

Then go into R to summarize the results:

```R
source("summarize_results.R")
```

[dsc]: https://github.com/stephenslab/dsc
[R]: www.r-project.org
[devtools]: https://github.com/r-lib/devtools
