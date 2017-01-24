function [ym, Pyy, Pxy] = ut(f, xm, Pxx)
xm = xm(:);
mapcols = @(f,x)cell2mat(cellfun(f,mat2cell(x, size(x,1),ones(1,size(x,2))),'UniformOutput',false));

n =length(xm);
kappa = 3-n;
w0 = kappa/(n + kappa);
wi = 1/(2*(n + kappa));
W = diag([w0; wi*ones(2*n,1)]);

L = chol(Pxx);
X = [xm';
    ones(n,1)*xm'+sqrt(n + kappa)*L;
    ones(n,1)*xm'-sqrt(n + kappa)*L];

Y = mapcols(f,X')';

ym = sum(W*Y)';

Yd = bsxfun(@minus, Y, ym');
Xd = bsxfun(@minus, X, xm');
Pyy = Yd'*W*Yd;
Pxy = Xd'*W*Yd;

end