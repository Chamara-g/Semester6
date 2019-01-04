function x = fun_x(n)

u = unitStep(n);

x = zeros(1,length(n));

for i = 1:length(n)
    x(i) = (0.5^n(i))*u(i);
end