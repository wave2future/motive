#import "NSArray+Motive.h"

@implementation NSArray (MotiveExtensions)

- (BOOL)isEmpty {
    return [self count] == 0;
}

- (BOOL)isNotEmpty {
    return !self.isEmpty;
}

@end
