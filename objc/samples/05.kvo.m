#include <Foundation/Foundation.h>

@interface Lever : NSObject
{
	BOOL leverUp;
}

- (void)setLeverUp:(BOOL)x;

@end

@implementation Lever

- (void)setLeverUp:(BOOL)x;
{
	leverUp = x;
}

@end

@interface SecretPassage : NSObject

- (void)linkToLever:(Lever *)lever;

@end

@implementation SecretPassage

- (void)linkToLever:(Lever *)lever;
{
	[lever addObserver:self
	        forKeyPath:@"leverUp"
	           options:NSKeyValueObservingOptionNew
	           context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)ctx;
{
	BOOL newLeverUp = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
	
	if (newLeverUp == YES)
		printf("--> Opening the secret passage. You found your treasure.\n");
	else
		printf("--> SCREEEK\n");
}

@end

int main()
{
	NSAutoreleasePool * p = [NSAutoreleasePool new];
	
	SecretPassage * passage = [SecretPassage new];
	Lever         * lever   = [Lever         new];
	
	[passage linkToLever:lever];
	
	printf("Pushing the lever up!\n");
	[lever setLeverUp:YES];
	
	printf("Close the passage, i want the treasure only for myself!\n");
	[lever setLeverUp:NO];
	
	return 0;
}