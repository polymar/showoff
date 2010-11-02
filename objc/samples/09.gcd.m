// grand central dispatch basics

#include <Foundation/Foundation.h>
#include <dispatch/dispatch.h>

int main (int argc, const char * argv[]) {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	NSDate* start = [NSDate date];
	NSMutableSet *items = [NSMutableArray array];
	
	dispatch_semaphore_t itemLock = dispatch_semaphore_create(1);
	dispatch_queue_t queue =
	dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_apply(50, queue,
				   ^(size_t index) {
					   int i;
					   for (i = 0; i < 500; i++) {
						   dispatch_semaphore_wait(itemLock, DISPATCH_TIME_FOREVER);
						   [items addObject:@"hi"];
						   dispatch_semaphore_signal(itemLock);
					   }
				   });
	dispatch_release(itemLock);
	
	NSLog(@"%i", [items count]);
	NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:start];
	NSLog(@"elapsed time: %f", elapsedTime);
	
	[pool drain];
	return 0;
}