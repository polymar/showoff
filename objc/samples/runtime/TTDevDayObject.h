//
//  TTDevDayObject.h
//  runtime
//
//  Created by openovo on 10/31/10.
//  Copyright 2010 Openovo.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTDevDayObject : NSObject {
	int counter;
}

- (void) implementSEL:(SEL) aSelector;

- (void) count;

@end
