clear all;

x = 0:3;
y = [1 2 2.5 3 3 3 2 1 0 0 0 0 0 0 0];
h = impulse(x);

xnew = deconv(y, h);

subplot(3,1,1);
stem(y);
title('y(n) Graph');

subplot(3,1,2);
stem(h);
title('h(n) Graph');

subplot(3,1,3);
stem(xnew);
title('x(n) Graph');