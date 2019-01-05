close all;
syms s;

%1
hs = (s+5)/(s^2+2*s+3);
print_output(hs);

%2
hs = (2*s^2+5*s+12)/(s^2+2*s+10);
print_output(hs);

%3
hs = (2*s^2+5*s+12)/(s^3+4*s^2+14*s+20);
print_output(hs);

hs = (2*s^2+2*s+17)/(s^2+4*s+104);
print_output(hs);