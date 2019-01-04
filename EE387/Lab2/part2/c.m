close all;

x = [1 1 1 1 1 0 0 0 0 0 0 0 0 0 0];
h = [2 4 8 16 32 64 0 0 0 0 0 0 0 0 0];

y = myconv(x, h);
y1 = conv(x, h);

subplot(4,1,1);
stem(x);
title('x(n) Graph');

subplot(4,1,2);
stem(h);
title('h(n) Graph');

subplot(4,1,3);
stem(y);
title('My Convolution Graph');

subplot(4,1,4);
stem(y1);
title('conv command Graph');