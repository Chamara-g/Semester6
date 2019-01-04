close all;

n = -10:10;
h = unitStep(n);
x = fun_x(n);
y = myconv(x,h);

subplot(3,1,1);
stem(n,x);
title('x(n) Graph');

subplot(3,1,2);
stem(n,h);
title('h(n) Graph');

subplot(3,1,3);
stem(y);
title('y(n) Graph');