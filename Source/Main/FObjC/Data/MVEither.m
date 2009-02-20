#import "MVEither.h"

@interface MVEither (MVEitherPrivate)
- (MVEither *)initWithValue:(id)value onLeft:(BOOL)onLeft;
@end

@implementation MVEither

+ (MVEither *)leftWithValue:(id)value {
    return [[[MVEither alloc] initWithValue:value onLeft:YES] autorelease];
}

+ (MVEither *)rightWithValue:(id)value {
    return [[[MVEither alloc] initWithValue:value onLeft:NO] autorelease];
}

- (BOOL)isLeft {
    return onleft;
}

- (BOOL)isRight {
    return !onleft;
}

- (id)value {
    return value;
}

#pragma mark NSObject methods.
- (BOOL)isEqual:(id)object {
    if (object == nil || ![[object class] isEqual:[MVEither class]]) {
        return NO;
    } else {
        MVEither *other = (MVEither *) object;
        return [self isLeft] == [other isLeft] && [[self value] isEqual:[other value]];
    }
}

- (NSUInteger)hash {
    return value == nil ? 42 : [value hash];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<MVEither isLeft: %@; value: %@>", onleft ? @"true" : @"false", value];
}

- (void)dealloc {
    [value release];
    [super dealloc];
}

#pragma mark Private methods.
- (MVEither *)initWithValue:(id)newValue onLeft:(BOOL)newOnLeft {
    if (self = [super init]) {
        value = [newValue retain];
        onleft = newOnLeft;
    }
    return self;
}

@end
