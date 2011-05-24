%taking vector input
v = input('Please input your vector: ');
%making diff matrix
width = length(v);
diff = zeros(width:width);
for i = 1 : width-1
    diff(i,i) = 1;
    diff(i,i+1) = -1;
end
diff(width,width) = 1;
%diff matrix
disp('Diff Matrix:');
disp(diff);
%diffed vector
r = v*diff;
disp('Diffed Vector:');
disp(r);
%determinant
disp('Determinant:');
disp(det(diff));
%eigenvalues&eigenvectors
[evc,evl] = eig(diff);
disp('Eigenvectors:');
disp(evc);
disp('Eigenvalues:');
disp(evl);
%condition number
disp('Condition Number:');
disp(cond(diff));