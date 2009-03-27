#import <Foundation/Foundation.h>
#import "MVMacros.h"

@interface NSArray (MotiveExtensions)

READ BOOL isEmpty;
READ BOOL isNotEmpty;
+ (NSArray *)repeat:(id)object times:(NSUInteger)times;

@end
