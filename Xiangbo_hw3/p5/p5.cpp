#include <cmath>
#include <iostream>
#include <ctime>
#include <iomanip>
using namespace std;

//matrix initialization
class Matrix
{
public:
    Matrix(int row_in, int col_in){
        row = row_in;
        col = col_in;
        srand(time(NULL));
        data = new double*[row];
        for(int i = 0; i < col; i++){
            data[i] = new double[col];
        }
    
        for(int i = 0; i < row; i++){
            for(int j = 0; j < col; j++){
                if(j == i-2)
                    data[i][j] = rand()%99 + 1;
                else if(j == i-1)
                    data[i][j] = rand()%99 + 1;
                else if(j == i)
                    data[i][j] = rand()%99 + 1;
                else if(j == i+1)
                    data[i][j] = rand()%99 + 1;
                else if(j == i+2)
                    data[i][j] = rand()%99 + 1;
                else
                    data[i][j] = 0;
            }
        }
    }
    
    inline void print(){
        for(int i = 0; i < row; i++){
            for(int j = 0; j < col; j++){
                cout.setf(ios::fixed);
                cout.precision(2);
                cout << data[i][j] << " ";
            }
            cout << endl;
        }
    }
    int row;
    int col;
    double** data;
};

class Vector
{
public:
    Vector(int col_in){
        col = col_in;
        srand(time(NULL));
        data = new double[col];
        for(int i = 0; i < col; i++){
            data[i] = rand()%99 + 1;
        }
    }
    
    inline void print(){
        for(int i = 0; i < col; i++){
            cout.setf(ios::fixed);
            cout.precision(2);
            cout << data[i] << " ";
        }
        cout << endl;
    }
    int col;
    double* data;
};

//gaussian elimination
void gEliminate(Matrix *m, Vector *v, int &op_in, int &men_in)
{
    int i = 0;
    int j = 0;
    while(i < m->row && j < m->col){
        int max = i;
        for(int k = i+1; k <= ((i+2) < (m->row-1) ? (i+2) : (m->row-1)); ++k){
            if(abs(m->data[k][j]) > abs(m->data[max][j])){
                max = k;
                op_in++; 
            }
        }
        
        if(m->data[max][j] != 0){
            double *temp1 = m->data[max];
            m->data[max] = m->data[i];
            m->data[i] = temp1;
            men_in += m->col;
            
            double temp2 = v->data[max];
            v->data[max] = v->data[i];
            v->data[i] = temp2;
            men_in++;
            
            double dvd = m->data[i][j];
            v->data[i] /= dvd;
            op_in++;
            for(int k = j; k <= ((j+2) < (m->col-1) ? (j+2) : (m->col-1)); k++){
                m->data[i][k] /= dvd;
                op_in++;
            }
            
            for(int k = i+1; k <= ((i+2) < (m->row-1) ? (i+2) : (m->row-1)); k++){
                double sub = m->data[k][j];
                v->data[k] -= sub*v->data[i];
                op_in++;
                for(int n = ((j+4) < (m->col-1) ? (j+4) : (m->col-1)); n >=j; n--){
                    m->data[k][n] -= sub*m->data[i][n];
                    op_in++;
                }
            }
        }
        i++;
        j++;
    }
}

double* calResult(Matrix *m, Vector *b, int &op_in, int &men_in)
{
    double *res = new double[b->col];
    men_in += b->col;
    int num = b->col-1;
    for(int i = num; i >=0; i--){
        res[i] = b->data[i];
        for(int j = i+1; j <= num; j++){
            if(m->data[i][j] != 0){
                res[i] -= m->data[i][j]*b->data[j];
                op_in++;
            }
        }
    }
    return res;
}

int main()
{
    int mem = 0;//for memory count
    int op = 0;//for operation count
    int size = 9;
    
    Matrix *m = new Matrix(size,size);
    mem += size*size;//memory count
    cout << "[Original Matrix]" << endl;
    m->print();
    
    Vector *v = new Vector(size);
    mem += size;//memory count
    cout << endl << "[Original Vector]" << endl;
    v->print();
    
    gEliminate(m, v, op, mem); //operations&mem count
    
    cout << endl << "[gElied Matrix]" << endl;
    m->print();
    cout << endl << "[gElied Vector]" << endl;
    v->print();
    
    double *result = new double[size];
    result = calResult(m,v,op,mem);//operations&mem count
    cout << endl << "[Result Vector]" << endl;
    for(int i = 0; i < size; i++){
        cout << result[i] << " ";
    }
    cout << endl;
    cout << endl << "[Total Floating Point Operations]" << endl;
    cout << op << endl;
    cout << endl << "[Total Memory Used]" << endl;
    cout << mem << endl;
    
    
    return 0;
}