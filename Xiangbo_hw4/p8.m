pf = fopen('result_8.xls', 'w');
fprintf(pf, 'Method\tN\tIterations\tTime\n');
N_ = [10 20 40 80 160];
tol = 1e-10;
maxit = 2000;
for i = 1:5
    N = N_(i);
    [n, A, b] = FD_2D_operators(N);
    
    %method no Predic.
    tic;
    [x_1,flag_1,relres_1,iter_1] = pcg(A,b,tol,maxit);
    time_1 = toc;
    
    %method Jaboc
    D = inv(diag(diag(A)));
    tic;
    [x_2,flag_2,relres_2,iter_2] = pcg(A,b,tol,maxit,D);
    time_2 = toc;
    
    %method SSOR
    omega = 1.4;
    U = triu(A);
    L = A-U-D;
    P1 = (1/(2-omega))*((1/omega)*D+L);
    P2 = inv(((1/omega)*D))*((1/omega)*D+U);
    tic;
    [x_3,flag_3,relres_3,iter_3] = pcg(A,b,tol,maxit,P1,P2);
    time_3 = toc;

    fprintf(pf, 'No Predic.\t%d\t%d\t%d\n', N, iter_1, time_1);
    fprintf(pf, 'Jaboc\t%d\t%d\t%d\n', N, iter_2, time_2);
    fprintf(pf, 'SSOR\t%d\t%d\t%d\n', N, iter_3, time_3);
end
fclose(pf);