function [root,it] = fpm(f,x0,x1,tol,max_iter)
     if (f(x0)*f(x1) > 0.0)
       disp('error: inputs must bracket root');
       return;
     end
     x = -10:.1:10;
 %    axis([-10 10 -100 100]);
 %    hold on;

     for (it = 1:max_iter)
       y = f(x1) + (f(x1) - f(x0))/(x1-x0)*(x-x1);
 %      plot(x,f(x),x,y);
%      pause;
       root = x1 - (x1 - x0)/(f(x1)-f(x0))*f(x1);
       if (f(root) < 0.0)
         x0 = root;
         x1 = x1;
       else 
         x0 = x0;
         x1 = root;
       end

       if (abs(x1 - x0) < tol)
         return;
       end
     end
end
