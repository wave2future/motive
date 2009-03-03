#import <Foundation/Foundation.h>
#import "MVMacros.h"

@class MVEither;

@interface MVLeftProjection : NSObject {
    MVEither *either;
}

// The either value underlying this projection.
READ MVEither *either;

// The value of this projection or fails (throws an NSException) with a specialised error message.
READ id value;

// Returns the value of this projection or fails (throws an NSException) with the given error message.
- (id)valueOrMessage:(NSString*)errorMessage;

@end

// A right projection of an either value.
@interface MVRightProjection : NSObject {
    MVEither *either;
}

// The either value underlying this projection.
READ MVEither *either;

// The value of this projection or fails (throws an NSException) with a specialised error message.
READ id value;

// TODO Look at FJ projections for a better way to return an error, so we don't need to do: [(NSError *)[result value]  localizedDescription].

// Returns the value of this projection or fails (throws an NSException) with the given error message.
- (id)valueOrMessage:(NSString*)errorMessage;

@end

// The Either type represents a value of one of two possible types (a disjoint union).
// The data constructors; Left and Right represent the two possible values. The Either type is often used as an alternative to Option where Left 
// represents failure (by convention) and Right is akin to Some.
@interface MVEither : NSObject {
    id value;
    BOOL isLeft;
}

READ BOOL isLeft;
READ BOOL isRight;
READ MVLeftProjection *left;
READ MVRightProjection *right;

// Construct a left value of either.
+ (MVEither *)leftWithValue:(id)value;

// Construct a right value of either.
+ (MVEither *)rightWithValue:(id)value;

// If this is a left, then return the left value in right, or vice versa.
- (MVEither *)swap;


// TODO DELETE BELOW HERE. THESE BELONG IN PROJECTIONS.


// Maps the given selector across the value in the left of this either.
// Note. Returns this either (i.e. self) if the value in this either does not response to |selector|.
- (MVEither *)mapLeftWithSelector:(SEL)selector;

// Maps the given selector across the left of this either by invoking |selector| on |object| passing the value in the left as an argument.
// |selector| should be a method taking a single argument of type |id| and return |id|.
// Note. Returns this either (i.e. self) if the given |object| does not response to |selector|.
- (MVEither *)mapLeftWithSelector:(SEL)selector onObject:(id)object;

// Maps the given selector across the value in the right of this either.
// Note. Returns this either (i.e. self) if the value in this either does not response to |selector|.
- (MVEither *)mapRightWithSelector:(SEL)selector;

// Maps the given selector across the right of this either by invoking |selector| on |object| passing the value in the right as an argument.
// |selector| should be a method taking a single argument of type |id| and return |id|.
// Note. Returns this either (i.e. self) if the given |object| does not response to |selector|.
- (MVEither *)mapRightWithSelector:(SEL)selector onObject:(id)object;

@end
