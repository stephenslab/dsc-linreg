Y.fit = glmnet::glmnet(X,Y,alpha=alpha,intercept=FALSE)
Y.cv = glmnet::cv.glmnet(X,Y,alpha=alpha,intercept=FALSE,lambda=Y.fit$lambda)
bhat = glmnet::predict.glmnet(Y.fit, type="coefficients", s = Y.cv$lambda.min)[-1,1]
