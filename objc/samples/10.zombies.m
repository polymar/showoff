#import <Foundation/Foundation.h>

@interface ParkingLot : NSObject
{
	NSMutableArray* slots;
}

- (void)fillSlot:(int) index;
- (void)badStuff;

@end

@implementation ParkingLot

- (id) init {
	if(self = [super init]) {
		slots = [[NSMutableArray alloc] initWithCapacity:10];
	}
	return self;
}
- (void)fillSlot:(int) index {
	[slots addObject:[NSNumber numberWithInt:index]];
	printf("I filled %d spots!\n", (int)slots.count);
}
- (void)badStuff {
	[slots release];
}

@end

int main (int argc, const char * argv[]) {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	printf("Hello world.\n");
	
	ParkingLot* parking = [[ParkingLot alloc] init];
	[parking fillSlot:4];
	[parking fillSlot:1];
	[parking fillSlot:2];
	
	[parking badStuff]; //here goes the release :D
	
	[parking fillSlot:7];
	[parking fillSlot:9];
	
	[pool drain];
	return 0;
}

