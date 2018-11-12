function y = ramp(t, m, ad)

%t: length of time
%m: slope of the ramp
%ad: advance (positive), delay (negative) factor

y = [];

for i = t
    i = i + ad;
    if i<0
        y = [y 0];
    else
        i = m*i;
        y = [y i];
    end
end