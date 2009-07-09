#import <Foundation/Foundation.h>

@interface NSString (MotiveExtension)

READ BOOL isEmpty;
READ BOOL isNotEmpty;

+ (NSString *)stringWithData:(NSData *)data;

- (NSData *)asData;

- (NSString *)trim;

- (NSString *)trimNewLines;

- (BOOL)touchFileAtPath;

- (BOOL)fileExistsAtPath;

// The size of the file at the path represented by this string or -1.
- (NSNumber *)fileSizeAtPath;

// MD5 hash for the file at the path represented by this string or nil.
- (NSString *)md5ForFileAtPath;

@end
