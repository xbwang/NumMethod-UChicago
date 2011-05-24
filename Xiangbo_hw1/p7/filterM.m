fid = fopen('filterM.xls', 'w');
fprintf(fid, 'Size\tMatlab\n');
vWidth = input('Input the vector width: ');
fsWidth = input('Input the filter widthStart: ');
feWidth = input('Input the filter widthEnd: ');
vector = rand(1, vWidth)*100;
for i = fsWidth:feWidth
    time = cputime;
    filter(ones(1,i)/i,1,vector);
    time = cputime - time;
    fprintf(fid, '%d\t%d\n',i,time);
end