#import <Foundation/Foundation.h>
#import "MVMacros.h"

@interface NSString (MotiveExtension)

READ BOOL isEmpty;
READ BOOL isNotEmpty;

- (NSString *)stringWithData:(NSData *)data;

@end
