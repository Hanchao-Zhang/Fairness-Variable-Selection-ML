function [f_all, niter, x] = ADMM(fun, x, z, u, rho, lambda, tol, maxit)
% calculate the initial value of f, get A and b
[f_all, A, b] = fun(x);
% get the size of x
[N,~] = size(x);
% initiate iteration
niter = 1;
% soft thresholding value
kk = lambda/rho;
f_diff = 10;
%% while loop for descent
while ( abs(f_diff(niter)) > tol && niter < maxit + 1)
     % iteration + 1
     niter = niter + 1
     % solve for xk by slash
     x = (A'*A + rho*speye(N)) \ (A'*b + rho * (z - u));
     % soft-thresholding for z
     z = x + u;
     z(abs(z) > kk) = z(abs(z) > kk) - kk;
     z(abs(z) < kk) = 0;
     z(abs(z) < -kk) = z(abs(z) < -kk) + kk;
     % update u
     u = u + x - z;
     % calculate the function value
     f_all(niter) = fun(x);
     f_diff(niter) = f_all(end) - f_all(end-1);
     f_diff(end)
end;