#import "GTMSenTestCase.h"
#import "MVFunction.h"
#import "MVLog.h"
#import "MVNewtype.h"

NEWTYPE(Age, NSString);
NEWTYPE(Name, NSString);
NEWTYPE2(Person, Age, Name);

@interface MVFunctionUnitTest : GTMTestCase {
    NSObject *object;
}
@end

@implementation MVFunctionUnitTest

- (void)setUp {
	object = [[[NSObject alloc] init] autorelease];
}

- (void)testSelectorFuncAppliesSelector {
	NSString *d = [object description];
	id <F> f = [MVSelectorF functionFromSelector:@selector(description)];
	NSString *result = [f apply:object];
	STAssertEqualObjects(d, result, nil);
	
	Age *age = [Age value:@"54"];
	Name *name = [Name value:@"Nick"];
	Person *nick = [Person value:age :name];
	NSLog([nick description]);
	NSLog([[nick _1] description]);
	NSLog([[nick _2] description]);
}
@end
