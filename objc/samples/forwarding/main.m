// runtime program example

#import <Foundation/Foundation.h>
#import "objc/runtime.h"
#import "TTDevDayObject.h"

void dumpAvailableMethods(id aClass);
int main (int argc, const char * argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSLog (@"Programming is fun!");
	
	TTDevDayObject* aObject = [[TTDevDayObject alloc] init];
	
	dumpAvailableMethods(aObject);
	
	// aObject does not have a method called company
	// let give it a try
	NSLog(@"Company name: %@", [aObject company]);
	
	[aObject release];
	
	[pool drain];
	return 0;
}

void dumpAvailableMethods(id aClass) {
	Class currentClass = object_getClass(aClass);
	unsigned int methodCount;
	Method *methods = class_copyMethodList(currentClass, &methodCount);
	NSLog(@"Methods available %d", methodCount);
	
	unsigned int i;
	for (i = 0; i < methodCount; i++)
	{
		SEL n = method_getName(methods[i]);
		NSString* mName = NSStringFromSelector(n);
		NSLog(@"%@", mName);
	}
	
	free(methods); //keep armony and peace
}

//@implementation RootObject
//
//+initialize;    { return self; }
//+alloc;         { return class_createInstance(self, 0); }
//-free;          { object_dispose(self); }
//-forward:(SEL)x :(void*)m
//{ printf("Method not found: %s\n", (char *)x); }
//@end
//
//int main()
//{
//	[[RootObject alloc] suca];
//	return 0;
//}