function newbalance = function_investor(b, p, n)

newbalance = [];

for i = 1:length(n)
    b = (b*1.01+p(i));
    newbalance = [newbalance b];
    
end




