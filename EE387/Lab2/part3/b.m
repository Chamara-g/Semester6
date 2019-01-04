close all;

figure();
n = -10:500;

x = unitStep(n);
y = function_investor(0, x, n);
ht = conv(y, x);

subplot(3,1,1);
stem(n,x);
title('x(t) Graph');

subplot(3,1,2);
stem(n,y);
title('y(t) Graph');

subplot(3,1,3);
stem(ht);
title('h(t) Graph');

figure();
y = function_merchant(0, 100, n);
ht = conv(y, x);
    
subplot(3,1,1);
stem(n,x);
title('x(t) Graph');

subplot(3,1,2);
stem(n,y);
title('y(t) Graph');

subplot(3,1,3);
stem(ht);
title('h(t) Graph');