#include <stdlib.h>
#include <stdio.h>

//matrix initialization
typedef struct
{
	int row;
	int col;
	double **data;
}Matrix;

Matrix newMatrix(int row_in, int col_in, int begin_value){
	Matrix newM;
	int i, j;
	double randNum;
	int test = begin_value; //test data
	
	newM.row = row_in;
	newM.col = col_in;
	newM.data = (double **)malloc(sizeof(double*)*row_in);
	for(i = 0; i < row_in; i++){
		newM.data[i] = (double *)malloc(sizeof(double)*col_in);
	}
	for(i = 0; i < row_in; i++){
		for(j = 0; j < col_in; j++){
			newM.data[i][j] = test; //test data
			test++; //test data
		}
	}
	return newM;
}
//gaussian elimination
void gEliminate(Matrix &m, Matrix &v, int opt)
{
	int i, j, k, max, a, b, c;
	double dvd, sub;
	double *temp;
	
	i = 0;
	j = 0;
	while(i < m.row && j < m.col){
		max = i;
		if(opt == 1){
			for(k = i+1; k < m.row; ++k){
				if(abs(m.data[k][j]) > abs(m.data[max][j])){
					max = k;
				}
			}
		}
		if(m.data[max][j] != 0){
			temp = m.data[max];
			m.data[max] = m.data[i];
			m.data[i] = temp;
			temp = v.data[max];
			v.data[max] = v.data[i];
			v.data[i] = temp;
			
			dvd = m.data[i][j];
			for(a = 0; a < m.col; ++a){
				m.data[i][a] /= dvd;
			}
			for(a = 0; a < v.col; ++a){
				v.data[i][a] /= dvd;
			}
			
			for(b = i+1; b < m.row; ++b){
				sub = m.data[b][j];
				for(c = (m.col-1); c >= 0; --c){
					m.data[b][c] -= sub*m.data[i][c];
				}
				for(c = (v.col-1); c >= 0; --c){
					v.data[b][c] -= sub*v.data[i][c];
				}
			}
			i += 1;
		}
		j += 1;
	}
}

int main()
{
	Matrix m, v;
	int opt = 0;
	int i,j;
	
	printf(">>Do you want to do it by partial pivoting?(type 1 for Yes, 0 for No): ");
	scanf("%d", &opt);
	
	m = newMatrix(3,3,1);
	v = newMatrix(3,1,10);
	
	printf("\n******Original Matrix******\n");
	for(i = 0; i < m.row; ++i){
		for(j = 0; j < m.col; ++j){
			printf("%f ", m.data[i][j]);
		}
		printf("\n");
	}
	printf("\n******Original Vector******\n");
	for(i = 0; i < v.row; ++i){
		for(j = 0; j < v.col; ++j){
			printf("%f ", v.data[i][j]);
		}
		printf("\n");
	}
	
	gEliminate(m, v, opt);
	
	printf("\n******Result Matrix******\n");
	for(i = 0; i < m.row; ++i){
		for(j = 0; j < m.col; ++j){
			printf("%f ", m.data[i][j]);
		}
		printf("\n");
	}
	printf("\n******Result Vector******\n");
	for(i = 0; i < v.row; ++i){
		for(j = 0; j < v.col; ++j){
			printf("%f ", v.data[i][j]);
		}
		printf("\n");
	}
	
	return 0;
}