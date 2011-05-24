p = [2 3 4 5 10 20 50];
X = 1;
Y = 1;
M = [];
for a = 1:length(p)
    for x = -2:0.005:2
        X = 1;
        for y = -1:0.005:1
            z = 0 + 0*1i;
            c = x + y*1i;
            for i = 1:256
                z = z^p(a) + c;
            end
            if real(z)^2 + imag(z)^2 < 4
                M(X,Y) = 1;
            else
                M(X,Y) = 0;
            end
            X = X + 1;
        end
        Y = Y + 1;
    end
spy(M);
end