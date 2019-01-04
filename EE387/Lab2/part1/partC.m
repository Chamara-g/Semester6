clear all;

x = 0:20;

subplot(3,3,1)
y1= cos(0*x);
stem(y1);
title('x[n] = cos(0.n)');

subplot(3,3,2)
y1= cos(pi*x/8);
stem(y1);
title('x[n] = cos(pi.n/8)');

subplot(3,3,3)
y1= cos(pi*x/4);
stem(y1);
title('x[n] = cos(pi.n/4)');

subplot(3,3,4)
y1= cos(pi*x/2);
stem(y1);
title('x[n] = cos(pi.n/2)');

subplot(3,3,5)
y1= cos(pi*x);
stem(y1);
title('x[n] = cos(pi.n)');

subplot(3,3,6)
y1= cos(3*pi*x/2);
stem(y1);
title('x[n] = cos(3.pi.n/2)');

subplot(3,3,7)
y1= cos(7*pi*x/2);
stem(y1);
title('x[n] = cos(7.pi.n/4)');

subplot(3,3,8)
y1= cos(15*pi*x/8);
stem(y1);
title('x[n] = cos(15.pi.n/8)');

subplot(3,3,9)
y1= cos(2*pi*x);
stem(y1);
title('x[n] = cos(2.pi.n)');