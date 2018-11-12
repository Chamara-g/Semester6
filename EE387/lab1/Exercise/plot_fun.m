function y = plot_fun(x,h)

y = conv(x,h);

subplot(3,1,1);
stem(x);
title('x(n) Graph');

subplot(3,1,2);
stem(h);
title('h(n) Graph');

subplot(3,1,3);
stem(y);
title('y(n) Graph');