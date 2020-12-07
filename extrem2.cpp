#include <math.h>
#include <iostream>
#include <vector>
#define N 1000.00000
#define PI 3.141592


int sign(double num){
	
	return -1*(num<0)+1*(num>0)+0*(num==0); 
	// Verilen num datasinin isaretini goster
}



int main(){
	
	double signal[int(N)];
	double init_time=-2*PI, last_time=16*PI;
	double i_time= (last_time-init_time)/(N-1);
	double i_sgn=-2/(N-1);
	double temp_time=init_time;
	std::vector <double> peak_times;
	double db_diff,diff[int(N-2)]; 
	//diff elemeaninin boyutu kucultulerek daha az yer kaplamasi saglanabilir.
	int i=0;
	
	for(temp_time;temp_time<=last_time;temp_time+=i_time){
		
		signal[int(i)]=sin(temp_time)/temp_time+1+i_sgn*i;
		
	    *(diff+(i-1)*(i>=1))=signal[i]-signal[(i-1)*(i>=1)];
		 // diff arrayinde signal arrayinin bir oncekinden farki bulunacaktir.
		 
	    db_diff=(sign(diff[(i-1)*(i>=1)])-sign(diff[(i-2)*(i>=2)]))*(i>=2); 
		// diff arrayini kullanarak i icin 2. turev bilgisini elde et.
	    
	    if(db_diff<0){ 
		//2. turev bilgisinden yerel maksimum bulma islemi
		
	    peak_times.push_back(init_time+(i-1)*i_time);
	    std::cout<<init_time+(i-1)*i_time<<" ";
	}
		i++;
	}
	
	return 0;
}

