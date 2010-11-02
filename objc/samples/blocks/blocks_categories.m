#include <Foundation/Foundation.h>
#include <Block.h>

@interface NSArray (ArrayProgramming)
- (NSArray*) each:(void (^)(id)) block;
@end

@implementation NSArray (ArrayProgramming)
- (NSArray*) each:(void (^)(id)) block {
	for(id obj in self)
		block(obj);
	return self;
}
@end

int main() {
	
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	NSMutableArray* array = [NSMutableArray arrayWithObjects:@"one",@"two",@"three",nil];
	
	[array each:^(id object) { NSLog(@"%@", object); } ];
	
	[pool drain];
	return 0;
}
