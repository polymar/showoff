//
//  TTDevDayObject.m
//  plain_objc
//
//  Created by openovo on 10/30/10.
//  Copyright 2010 Openovo.com. All rights reserved.
//

#import "TTDevDayObject.h"
#import <stdio.h>

@implementation TTDevDayObject

+ initialize { 
	return self; 
}

+ alloc { 
	class_createInstance(self, 0); 
}

- free { 
	object_dispose(self);
}

- count { 
	printf("Hello world %d\n", counter++); 
}

@end
