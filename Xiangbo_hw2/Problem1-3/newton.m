function [root,it] = newton(f,x0,tol,max_iter)
delta = 1e-10;
for it=1:max_iter
    y0 = f(x0);
    y1 = f(x0+delta);
    dx = y0*delta/(y1-y0);
    root = x0 - dx;
    x0 = root;
    if(abs(dx) < tol)
        return;
    end
end