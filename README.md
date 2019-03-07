# dsc-reg

DSC for comparing regression methods.

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

Notice that you need to configure `midway.yml` accordingly with your
own account information.  The default setup basically assumes 5
minutes run time per module instance for all modules.  Also notice
that the default check of job status interval is 60 secs so there will
be an interval of at least 60 seconds between batches of submissions.

## Available pipelines

```
$ ./benchmark.dsc -h -v

INFO: MODULES
+------------------------------------------------------------------------------------------+
|                                     Group [simulate]                                     |
|        |      - parameters -      | - input - |           - output -          | - type - |
| en_sim |         scenario         |           | X, Xtest, Y, Ytest, beta_true |    R     |
| sparse | n, p, pi0, pve, scenario |           | X, Xtest, Y, Ytest, beta_true |    R     |
| dense  | n, p, pi0, pve, scenario |           | X, Xtest, Y, Ytest, beta_true |    R     |

+-------------------------------------------------------------------------------------------+
|                                      Group [analyze]                                      |
|            |              - parameters -              | - input - | - output - | - type - |
|  susie05   | L, estimate_residual_variance, prior_var |    X, Y   |  beta_est  |    R     |
|  susie01   | L, estimate_residual_variance, prior_var |    X, Y   |  beta_est  |    R     |
| susie_auto |                                          |    X, Y   |  beta_est  |    R     |
|   varbvs   |                                          |    X, Y   |  beta_est  |    R     |
| varbvsmix  |                                          |    X, Y   |  beta_est  |    R     |
|   BayesC   |                  cache                   |    X, Y   |  beta_est  |    R     |
|   lasso    |                  alpha                   |    X, Y   |  beta_est  |    R     |
|   ridge    |                  alpha                   |    X, Y   |  beta_est  |    R     |
|     en     |                  alpha                   |    X, Y   |  beta_est  |    R     |
|   susie    | L, estimate_residual_variance, prior_var |    X, Y   |  beta_est  |    R     |
|  susie02   | L, estimate_residual_variance, prior_var |    X, Y   |  beta_est  |    R     |
|  susie04   | L, estimate_residual_variance, prior_var |    X, Y   |  beta_est  |    R     |

+----------------------------------------------------------------------------+
|                               Group [score]                                |
|          | - parameters - |       - input -        | - output - | - type - |
| pred_err |                | Xtest, Ytest, beta_est |    err     |    R     |
| coef_err |                |  beta_est, beta_true   |    err     |    R     |

+-------------------------------------------------------------+
|                          Ungrouped                          |
|        | - parameters - | - input - | - output - | - type - |
| glmnet |                |    X, Y   |  beta_est  |  unused  |

INFO: PIPELINES
1: simulate -> analyze -> score

INFO: PIPELINES EXPANDED
1: en_sim * susie05 * pred_err
2: en_sim * susie05 * coef_err
...

INFO: R LIBRARIES
INFO: Scanning package versions ...
+--------+---------+
|  name  | version |
+--------+---------+
|  BGLR  |  1.0.5  |
|  MASS  |  7.3.47 |
| glmnet |  2.0.13 |
| susieR |  0.1.6  |
| varbvs |  2.5.2  |
+--------+---------+
```
