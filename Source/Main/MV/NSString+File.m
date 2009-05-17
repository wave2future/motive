#import "NSString+File.h"

@implementation NSString (FileExtensions)

- (BOOL)touchFile {
    return [[NSFileManager defaultManager] createFileAtPath:self contents:nil attributes:nil];
}

- (BOOL)fileExists {
    return [[NSFileManager defaultManager] fileExistsAtPath:self];
}

@end
