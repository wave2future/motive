
/*
 Macros for creating instant types based on P*'s.
 Provides somewhat typesafe contructors and accessors.
 
 If the type is local to a .m, then you can do this: 
	NEWTYPE(MyNewType, NSString);
 
 Later...
	MyNewType *instance = [MyNewType value:@"foobar"];
	[instance value]; // @foobar
 
 This won't work in a header though, as the implementation can't be defined in the .h.
	.h => NewTypeInterface(MyNewType, NSString);
	.m => NewTypeImplementation(MyNewType, NSString);
 */

#import "MVP1.h"
#import "MVP2.h"

// P1 newtype
#define NewTypeInterface(newtype, wrappedtype) \
@interface newtype : MVP1 \
+ (newtype *)value:(wrappedtype *)thing; \
@end

#define NewTypeImplementation(newtype, wrappedtype) \
@implementation newtype \
- (newtype *)initWith_1:(wrappedtype *)new_1 { \
if ((self = [super initWith_1:new_1])) { \
} \
return self;\
} \
+ (newtype *)value:(wrappedtype *)thing { \
return [[[self alloc] initWith_1:thing] autorelease]; \
}\
@end

#define NEWTYPE(newtype, wrappedtype) \
NewTypeInterface(newtype, wrappedtype) \
NewTypeImplementation(newtype, wrappedtype)

// P2 newtype
#define NewType2Interface(newtype, wrappedtype1, wrappedtype2) \
@interface newtype : MVP2 \
+ (newtype *)value:(wrappedtype1 *)_1 :(wrappedtype2 *)_2; \
@end

#define NewType2Implementation(newtype, wrappedtype1, wrappedtype2) \
@implementation newtype \
- (newtype *)initWith_1:(wrappedtype1 *)new_1 _2:(wrappedtype2 *)new_2 { \
	if ((self = [super initWith_1:new_1 _2:new_2])) { \
	} \
	return self; \
} \
+ (newtype *)value:(wrappedtype1 *)_1 :(wrappedtype2 *)_2 { \
	return [[[self alloc] initWith_1:_1 _2:_2] autorelease]; \
} \
@end

#define NEWTYPE2(newtype, wrappedtype1, wrappedtype2) \
NewType2Interface(newtype, wrappedtype1, wrappedtype2) \
NewType2Implementation(newtype, wrappedtype1, wrappedtype2)
