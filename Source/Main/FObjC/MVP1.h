#import <Foundation/Foundation.h>
#import "MVMacros.h"
#import <objc/runtime.h>

@interface MVP1 : NSObject {
    id _1;
}

READ id _1;

+ (MVP1 *)p1With_1:(id)_1;
- (id)initWith_1:(id)new_1;
@end

#define NEWTYPE(newtype, wrappedtype, cons) \
@interface newtype : MVP1 \
+ (newtype *)cons:(wrappedtype *)thing; \
- (wrappedtype *)cons;\
@end \
@implementation newtype \
- (newtype *)initWith_1:(id)new_1 { \
	if ((self = [super initWith_1:new_1])) { \
	} \
	return self;\
} \
+ (newtype *)cons:(wrappedtype *)thing { \
	return [[[self alloc] initWith_1:thing] autorelease]; \
}\
- (wrappedtype *)cons { \
	return _1; \
} \
- (NSString *)description { \
	return [NSString stringWithFormat:@"<%s: %s=%@>", class_getName([self class]), #cons, _1]; \
} \
@end
