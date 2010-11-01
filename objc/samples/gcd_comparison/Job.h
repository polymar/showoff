#import <Foundation/Foundation.h>

@class JobQueue;

@interface Job : NSObject
{
	NSInteger iterationsRemaining;
	NSCondition *finishedSignal;
}

@property (nonatomic, assign) NSInteger iterationsRemaining;

- (id)initWithIterations:(NSInteger)iterations;
- (void)performIterationAndRequeueInJobQueue:(JobQueue *)aJobQueue;
- (void)blockUntilFinished;

@end

//JobQueue Abstraction -- subclasses will do the real job

@interface JobQueue : NSObject
{
}

- (void)queueJob:(Job *)aJob;

@end