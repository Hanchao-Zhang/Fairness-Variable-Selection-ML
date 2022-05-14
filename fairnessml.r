fairness_lm = function(x = x_mat, z = z, y = y, lambda1 = 0.5) {
    n = dim(x)[1]
    p = dim(x)[2]

    I = diag(1, n)
    vec1 = matrix(rep(1, n))

    Psquare = t(x) %*% (I + lambda1 * (I - 1/ (n) * vec1 %*% t(vec1) ) ) %*% z %*% t(z) %*% (I + lambda1 * (I - 1/ (n) * vec1 %*% t(vec1) ) ) %*% x

    Q = chol(Psquare, pivot = T)
    pivot = attr(Q, "pivot")
    P = Q[, order(pivot)]


    aug_x_mat = rbind(x_mat, P)

    y_0s = matrix(rep(0, dim(P)[1]))

    aug_y = rbind(y,y_0s)
    lm(aug_y ~ aug_x_mat)

}

fairness_lasso = function(x = x_mat, z = z, y = y, lambda1 = 0.5, lambda2 = 0.5) {
    n = dim(x)[1]
    p = dim(x)[2]

    I = diag(1, n)
    vec1 = matrix(rep(1, n))

    Psquare = t(x) %*% (I + lambda1 * (I - 1/ (n) * vec1 %*% t(vec1) ) ) %*% z %*% t(z) %*% (I + lambda1 * (I - 1/ (n) * vec1 %*% t(vec1) ) ) %*% x

    Q = chol(Psquare, pivot = T)
    pivot = attr(Q, "pivot")
    P = Q[, order(pivot)]


    aug_x_mat = rbind(x_mat, P)

    y_0s = matrix(rep(0, dim(P)[1]))

    aug_y = rbind(y,y_0s)
    #glmnet(x = aug_x_mat, y = aug_y, lambda = lambda2, alpha = 1)
    cv.glmnet(x = aug_x_mat, y = aug_y, alpha = 1)
}


