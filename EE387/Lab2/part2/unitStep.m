function u = unitStep(n)

u = [];

for i = n
    if (i>=0)
        u = [u 1];
    else
        u = [u 0];
    end
end