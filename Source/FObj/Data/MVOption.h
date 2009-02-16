#import <Foundation/Foundation.h>

@interface MVOption : NSObject

+ (MVOption *)fromNil:(id)maybeNil;

+ (MVOption *)none;

+ (MVOption *)some:(id)someObject;

- (BOOL)isNone;

- (BOOL)isSome;

- (id)some;

// Returns this optional value if there is one, otherwise, returns the argument optional value.
- (MVOption *)orElse:(MVOption *)other;

// Returns the value of this optional value or the given argument.
- (id)orSome:(id)some;

@end

@interface MVNone : MVOption
@end

@interface MVSome : MVOption {
    id someObject;
}
@end
