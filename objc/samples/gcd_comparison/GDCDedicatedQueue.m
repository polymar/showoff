//
#import "GDCDedicatedQueue.h"
#import "Job.h"

@implementation DispatchDedicatedQueue

- (id)init
{
	self = [super init];
	if (self != nil)
	{
		NSString *nameFromSelf = [NSString stringWithFormat:@"queue%p", self];
		queue = dispatch_queue_create([nameFromSelf UTF8String], NULL);
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
