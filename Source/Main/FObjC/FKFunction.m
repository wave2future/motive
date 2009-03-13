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

- (id):(id)arg {
	return [arg performSelector:selector];
}
@end

@interface FKFunctionFromSelectorWithTarget : NSObject <FKFunction> {
	SEL selector;
	NSObject *target;
}
- (FKFunctionFromSelectorWithTarget *)initWithSelector:(SEL)s target:(NSObject *)target;
@end

@implementation FKFunctionFromSelectorWithTarget
- (FKFunctionFromSelectorWithTarget *)initWithSelector:(SEL)s target:(NSObject *)nTarget {
	if (![nTarget respondsToSelector:s]) {
		@throw [NSException exceptionWithName:@"InvalidOperation" reason:[NSString stringWithFormat:@"target %@ does not respond to selector %s", nTarget, sel_getName(s)] userInfo:[NSDictionary dictionary]];
	}
	if ((self = [super init])) {
		selector = s;
		target = [nTarget retain];
	}
	return self;
}

- (id):(id)arg {
	return [target performSelector:selector withObject:arg];
}
@end

@interface FKLiftedFunction : NSObject <FKFunction> {
	id <FKFunction> f;
}
- (FKLiftedFunction *)initWithF:(FKFunction *)f;
@end
@implementation FKLiftedFunction
- (FKLiftedFunction *)initWithF:(FKFunction *)inF {
	if ((self = [super init])) {
		f = [inF retain];
	}
	return self;
}

- (id):(id)arg {
	//TODO: type check
	NSArray *argArray = arg;
	NSMutableArray *arr = [NSMutableArray arrayWithCapacity:[arg count]];
	for (id obj in argArray) {
		[arr addObject:[f :obj]];
	}
	return arr;
}

@end



@implementation FKFunction
+ (id <FKFunction>)functionFromSelector:(SEL)s {
	return [[[FKFunctionFromSelector alloc] initWithSelector:s] autorelease];
}
+ (id <FKFunction>)functionFromSelector:(SEL)s target:(NSObject *)target {
	return [[[FKFunctionFromSelectorWithTarget alloc] initWithSelector:s target:target] autorelease];
}

+ (id <FKFunction>)lift:(id <FKFunction>)f {
	return [[[FKLiftedFunction alloc] initWithF:f] autorelease];
}
@end

