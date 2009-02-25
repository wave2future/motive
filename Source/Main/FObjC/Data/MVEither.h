#import <Foundation/Foundation.h>

// TODO Look at FJ projections for a better way to return an error, so we don't need to do: [(NSError *)[result value]  localizedDescription].
// TODO Add in some projections, look at FJ for details.
// TODO Add isEqual: method.

// The Either type represents a value of one of two possible types (a disjoint union).
// The data constructors; Left and Right represent the two possible values. The Either type is often used as an alternative to Option where Left 
// represents failure (by convention) and Right is akin to Some.
@interface MVEither : NSObject {
    id value;
    BOOL onleft;
}

// Construct a left value of either.
+ (MVEither *)leftWithValue:(id)value;

// Construct a right value of either.
+ (MVEither *)rightWithValue:(id)value;

// Maps the given selector across the value in the left of this either.
- (MVEither *)mapLeftWithSelector:(SEL)selector;

// Maps the given selector across the left of this either by invoking |selector| on |object| passing the value in the left as an argument.
// |selector| should be a method taking a single argument of type |id| and return |id|.
// Note. Returns this either (i.e. self) if the given |object| does not response to |selector|.
- (MVEither *)mapLeftWithSelector:(SEL)selector onObject:(id)object;

// Maps the given selector across the value in the right of this either.
- (MVEither *)mapRightWithSelector:(SEL)selector;

// Maps the given selector across the right of this either by invoking |selector| on |object| passing the value in the right as an argument.
// |selector| should be a method taking a single argument of type |id| and return |id|.
// Note. Returns this either (i.e. self) if the given |object| does not response to |selector|.
- (MVEither *)mapRightWithSelector:(SEL)selector onObject:(id)object;

// Does this either have a value on the left?
- (BOOL)isLeft;

// Does this either have a value on the right?
- (BOOL)isRight;

// Returns the value contained in this either.
- (id)value;

@end
