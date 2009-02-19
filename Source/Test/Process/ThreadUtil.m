#import "ThreadUtil.h"

@implementation ThreadUtil

static const NSTimeInterval MVRunLoopInterval = 0.01;

+ (void)waitUsingRunLoopUntilIntervalEllapsed:(NSTimeInterval)interval {
    NSDate* giveUpDate = [NSDate dateWithTimeIntervalSinceNow:interval];
    while ([giveUpDate timeIntervalSinceNow] > 0) {
        NSDate* loopIntervalDate = [NSDate dateWithTimeIntervalSinceNow:MVRunLoopInterval];
        [[NSRunLoop currentRunLoop] runUntilDate:loopIntervalDate]; 
    }
}

@end
