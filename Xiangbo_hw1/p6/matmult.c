#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>

typedef struct{
	int row;
	int col;
	double** data;
}Matrix;

Matrix NewMatrix(int row_in, int col_in){
	Matrix newM;
	int i, j;
	double randNum;
	
	newM.row = row_in;
	newM.col = col_in;
	newM.data = (double **)malloc(sizeof(double*)*row_in);
	for(i = 0; i < row_in; i++){
		newM.data[i] = (double *)malloc(sizeof(double)*col_in);
	}
	for(i = 0; i < row_in; i++){
		for(j = 0; j < col_in; j++){
			srand(time(NULL));
			randNum = (rand()/((double)RAND_MAX+1))*RAND_MAX + RAND_MAX;
			newM.data[i][j] = randNum;
		}
	}
	return newM;	
}

int main(){
	int i, j;
	int p, q, k;
	int size;
	Matrix m, n, r;
	FILE *pFile;
	struct timeval tvStart,tvEnd;
	long elapsedTime;
	
	pFile = fopen("resultC.xls", "w+");
	fprintf(pFile, "Size\tTime\n");
	for(i = 100; i <= 110; i++){
		for(j = 100; j <=110; j++){
			m = NewMatrix(i, j);
			n = NewMatrix(j, i);
			r = NewMatrix(i, i);
			gettimeofday(&tvStart, NULL);
			for(p = 0;p < i;p++){
				for(q = 0;q < i; q++){
					for(k = 0; k < j; k++){
						r.data[p][q] += (m.data[p][k]*n.data[k][q]);
					}
				}
			}
			gettimeofday(&tvEnd, NULL);
			elapsedTime = (long)(tvEnd.tv_sec - tvStart.tv_sec)*1000 + (long)(tvEnd.tv_usec - tvStart.tv_usec)/1000;
			
			size = i*j;
			fprintf(pFile, "%d\t%ld\n", size, elapsedTime);
			free(m.data);
			free(n.data);
			free(r.data);
		}
	}
	fclose(pFile);
}
