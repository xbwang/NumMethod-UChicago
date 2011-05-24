%taking vector input
v = input('Please input your vector: ');
%making zbc smooth matrix
width = length(v);
zbc = zeros(width:width);
for i = 2 : width-1
    zbc(i,i-1:i+1) = 1;
end
disp('ZBC Smooth Matrix:');
disp(zbc);
%smoothing vector
r = v*zbc/3;
disp('Smoothed Vector:');
disp(r);
%determinant
disp('Determinant:');
disp(det(zbc));
%eigenvalues&eigenvectors
[evc,evl] = eig(zbc);
disp('Eigenvectors:');
disp(evc);
disp('Eigenvalues:');
disp(evl);
%condition number
disp('Condition Number:');
disp(cond(zbc));