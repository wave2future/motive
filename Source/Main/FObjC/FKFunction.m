#import "FKFunction.h"

@interface FKFunctionFromSelector : NSObject <FKFunction> {
	SEL selector;
}
- (FKFunctionFromSelector *)initWithSelector:(SEL)s;
@end

@implementation FKFunctionFromSelector
- (FKFunctionFromSelector *)initWithSelector:(SEL)s {
	if ((self = [super init])) {
		selector = s;
	}
	return self;
}

- (id)f:(id)arg {
	return [arg performSelector:selector];
}
@end

@implementation FKFunction
+ (id <FKFunction>)functionFromSelector:(SEL)s {
	return [[[FKFunctionFromSelector alloc] initWithSelector:s] autorelease];
}
@end

