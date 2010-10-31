// Foundation program example

#import <Foundation/Foundation.h>

@interface TTDevDayObject : NSObject {
	int counter;
}

- (void) count;

@end

@implementation TTDevDayObject
- (void) count {
	printf("Hello world %d\n", counter++);
}
@end

int main (int argc, const char * argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSLog (@"Programming is fun!");
	
	TTDevDayObject* myObject = [[TTDevDayObject alloc] init];
	
	[myObject count];
	[myObject count];
	[myObject count];
	
	[myObject release];
	
	[pool drain];
	return 0;
}