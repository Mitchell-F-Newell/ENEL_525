Ilr = 0.05;
iter = 1;
MSE(1) = 1;
k = 1;
err = zeros(1,168);

while MSE(iter) >= et
    a1 = logsig( W1 * [p(k+1) p(k)]' + b1);
    a2 = W2 * a1 + b2;
    f1Initial = [ a1(1) * (1 - a1(1)) a1(2) * (1 - a1(2)) a1(3) * (1 - a1(3)) a1(4) * (1 - a1(4)) a1(5) * (1 - a1(5))];  
    f1 = diag(f1Initial);
    f2 = 1;
    
    err(k) = p(k + 2) - a2;
    s2 = -2 * f2 * err(k);
    s1 = f1  * W2' * s2;
    
    W2 = W2 - lr * s2 * a1';
    b2 = b2 - lr * s2;
    W1 = W1 - lr *s1 * [p(k + 1) p(k)];
    b1 = b1 - lr * s1;
    
    k = k+1;
    if (k > 168)
            k = 1;
            iter = iter + 1;
            MSE(iter) = mse(err);
    end
end
figure;
semilogy(MSE);

predictions = [];
x = 1;
k = 169;
while (x <= 10)
    a1 = logsig( W1 * [p(k+1) p(k)]' + b1);
    predictions(x) = W2 * a1 + b2;
    x = x + 1;
    k = k + 1;
end
figure;
plot(predictions);
hold on;
plot(p(171:180));

