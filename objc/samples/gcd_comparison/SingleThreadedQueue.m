//
#import "SingleThreadedQueue.h"
#import "Job.h"

@implementation SingleThreadedQueue

- (void)queueJob:(Job *)aJob
{
	if (!jobQueue)
	{
		jobQueue = [[NSMutableArray alloc] init];
		[jobQueue addObject:aJob];
		
		while ([jobQueue count] > 0)
		{
			Job *nextJob = [jobQueue objectAtIndex:0];
			[jobQueue removeObjectAtIndex:0]; 
			[nextJob performIterationAndRequeueInJobQueue:self];
		}
		
		[jobQueue release];
		jobQueue = nil;
	}
	else
	{
		[jobQueue addObject:aJob];
	}
}

@end