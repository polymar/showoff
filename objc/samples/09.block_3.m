#import <Foundation/Foundation.h>
#import <stdlib.h>

@interface PredicateRunner : NSObject
{
	BOOL (^predicate)();
}
@property (copy) BOOL (^predicate)();
-(void)callTrueBlock:(void(^)())true_ falseBlock:(void(^)())false_;
@end

@implementation PredicateRunner
@synthesize predicate;

-(void)callTrueBlock:(void(^)())true_ falseBlock:(void(^)())false_;
{
	if(predicate())
		true_();
	else 
		false_();
	
}
-(void)dealloc;
{
	self.predicate = nil;
	[super dealloc];
}
@end



int main (int argc, const char * argv[]) {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	srandom(time(NULL));
	
	PredicateRunner *pr = [[PredicateRunner new] autorelease];
	pr.predicate = ^ BOOL {
		return random()%2;
	};
	[pr callTrueBlock:^ {NSLog(@"Yeah");} falseBlock:^ {NSLog(@"Nope");} ];
	
	[pool drain];
	return 0;
}

