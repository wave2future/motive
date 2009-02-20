#import <Foundation/Foundation.h>

// TODO Look at FJ projections for a better way to return an error, so we don't need to do: [(NSError *)[result value]  localizedDescription].
// TODO Add in some projections, look at FJ for details.

// The Either type represents a value of one of two possible types (a disjoint union).
// The data constructors; Left and Right represent the two possible values. The Either type is often used as an alternative to Option where Left 
// represents failure (by convention) and Right is akin to Some.
@interface MVEither : NSObject {
    id object;
    BOOL onleft;
}

// Construct a left value of either.
+ (MVEither *)leftWithObject:(id)object;

// Construct a right value of either.
+ (MVEither *)rightWithObject:(id)object;

// Does this either have a value on the left?
- (BOOL)isLeft;

// Does this either have a value on the right?
- (BOOL)isRight;

// Returns the value contained in this either.
- (id)value;

@end
