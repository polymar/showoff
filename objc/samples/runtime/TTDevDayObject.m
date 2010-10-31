//
//  TTDevDayObject.m
//  runtime
//
//  Created by openovo on 10/31/10.
//  Copyright 2010 Openovo.com. All rights reserved.
//

#import "TTDevDayObject.h"

@implementation TTDevDayObject

void dynamicMethodIMP(id self, SEL _cmd) { // implementation ....
	NSLog(@"What should I do?");
}

- (void) implementSEL:(SEL) aSelector {
	if (aSelector != @selector(count)) { 
		class_addMethod([self class], aSelector, (IMP) dynamicMethodIMP, "v@:"); 
	}
}

- (void) count {
	printf("Hello world %d\n", counter++);
}

@end
