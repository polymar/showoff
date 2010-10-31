// First program example

#import <Foundation/Foundation.h>
#import "TTDevDayObject.h"

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