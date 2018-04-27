# dsc-reg
DSC for comparing regression methods.

## Run benchmark

For 20 replicates,

```
./benchmark.dsc --replicate 20
```

## Available pipelines

```
$ ./benchmark.dsc -h

INFO: MODULES
+-----------+--------------------------+---------+-------------------------------+--------+
|           |        parameters        |  input  |             output            |  type  |
+-----------+--------------------------+---------+-------------------------------+--------+
|   en_sim  |         scenario         |         | Y, X, Ytest, Xtest, beta_true |   R    |
|   sparse  | scenario, n, p, pve, pi0 |         | Y, X, Ytest, Xtest, beta_true |   R    |
|   dense   | scenario, n, p, pve, pi0 |         | Y, X, Ytest, Xtest, beta_true |   R    |
| varbvsmix |                          |   X, Y  |            beta_est           |   R    |
|   BayesC  |                          |   X, Y  |            beta_est           |   R    |
|   lasso   |          alpha           |   X, Y  |            beta_est           |   R    |
|   ridge   |          alpha           |   X, Y  |            beta_est           |   R    |
|     en    |          alpha           |   X, Y  |            beta_est           |   R    |
|   susie   |            L             |   X, Y  |            beta_est           |   R    |
|   susie2  |            L             |   X, Y  |            beta_est           |   R    |
|   varbvs  |                          |   X, Y  |            beta_est           |   R    |
|  pred_err |                          | b, Y, X |              err              |   R    |
|  coef_err |                          |   b, a  |              err              |   R    |
|   glmnet  |                          |   X, Y  |            beta_est           | unused |
+-----------+--------------------------+---------+-------------------------------+--------+

INFO: PIPELINES
1: simulate -> analyze -> score

INFO: PIPELINES EXPANDED
1: en_sim -> varbvsmix -> pred_err
2: en_sim -> varbvsmix -> coef_err
3: en_sim -> BayesC -> pred_err
4: en_sim -> BayesC -> coef_err
5: en_sim -> lasso -> pred_err
6: en_sim -> lasso -> coef_err
7: en_sim -> ridge -> pred_err
8: en_sim -> ridge -> coef_err
9: en_sim -> en -> pred_err
10: en_sim -> en -> coef_err
11: en_sim -> susie -> pred_err
12: en_sim -> susie -> coef_err
13: en_sim -> susie2 -> pred_err
14: en_sim -> susie2 -> coef_err
15: en_sim -> varbvs -> pred_err
16: en_sim -> varbvs -> coef_err
17: sparse -> varbvsmix -> pred_err
18: sparse -> varbvsmix -> coef_err
19: sparse -> BayesC -> pred_err
20: sparse -> BayesC -> coef_err
21: sparse -> lasso -> pred_err
22: sparse -> lasso -> coef_err
23: sparse -> ridge -> pred_err
24: sparse -> ridge -> coef_err
25: sparse -> en -> pred_err
26: sparse -> en -> coef_err
27: sparse -> susie -> pred_err
28: sparse -> susie -> coef_err
29: sparse -> susie2 -> pred_err
30: sparse -> susie2 -> coef_err
31: sparse -> varbvs -> pred_err
32: sparse -> varbvs -> coef_err
33: dense -> varbvsmix -> pred_err
34: dense -> varbvsmix -> coef_err
35: dense -> BayesC -> pred_err
36: dense -> BayesC -> coef_err
37: dense -> lasso -> pred_err
38: dense -> lasso -> coef_err
39: dense -> ridge -> pred_err
40: dense -> ridge -> coef_err
41: dense -> en -> pred_err
42: dense -> en -> coef_err
43: dense -> susie -> pred_err
44: dense -> susie -> coef_err
45: dense -> susie2 -> pred_err
46: dense -> susie2 -> coef_err
47: dense -> varbvs -> pred_err
48: dense -> varbvs -> coef_err

INFO: R LIBRARIES
INFO: Scanning package versions ...
+--------+---------+
|  name  | version |
+--------+---------+
|  BGLR  |  1.0.5  |
|  MASS  |  7.3.47 |
| glmnet |  2.0.13 |
| susieR |  0.1.4  |
| varbvs |  2.5.2  |
+--------+---------+
```
