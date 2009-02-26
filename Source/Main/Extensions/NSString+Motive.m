#import "NSString+Motive.h"

@implementation NSString (MotiveExtension)

- (BOOL)isEmpty {
    return [self length] == 0;
}

- (BOOL)isNotEmpty {
    return !self.isEmpty;
}

@end
