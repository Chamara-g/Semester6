function y = ustep(t, ad)

%t: length of time
%ad: advance (positive), delay (negative) factor

y = [];

for i = t
    i = i + ad;
    if i<0
        y = [y 0];
    else
        y = [y 1];
    end
end
