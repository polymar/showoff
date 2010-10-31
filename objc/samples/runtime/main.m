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
	
	NSLog(@"Dumping Available Methods:");
	// get list of methods
	dumpAvailableMethods(aObject);
	
	[aObject count];
	[aObject count];
	
	NSLog(@"Adding reset method to TTDevDayObject instance");
	// add a method to object
	[aObject implementSEL:@selector(reset)];
	
	NSLog(@"Dumping Available Methods:");
	// get list of methods
	dumpAvailableMethods(aObject);
	
	NSLog(@"Invoking dynamically created method");
	// call new method
	[aObject performSelector:@selector(reset)];
	
	[aObject count];
	[aObject count];
	
	[aObject release];
	
//	NSLog(@"------ Inspecting NSString ------ ");
//	dumpAvailableMethods([NSString class]);
//	NSLog(@"----------------------------------");
	
//	NSLog(@"------ Inspecting NSDictionary ------ ");
//	dumpAvailableMethods([NSDictionary class]);
//	NSLog(@"----------------------------------");
	
//	NSLog(@"------ Inspecting NSDictionary instance ------ ");
//	dumpAvailableMethods([NSDictionary dictionary]);
//	NSLog(@"-----------------------------------------------");

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