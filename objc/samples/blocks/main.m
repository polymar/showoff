// blocks basics

#include <Foundation/Foundation.h>
#include <stdlib.h>
#include <stdio.h>
#include <Block.h>

int main (int argc, const char * argv[]) {

	
	typedef int(^Blocky)(void);
    Blocky b[3];
	
	int i;
    for (i=0; i<3; i++)
        b[i] = ^{ return i;};
	
	//for (i=0; i<3; i++)
//        b[i] = [^{ return i;} copy];
	
    for (i=0; i<3; i++)
        printf("b %d\n", b[i]());
	
	return 0;
}