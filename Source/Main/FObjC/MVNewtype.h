
/*
 Macros for creating instant types based on P*'s.
 Provides somewhat typesafe contructors and accessors.
 
 Usage:
 
	NEWTYPE(MyNewType, NSString);
 
 Later...
	MyNewType *instance = [MyNewType value:@"foobar"];
	[instance value]; // @foobar
 */

#import "MVP1.h"
#import "MVP2.h"

// P1 newtype
#define NEWTYPE(newtype, wrappedtype) \
@interface newtype : MVP1 \
+ (newtype *)value:(wrappedtype *)thing; \
@end \
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

// P2 newtype
#define NEWTYPE2(newtype, wrappedtype1, wrappedtype2) \
@interface newtype : MVP2 \
+ (newtype *)value:(wrappedtype1 *)_1 :(wrappedtype2 *)_2; \
@end \
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
