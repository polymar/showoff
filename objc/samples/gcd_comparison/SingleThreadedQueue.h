#import "Job.h"

@interface SingleThreadedQueue : JobQueue
{
	NSMutableArray *jobQueue;
}
@end