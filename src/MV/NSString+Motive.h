#import <Foundation/Foundation.h>

@interface NSString (MotiveExtension)

- (BOOL)isEmpty;
- (BOOL)isNotEmpty;

+ (NSString *)stringWithData:(NSData *)data;

// YES if this string contains the |other| string.
- (BOOL)contains:(NSString *)other;

- (NSData *)asData;

- (NSString *)trim;

- (NSString *)trimNewLines;

- (NSString *)md5;

- (BOOL)touchFileAtPath;

- (BOOL)fileExistsAtPath;

- (BOOL)caseInsensitiveFileExistsAtPath;

// The size of the file at the path represented by this string or -1.
- (NSNumber *)fileSizeAtPath;

// MD5 hash for the file at the path represented by this string or nil.
- (NSString *)md5ForFileAtPath;

@end
