#import <Foundation/Foundation.h>
#import "FKFunction.h"
#import "MVMacros.h"

@interface NSArray (MotiveExtensions)

READ BOOL isEmpty;
READ BOOL isNotEmpty;

- (BOOL)all:(SEL)predicate;
- (NSArray *)map:(id <FKFunction>)f;
@end
