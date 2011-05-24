fidM = fopen('resultMat.xls','w');
fprintf(fidM, 'Size\tTime\n');
for i = 100:110
    for j = 100:110
        a = rand(i,j)*100;
        b = rand(j,i)*100;
    tic;
    result = a*b;
    mtime = toc;
    fprintf(fidM, '%d\t%d\n', i*j, mtime);
    end
end
fclose(fidM);

fidL = fopen('resultLoop.xls','w');
fprintf(fidL, 'Size\tTime\n');
for i = 100:110
    for j = 100:110
        a = rand(i,j)*100;
        b = rand(j,i)*100;
        c = [];
        c = zeros(i);
        tic;
        for p = 1:i
            for q = 1:i
                for k = 1:j
                    c(p,q) = c(p,q) + a(p,k)*b(k,q);
                end
            end
        end
        ltime = toc;
        fprintf(fidL, '%d\t%d\n', i*j, ltime);
    end
end
fclose(fidL);