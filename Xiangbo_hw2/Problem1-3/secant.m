function [root,it] = secant(f,x0,x1,tol,maxit)
   x = -10:.1:10;
 %  axis([-10 10 -100 100]);
 %  hold on;

   for (it = 1:maxit)
       y = f(x1) + (f(x1) - f(x0))/(x1-x0)*(x-x1);
  %     plot(x,f(x),x,y);
       root = x1 - (x1 - x0)/(f(x1)-f(x0))*f(x1);
       x0 = x1;
       x1 = root;
       if (abs(x1 - x0) < tol)
           return;
       end
   end
end