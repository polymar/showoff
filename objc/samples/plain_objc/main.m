// First program example

#import <objc/objc.h>
#import <stdio.h>

@interface TTDevDayObject {
	
	Class isa;
	int counter;
}

+ initialize;
+ alloc;

- free;
- count;

@end

@implementation TTDevDayObject

+ initialize { 
	return self; 
}

+ alloc { 
	class_createInstance(self, 0); 
}

- free { 
	object_dispose(self);
}

- count { 
	printf("Hello world %d\n", counter++); 
}

@end

int main (int argc, const char * argv[])
{
	printf("Programming is fun!\n");
	
	TTDevDayObject* myObject = [TTDevDayObject alloc];
	
	[myObject count];
	[myObject count];
	[myObject count];
	
	[myObject free];
	
	return 0;
}