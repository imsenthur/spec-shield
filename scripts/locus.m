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

curve = subs(y, a, solve(eqn, a));
