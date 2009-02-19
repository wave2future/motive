#import "MVP2.h"

@interface MVP2 (MVP2Private)
- (MVP2 *)initWith_1:(id)new_1 _2:(id)new_2;
@end

@implementation MVP2

@synthesize _1, _2;

+ (MVP2 *)mvP2With_1:(id)_1 _2:(id)_2 {
    return [[[MVP2 alloc] initWith_1:_1 _2:_2] autorelease];
}

- (void) dealloc {
    [_1 release];
    [_2 release];
    [super dealloc];
}

#pragma mark Private methods.
- (MVP2 *)initWith_1:(id)new_1 _2:(id)new_2 {
    if (self = [super init]) {
        _1 = [new_1 retain];
        _2 = [new_2 retain];
    }
    return self;
}

@end
