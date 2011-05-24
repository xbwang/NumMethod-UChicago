%taking vector input
v = input('Please input your vector: ');
%making pbc smooth matrix
width = length(v);
pbc = zeros(width:width);
pbc(1,1:2) = 1;
for i = 2 : width-1
    pbc(i,i-1:i+1) = 1;
end
pbc(width,width-1:width) = 1;
disp('PBC Smooth Matrix:');
disp(pbc);
%smoothing vector
r = v*pbc/3;
disp('Smoothed Vector:');
disp(r);
%determinant
disp('Determinant:');
disp(det(pbc));
%eigenvalues&eigenvector
[evc,evl] = eig(pbc);
disp('Eigenvectors:');
disp(evc);
%eigenvectors
disp('Eigenvalues:');
disp(evl);
%condition number
disp('Condition Number:');
disp(cond(pbc));