#import "NSString+Motive.h"

@implementation NSString (MotiveExtension)

- (BOOL)isEmpty {
    return [self length] == 0;
}

- (BOOL)isNotEmpty {
    return !self.isEmpty;
}

+ (NSString *)stringWithData:(NSData *)data {
    return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
}

- (NSData *)asData {
    return [self dataUsingEncoding:NSStringEncodingConversionAllowLossy];
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)trimNewLines {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)touchFile {
    return [[NSFileManager defaultManager] createFileAtPath:self contents:nil attributes:nil];
}

- (BOOL)fileExists {
    return [[NSFileManager defaultManager] fileExistsAtPath:self];
}

@end