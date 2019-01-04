function fun_b(eq)

k = -20:20;
T = 5;
n = k*T;
t = linspace(-20*5,20*5,1000);

figure;
hold on;

xnval = subs(eq, n);
xtval = subs(eq, t);

stem(n, xnval);
plot(t, xtval);

hold off;