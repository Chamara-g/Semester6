f_s = 100;
T_s = 1/f_s;
t = [-5:T_s:5];

% Usage: x = rect(t)
%
% This function takes in a vector t of sample instants and outputs the
% corresponding rectangular pulse contained in the function x

x1 = rect(t);
plot(t,x1);axis( [-2 2 -1 2]);

xlabel( 'time (sec)' ) ;
ylabel( 'x_1(t)' ) ;
title ('Plot 1: A rectangular pulse');