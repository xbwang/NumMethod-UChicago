m = [5 10 20 40 80 160];
for i = 1:length(m)
    A = tril(ones(m(i),m(i))*-1,-1) + speye(m(i));
    A(:,m(i)) = 1;
    b = [1:m(i)]';
    r1 = A\b;
    r2 = pinv(A)*b;
    diff(i) = max(r1 - r2);
end

plot(m,diff);