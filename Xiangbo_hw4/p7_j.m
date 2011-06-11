%Jacobi Method
pf = fopen('result_7j.xls', 'w');
fprintf(pf, 'N\tspectral radius\tIterations\n');
N_ = [10 20 40 80 160];
maxit = 50000; %maximum iteration
tol = 1e-10; %tolerance
for i = 1:5
    N = N_(i);
    [n, A, b] = FD_2D_operators(N);
    x = zeros(n,1); 
    x0 = zeros(n,1); %initial guess

    D = diag(diag(A));
    J = D - A;
    r = max(abs(eig(J))); %spectral radius
    
    relerr = inf; %error
    iter = 1;
    while relerr >= tol & iter < maxit,
        x=D \ (b+J*x0);
        relerr = norm( x-x0,inf )/norm( x,inf );
        x0 = x;
        iter = iter+1;
    end
    fprintf(pf, '%d\t%d\t%d\n', N, r, iter);
end
fclose(pf);