//
#import "RunLoopQueue.h"
#import "Job.h"

@implementation RunLoopQueue

- (id)init
{
	self = [super init];
	if (self != nil)
	{
		runLoopThread = [[NSThread alloc] initWithTarget:self selector:@selector(runLoop) object:nil];
		[runLoopThread start];
	}
	return self;
}

- (void)runLoop
{
	//
	// Run loops will exit if they have no sources. We add a dummy NSPort object
	// to the run loop so it will run until we call CFRunLoopStop().
	//
	NSPort *dummyPort = [[NSMachPort alloc] init];
	[[NSRunLoop currentRunLoop]
		addPort:dummyPort
		forMode:NSDefaultRunLoopMode];
		
	CFRunLoopRun();
	
	[[NSRunLoop currentRunLoop]
		removePort:dummyPort
		forMode:NSDefaultRunLoopMode];
	[dummyPort release];
}

- (void)lastJobFinished
{
	CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)queueJob:(Job *)aJob
{
	[aJob
		performSelector:@selector(performIterationAndRequeueInJobQueue:)
		onThread:runLoopThread 
		withObject:self
		waitUntilDone:NO];
}

- (void)dealloc
{
	[runLoopThread release];
	runLoopThread = nil;
	[super dealloc];
}

@end