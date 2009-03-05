#import "MVFunction.h"

@implementation MVSelectorF

+ (MVSelectorF *)functionFromSelector:(SEL)s {
	return [[[self alloc] initWithSelector:s] autorelease];
}

- (MVSelectorF *)initWithSelector:(SEL)s {
	if ((self = [super init])) {
		selector = s;
	}
	return self;
}

- (id)apply:(id)arg {
	return [arg performSelector:selector];
}	
@end
