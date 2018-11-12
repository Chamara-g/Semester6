function h = impulse(y)

h = []
for i = y
    if i<4 && i>=0
        h = [h (0.5^i)];
    else
        h = [h 0];
    end
end

disp(h);