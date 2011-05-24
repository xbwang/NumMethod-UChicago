%uses bisection method to find root of function f
%with bracketing interval (x1,x2), convergence criterion
%tol.
function [rt,it] = bisect(f,x1,x2,tol,max_iter)
    if (f(x1)*f(x2) > 0.0)
        disp('error: inputs must bracket root');
        return;
    end
       
    for it=1:max_iter
        %i
        
        dx = x2 - x1;
        rt = x1 + 0.5*dx;

        fr = f(rt);

        if (fr < 0)
            x1 = rt;
            x2 = x2;
        else
            x2 = rt;
            x1 = x1;
        end

        if (abs(dx) < tol || fr == 0.0)
            return;
        end
    end
end