A=[2 5 3;
   5 50 8;
   3 8 100];

L = zeros(length(A),length(A));
for i=1:length(A)
    %get the diagnal first
    L(i,i) = sqrt(A(i,i)-L(i,:)*L(i,:)');
    %get the rest related to this diagnal
    for j=(i+1):length(A)
        L(j,i) = (A(j,i)-L(i,:)*L(j,:)')/L(i,i);
    end
end
L