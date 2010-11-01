//
#import "GDCGlobalQueue.h"
#import "Job.h"

@implementation DispatchGlobalConcurrentQueue

- (id)init
{
	self = [super init];
	if (self != nil)
	{
		queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
		dispatch_retain(queue);
	}
	return self;
}

- (void)dealloc
{
	dispatch_release(queue);
	[super dealloc];
}

- (void)queueJob:(Job *)aJob
{
	dispatch_async(queue, ^{
		[aJob performIterationAndRequeueInJobQueue:self];
	});
}

@end