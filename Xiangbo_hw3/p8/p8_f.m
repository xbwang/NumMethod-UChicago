A = [4 1 0 0 0;1 4 1 0 0;0 1 4 1 0;0 0 1 4 1;0 0 0 1 4];

for it = 1 : 500
    [Q,R] = qr(A);
    A = R*Q;
end
A