// First program example

#import <Foundation/Foundation.h>
#import "TTDevDayObject.h"

int main (int argc, const char * argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSLog (@"Programming is fun!");
	
	TTDevDayObject* myObject = [TTDevDayObject alloc];
	
	[myObject count];
	[myObject count];
	[myObject count];
	
	[myObject free];
	
	[pool drain];
	return 0;
}