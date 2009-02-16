#import <Foundation/Foundation.h>

@interface MVOption : NSObject
+ (MVOption *)fromNil:(id)maybeNil;
+ (MVOption *)none;
+ (MVOption *)some:(id)someObject;
- (BOOL)isNone;
- (BOOL)isSome;
- (id)some;
@end

@interface MVNone : MVOption
@end

@interface MVSome : MVOption {
    id someObject;
}
@end
