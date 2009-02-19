#import <Foundation/Foundation.h>

@interface ThreadUtil : NSObject

+ (void)waitUsingRunLoopUntilIntervalEllapsed:(NSTimeInterval)interval;

@end
