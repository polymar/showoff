#import "Job.h"

@interface DispatchGlobalConcurrentQueue : JobQueue
{
	dispatch_queue_t queue;
}
@end