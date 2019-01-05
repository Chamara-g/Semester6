omega = linspace(-20, 20, 200);
sigma = linspace(-5, 5, 200);

[sigmagrid, omegagrid] = meshgrid(sigma, omega);
sgrid = sigmagrid + 1i*omegagrid;

b = [2 2 17];
a = [1 4 104];
H1 = polyval(b, sgrid)./polyval(a, sgrid);
mesh(sigma, omega, 20*log10(abs(H1)));





