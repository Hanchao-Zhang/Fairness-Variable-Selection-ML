%%
load('simulatedata.mat');
b = B
% set M and N
fun = @(x) lasso(x,A,b,rho);
[n,p] = size(A);
x = zeros(p,1);
z = x;
u = x;
rho = 1;
lambda = .05;
tol = 1e-10;
maxit = 5e2;
[f_all1, niter1, x1] = ADMM(fun, x, z, u, rho, lambda, tol, maxit);
f_star1 = min(f_all1);

%%
semilogy(1:niter1,f_all1 - f_star1, 'o')





