function [f, A, b] = lasso(x,A,b,rho)
% calculate the lasso function value
f = 0.5 * norm(A*x - b) + rho * norm(x,1);