#import <Foundation/Foundation.h>
#import "MVMacros.h"

@interface NSArray (MotiveExtensions)

READ BOOL isEmpty;
READ BOOL isNotEmpty;

- (BOOL)all:(SEL)predicate;

@end
