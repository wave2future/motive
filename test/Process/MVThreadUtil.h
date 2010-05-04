#import <Foundation/Foundation.h>

@interface MVThreadUtil : NSObject

+ (void)waitUsingRunLoopUntilIntervalEllapsed:(NSTimeInterval)interval;

@end
