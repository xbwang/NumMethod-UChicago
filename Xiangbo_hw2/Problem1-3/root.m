exit = 0;
fid = fopen('result.xls','w');
fprintf(fid, 'method-name\ttolerance\tmax-iteration\t1st-guess\t2nd-guess\t3rd-guess\tresult\tno-of-iterations\tfunc.result\n'); 
%fucntions
%f=@(x) x.^2 - x - 1;    %near 0
%f=@(x) x.^3 + sin(x);   %near 1
f=@(x) exp(-x.^2/2) - 0.5;   %near -2
%f=@(x) cos(20*x - .1);  %near 0
while exit == 0
    method = input('- 1.bisection 2.secant 3.false positive 4.newton-raphson 5.muller 6.exit\n ');
    if method == 6
        exit = 1;
        return;
    end
    a = input('- 1st initial point: ');
    b = input('- 2nd initial point(no need for newton): ');
    c = input('- 3nd initial point(only for muller): ');
    tol = input('- tolerance: ');
    max_it = input ('- maximum iteration: ');
    switch method
        case 1
            [rt,it] = bisect(f,a,b,tol,max_it);
            r = f(rt);
            fprintf(fid, 'Bisection\t%f\t%d\t%f\t%f\t%f\t%f\t%d\t%f\n',tol,max_it,a,b,c,rt,it,r);
        case 2
            [rt,it] = secant(f,a,b,tol,max_it);
            r = f(rt);
            fprintf(fid, 'Secant\t%f\t%d\t%f\t%f\t%f\t%f\t%d\t%f\n',tol,max_it,a,b,c,rt,it,r);
        case 3
            [rt,it] = fpm(f,a,b,tol,max_it);
            r = f(rt);
            fprintf(fid, 'False-Positive\t%f\t%d\t%f\t%f\t%f\t%f\t%d\t%f\n',tol,max_it,a,b,c,rt,it,r);
        case 4
            [rt,it] = newton(f,a,tol,max_it);
            r = f(rt);
            fprintf(fid, 'Newton-Raphson\t%f\t%d\t%f\t%f\t%f\t%f\t%d\t%f\n',tol,max_it,a,b,c,rt,it,r);
        case 5
            [rt,it] = mullers(f,a,b,c,tol,max_it);
            r = f(rt);
            fprintf(fid, 'Mullers\t%f\t%d\t%f\t%f\t%f\t%f\t%d\t%f\n',tol,max_it,a,b,c,rt,it,r);
        otherwise
            disp('error: wrong input method number, please check');
    end
end