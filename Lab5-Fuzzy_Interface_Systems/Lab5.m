F = readfis('Gear_Selector');
X = [15 -12; 80 5; 45 0; 21 10; 75 -3;];

Y = evalfis(X, F);

disp("This is the output of the Fuzzy Interface System: ");
disp(Y);
