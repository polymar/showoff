//  Copyright 2010 Matt Gallagher. All rights reserved.
//  Cocoa With Love 

#import <Foundation/Foundation.h>
#import "Job.h"
#import "SingleThreadedQueue.h"
#import "RunLoopQueue.h"
#import "GDCDedicatedQueue.h"
#import "GDCGlobalQueue.h"
#include <mach/mach_time.h>

double MachTimeDifferenceInSeconds(uint64_t start, uint64_t end)
{
    uint64_t delta = end - start;
	mach_timebase_info_data_t timebaseInfo;
	kern_return_t err = mach_timebase_info(&timebaseInfo);
	
	if(!err)
	{
		return delta * 1.0e-9 * timebaseInfo.numer / (double)timebaseInfo.denom;
    }
    
    return NAN;
}

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	NSArray *jobQueueClasses =
		[[NSArray alloc] initWithObjects:
			[SingleThreadedQueue class],
			[RunLoopQueue class],
			[DispatchDedicatedQueue class],
			[DispatchGlobalConcurrentQueue class],
		nil];
	
	const NSInteger NumJobIterations = 6250;
	const NSInteger NumQueues = 16;
	
	for (Class jobQueueClass in jobQueueClasses)
	{
		NSMutableArray *jobQueues = [[NSMutableArray alloc] initWithCapacity:NumQueues];
		NSMutableArray *jobs = [[NSMutableArray alloc] initWithCapacity:NumQueues];
		NSInteger i;
		for (i = 0; i < NumQueues; i++)
		{
			JobQueue *jobQueue = [[jobQueueClass alloc] init];
			Job *job = [[Job alloc] initWithIterations:NumJobIterations];
			[jobQueues addObject:jobQueue];
			[jobs addObject:job];
			[job release];
			[jobQueue release];
		}
		
		NSLog(@"Running %ld iterations in %ld queues using %@",
			NumJobIterations, NumQueues, NSStringFromClass(jobQueueClass));
		
		uint64_t start = mach_absolute_time();
		
		for (i = 0; i < NumQueues; i++)
		{
			JobQueue *jobQueue = [jobQueues objectAtIndex:i];
			Job *job = [jobs objectAtIndex:i];
			[jobQueue queueJob:job];
		}
		for (Job *job in jobs)
		{
			[job blockUntilFinished];
		}

		uint64_t end = mach_absolute_time();
		double elapsed = MachTimeDifferenceInSeconds(start, end);
		NSLog(@"Finished is %f seconds", elapsed);

		[jobs release];
		[jobQueues release];
	}
	
    [pool drain];
    return 0;
}
