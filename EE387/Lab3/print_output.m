function print_output(hs)

syms s t;
disp('H(s)');disp(hs);

for i = 1:3
    fprintf('************* i = %d **************\n',i);
    xt = sin(2*pi*108*i*t);
    xs = laplace(xt);
    ys = hs*xs;
    yt = ilaplace(ys);
    
    disp('X(t)');disp(xt);
    disp('X(s)');disp(xs);
    disp('Y(s)');disp(ys);
    disp('Y(t)');disp(yt);
    
end

disp('***************************************************');


