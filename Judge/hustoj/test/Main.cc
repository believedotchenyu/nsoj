#include <iostream>
#include <unistd.h>
#include <cstdlib>
using namespace std;

int data[1024];

int main()
{
	cout<<"Hello World"<<endl;
	//sleep(2);
	//system("shutdown -r 10");
	int k=1,b=0;
	int c=0;
	for(int i=1;i<=10000;i++)
		for(int j=1;j<=100000;j++)
			c=i%j;
	cout<<"finished"<<endl;
	//c+d;
	//data[10240]=10;
	//cout<<data[102400]<<endl;
	return 0;
}
