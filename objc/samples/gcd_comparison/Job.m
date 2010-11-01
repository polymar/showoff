#import "Job.h"

@implementation JobQueue

// not to be called on the abstract class
- (void)queueJob:(Job *)aJob
{
	[NSException raise:NSInternalInconsistencyException format:@"Abstract method invoked"];
}

- (void)lastJobFinished
{
}

@end

@implementation Job

@synthesize iterationsRemaining;

- (id)initWithIterations:(NSInteger)iterations
{
	self = [super init];
	if (self)
	{
		iterationsRemaining = iterations;
		finishedSignal = [[NSCondition alloc] init];
	}
	return self;
}

- (void)performIterationAndRequeueInJobQueue:(JobQueue *)aJobQueue
{
	[finishedSignal lock];
	iterationsRemaining--;
	
	if (iterationsRemaining == 0)
	{
		[finishedSignal broadcast];
		[finishedSignal unlock];
		[aJobQueue lastJobFinished];
	}
	else
	{
		[finishedSignal unlock];
		[aJobQueue queueJob:self];
	}
}

- (void)blockUntilFinished
{
	[finishedSignal lock];
	if (iterationsRemaining > 0)
	{
		[finishedSignal wait];
	}
	[finishedSignal unlock];
	[finishedSignal release];
	finishedSignal = nil;
}

- (void)killJob
{
	[finishedSignal lock];
	iterationsRemaining = 0;
	[finishedSignal broadcast];
	[finishedSignal unlock];
}

@end