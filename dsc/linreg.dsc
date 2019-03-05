# simulate modules
# ================

# Add comments here.
toydata: toydata.R
  seed:     R{1:20}
  scenario: 1, 2, 3, 4
  $X:       dat$train$X
  $y:       dat$train$y
  $beta:    dat$b
  $se:      dat$se

DSC:
  define:
    simulate: toydata
  run: simulate
