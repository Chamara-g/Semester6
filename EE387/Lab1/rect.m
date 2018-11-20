function x = rect(t)

x = [];

for i = t
    if( i < 0.5 && i >= -0.5)
        x = [x 1];
    else
        x = [x 0];
    end
end

