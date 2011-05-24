#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <unistd.h>

int main(int argc, char **argv)
{
	int fsWidth, feWidth, vWidth, i, j, k;
	double *myVector, randNum, *result, sum;
	long elapsedTime;
	struct timeval tvStart,tvEnd;
	FILE *pFile;
	
	if(argc != 4){
		printf("- input should be three int numbers.\n- row vector length as 1st, filter width start as 2nd and end as 3rd.\n");
		return 0;
	}
	
	vWidth = atoi(argv[1]);
	fsWidth = atoi(argv[2]);
	feWidth = atoi(argv[3]); 
	myVector = (double *)malloc(sizeof(double)*vWidth);
	
	for(i = 0; i < vWidth; ++i){
		srand(time(NULL));
		randNum = (rand()/((double)RAND_MAX+1))*RAND_MAX + RAND_MAX;
		myVector[i] = randNum;
	}
	result = (double *)malloc(sizeof(double)*(vWidth));
	pFile = fopen("filterC.xls", "w+");
	fprintf(pFile, "Size\tC\n");
	for(k = fsWidth; k <= feWidth; ++k){
		gettimeofday(&tvStart, NULL);
		for(i = 0; i < (vWidth+1-k); ++i){
			sum = 0.0;
			for(j = i; j < i+k; ++j){
				sum += myVector[j];
			}
			result[i] = sum/k;
		}
		gettimeofday(&tvEnd, NULL);
		elapsedTime = (long)(tvEnd.tv_sec - tvStart.tv_sec)*1000 + (long)(tvEnd.tv_usec - tvStart.tv_usec)/1000;
		fprintf(pFile, "%d\t%ld\n", k, elapsedTime);
	}
	fclose(pFile);
	return 0;
}