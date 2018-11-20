clear all;

figure('Name', 'x(n) = { 1,2,4 }, h(n) = {1,1,1,1,1}');
x1 = [1 2 4];
h1 = [1 1 1 1 1];
plot_fun(x1, h1);

figure('Name', 'x(n) = { 1,2,3,4,5 }, h(n) = {1}');
x2 = [1 2 3 4 5];
h2 = 1;
plot_fun(x2, h2);

figure('Name', 'x(n) = h(n) = { 1,2,0,2,1}');
x3 = [1 2 0 2 1];
plot_fun(x3, x3);