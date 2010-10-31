// runtime program example
// invokation forwarding example
#import <Foundation/Foundation.h>
#import "objc/runtime.h"

@interface TTDevDayObject : NSObject {
	
	int counter;
	NSDictionary* aDictionary;
}

- (void) count;

@end

@implementation TTDevDayObject

- (id) init {
	if (self = [super init]) {
		NSArray* objects = [NSArray arrayWithObjects:@"TomTom",@"Roberto Gamboni",nil];
		NSArray* keys = [NSArray arrayWithObjects:@"company", @"employee", nil];
		aDictionary = [NSDictionary dictionaryWithObjects:objects
												  forKeys:keys];
	}
	return self;
}

- (void) count {
	printf("Hello world %d\n", counter++);
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
	NSString* a = NSStringFromSelector([anInvocation selector]);
	[anInvocation setArgument: &a atIndex: 2];
	[anInvocation setSelector: NSSelectorFromString(@"objectForKey:")];
	return [anInvocation invokeWithTarget:aDictionary];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	NSString* method = NSStringFromSelector(aSelector);
	if([aDictionary objectForKey:method] != nil) 
		return [[aDictionary class] instanceMethodSignatureForSelector:NSSelectorFromString(@"objectForKey:") ];
	return [super methodSignatureForSelector:aSelector];
}

@end

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