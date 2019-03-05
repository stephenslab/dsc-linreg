# TO DO: Give overview of DSC here.

# simulate modules
# ================
# TO DO: Give overview of simulate modules here.

# TO DO: Add comments here describing what this module does.
toydata: toydata.R
  seed:     R{1:20}
  scenario: 1, 2, 3, 4
  $X:       dat$train$X
  $y:       dat$train$y
  $beta:    dat$b
  $se:      dat$se

# fit modules
# -----------
# TO DO: Give overview of fit modules here.

# TO DO: Add comments here describing what this module does.
ridge: ridge.R
  X: $X
  y: $y
  
# predict modules
# ---------------
# TO DO: Give overview of predict modules here.

# score modules
# -------------
# TO DO: Give overview of score modules here.  

DSC:
  define:
    simulate: toydata
  run: simulate
