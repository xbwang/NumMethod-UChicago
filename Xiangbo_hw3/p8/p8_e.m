v = [1 ; 1; 1; 1; 1];
A = [4 1 0 0 0;1 4 1 0 0;0 1 4 1 0;0 0 1 4 1;0 0 0 1 4];

v = v/norm(v);
v = A*v / norm(A*v);
lambda = v' * (A*v);
if lambda < 0.0
    v = -v;
end

for it_num = 1 : 500
    lambda_old = lambda;
    v = A*v / norm(A*v);
    lambda = v' * (A*v);
    if lambda < 0.0
        v = -v;
    end
    
    diff = abs(lambda - lambda_old);
    if diff < 0.001
        break;
    end
end
lambda
    