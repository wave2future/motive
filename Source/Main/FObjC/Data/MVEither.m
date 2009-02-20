#import "MVEither.h"

@interface MVEither (MVEitherPrivate)
- (MVEither *)initWithObject:(id)object onLeft:(BOOL)onLeft;
@end

@implementation MVEither

+ (MVEither *)leftWithObject:(id)object {
    return [[[MVEither alloc] initWithObject:object onLeft:YES] autorelease];
}

+ (MVEither *)rightWithObject:(id)object {
    return [[[MVEither alloc] initWithObject:object onLeft:NO] autorelease];
}

- (BOOL)isLeft {
    return onleft;
}

- (BOOL)isRight {
    return !onleft;
}

- (id)value {
    return object;
}

- (void)dealloc {
    [object release];
    [super dealloc];
}

#pragma mark Private methods.
- (MVEither *)initWithObject:(id)newObject onLeft:(BOOL)newOnLeft {
    if (self = [super init]) {
        object = [newObject retain];
        onleft = newOnLeft;
    }
    return self;
}

@end
