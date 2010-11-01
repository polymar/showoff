#import "Job.h"

@interface RunLoopQueue : JobQueue
{
	NSThread *runLoopThread;
	BOOL terminated;
}
@end