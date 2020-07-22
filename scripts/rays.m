% Dimensions in mm
l = 297;
fw = 135/2;
fh = 20;

mx = 40;
my = 0;

syms a x
assume(a, 'real')
assumeAlso(a, 'positive')
assumeAlso(a ~= 0)

y = a*x^2 + (fh + my) - a*(fw + mx)^2;
f = sqrt(1 + diff(y, x)^2);
eqn = int(f, 0, fw+mx) - l/2 == 0;

subs_y = subs(y, a, solve(eqn, a));
soln = vpasolve(subs_y == 0, x);

if soln(2) > fw
    xincidence = -0.85*fw;
    yincidence = subs(subs_y, x, xincidence);
    nslope = -1/subs(diff(subs_y, x), x, xincidence);    
    rslope = 2*nslope/(1-nslope^2);
    
    refray = yincidence + rslope*(x - xincidence);
    refpoint = vpasolve(refray==0, x);        
end





