//
//  TTDevDayObject.m
//  forwarding
//
//  Created by openovo on 10/31/10.
//  Copyright 2010 Openovo.com. All rights reserved.
//

#import "TTDevDayObject.h"

@implementation TTDevDayObject

- (id) init {
	if (self = [super init]) {
		NSArray* objects = [NSArray arrayWithObjects:@"TomTom",@"Roberto Gamboni",nil];
		NSArray* keys = [NSArray arrayWithObjects:@"company", @"employee", nil];
		aDictionary = [NSDictionary dictionaryWithObjects:objects
												  forKeys:keys];
	}
	return self;
}

- (void) count {
	printf("Hello world %d\n", counter++);
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
	NSString* a = NSStringFromSelector([anInvocation selector]);
	[anInvocation setArgument: &a atIndex: 2];
	[anInvocation setSelector: NSSelectorFromString(@"objectForKey:")];
	return [anInvocation invokeWithTarget:aDictionary];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	NSString* method = NSStringFromSelector(aSelector);
	if([aDictionary objectForKey:method] != nil) 
		return [[aDictionary class] instanceMethodSignatureForSelector:NSSelectorFromString(@"objectForKey:") ];
	return [super methodSignatureForSelector:aSelector];
}

@end
