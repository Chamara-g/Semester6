function y = myconv(x,h)

a = length(x);
b = length(h);
n = a+b-1;  
y = zeros(1,n);

for i = 0:n
    for j = 0:n
        if((i-j+1)>0 && (i-j+1)<=b && (j+1)<=a)
             y(i+1) = y(i+1)+ x(j+1).*h(i-j+1);
        end
    end
end