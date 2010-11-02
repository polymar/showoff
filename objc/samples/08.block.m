#import <Foundation/Foundation.h>
#import <stdlib.h>

@interface Predicate : NSObject
{
	BOOL (^predicate)();
}

@property (copy) BOOL (^predicate)();

-(void)onSuccess:(void(^)())true_ onFail:(void(^)())false_;

@end

@implementation Predicate
@synthesize predicate;

// eheh, this looks so JavaScript
-(void)onSuccess:(void(^)())true_ onFail:(void(^)())false_ {
	if(predicate())
		true_();
	else 
		false_();
}

-(void)dealloc {
	self.predicate = nil;
	[super dealloc];
}
@end


int main (int argc, const char * argv[]) {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	srandom(time(NULL));
	
	Predicate *pr = [[Predicate new] autorelease];
	pr.predicate = ^BOOL { return random()%2; };
	
	[pr onSuccess:^ {NSLog(@"Yeah");} onFail:^ {NSLog(@"Nope");} ];
	
	[pool drain];
	return 0;
}

