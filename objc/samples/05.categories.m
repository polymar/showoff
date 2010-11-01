// invokation forwarding example
#import <Foundation/Foundation.h>

@interface NSMutableArray (ArrayUtilities)

//in-place reverse
- (void) reverse;
@end

@implementation NSMutableArray (ArrayUtilities)

- (void) reverse {
	int i;
	for (i=0; i<(floor([self count]/2.0)); i++)
		[self exchangeObjectAtIndex:i withObjectAtIndex:([self count]-(i+1))];
}
@end

int main (int argc, const char * argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	NSMutableArray* anArray = [NSMutableArray arrayWithObjects:@"one",@"two",@"three",nil];
	NSLog(@"this is the array: %@", anArray);
	[anArray reverse];
	NSLog(@"this is the reversed array: %@", anArray);
	
	[pool drain];
	return 0;
}
