#include <iostream>
#include <vector>
#include <string>
using namespace std;

vector<string> toBinary(int intNum)
{
	vector<string> result;
	string byte = "";
	int mask = 1 << 31;
	
	for(int i = 1; i <=32; ++i){
		byte.append(((intNum & mask) == 0) ? "0" : "1");
		intNum <<= 1;
		if(i%8 == 0){
			result.push_back(byte);
			byte = "";
		}
	}
	
	return result;
}

int main()
{
	int intNum;
	cout << "Please input the int number:\t";
	cin >> intNum;
	cout << "Little-endian bit pattern:\t";
	vector<string>result = toBinary(intNum);
	while(!result.empty()){
		cout << result.back() << " ";
		result.pop_back();
	}
	cout << endl;
	
	return 0;
}