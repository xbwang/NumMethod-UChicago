%SSOR
pf = fopen('result_7s.xls', 'w');
fprintf(pf, 'N\tspectral radius\tIterations\n');
N_ = [10 20 40 80 160];
maxit = 50000; %maximum iteration
tol = 1e-10; %tolerance
for i = 1:5
    N = N_(i);
    [n, A, b] = FD_2D_operators(N);
    x = zeros(n,1); 
    
    %split matrix A into D L U
    D = diag(diag(A));
    L = tril(-A,-1);
    U = L';
    
    J = inv(D)*(L+U); %Jacobi iteration matrix			
    r = max(abs(eig(J))); %spectrual radius
    omega = 2./(1+sqrt(1-r^2));	
    S = inv(D-omega*L)*((1-omega)*D+omega*U); %SSOR iteration
    c = omega*inv(D-omega*L)*b;			

    for iter = 1:maxit
        x(:,iter+1) = S*x(:,iter) + c;
        if norm(x(:,iter+1)-x(:,iter)) < tol
            break
        end
    end
    fprintf(pf, '%d\t%d\t%d\n', N, r, iter);
end;
fclose(pf);