%1
figure;
b1 = [1 5]; % Numerator coefficients
a1 = [1 2 3]; % Demoninator coefficients
zs1 = roots(b1); % Generetes Zeros
ps1 = roots(a1); % Generetes poles
pzmap(ps1,zs1); % generates pole-zero diagram

%2
figure;
b2 = [2 5 12]; % Numerator coefficients
a2 = [1 2 10]; % Demoninator coefficients
zs2 = roots(b2); % Generetes Zeros
ps2 = roots(a2); % Generetes poles
pzmap(ps1,zs2); % generates pole-zero diagram

%3
figure;
b3 = [2 5 12]; % Numerator coefficients
a3 = [1 4 14 20]; % Demoninator coefficients
zs3 = roots(b3); % Generetes Zeros
ps3 = roots(a3); % Generetes poles
pzmap(ps3,zs3); % generates pole-zero diagram
