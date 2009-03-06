#import "NSString+Motive.h"

@implementation NSString (MotiveExtension)

- (BOOL)isEmpty {
    return [self length] == 0;
}

- (BOOL)isNotEmpty {
    return !self.isEmpty;
}

- (NSString *)stringWithData:(NSData *)data {
    return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
}

@end
