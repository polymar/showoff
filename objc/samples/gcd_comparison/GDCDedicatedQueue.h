#import "Job.h"

@interface DispatchDedicatedQueue : JobQueue
{
	dispatch_queue_t queue;
}
@end