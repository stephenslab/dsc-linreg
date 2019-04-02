# dsc-linreg

A DSC for evaluating prediction accuracy of linear regression methods
in different scenarios.

# How to use this DSC

First, install [DSC][dsc].

Next, install [R][R], and the R packages used in this DSC, including
dscrutils. Some of the packages can be installed from CRAN,

```R
install.packages("devtools")
install.packages("glmnet")
```

and the others can be installed from GitHub:

```R
library(devtools)
install_github("stephenslab/dsc",subdir = "dscrutils")
install_github("stephenslab/susieR")
install_github("pcarbo/varbvs")
```

Run the DSC. (How long is it expected to take to run?)

Explore the results of the DSC in R.

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
