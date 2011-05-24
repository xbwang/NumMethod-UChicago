function [rt,it] = mullers(f,x0,x1,x2,tol,max_it)
    
    for it = 1:max_it
        y0 = f(x0);
        y1 = f(x1);
        y2 = f(x2);
        
        d1 = (y1-y0)/(x1-x0);
        d2 = (y2-y1)/(x2-x1);
        d = (d2-d1)/(x2-x0);

        B = d2 + (x2-x1)*d;
        D = sqrt(B^.2 - 4*y2*d);
        if abs(B-D) > abs(B+D)
            E = B-D;
        else
            E = B+D;
        end
        H = -2*y2/E;
        rt=x2+H;
        x0 = x1;
        x1 = x2;
        x2 = rt;
        if abs(H) < tol
            return;
        end
    end
end
