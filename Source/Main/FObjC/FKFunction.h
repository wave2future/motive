#import <Foundation/Foundation.h>

// TODO Add in F2, F3, etc.

@protocol FKFunction <NSObject>
- (id)f:(id)arg;
@end

@interface FKFunction : NSObject
+ (id <FKFunction>)functionFromSelector:(SEL)s;
@end
