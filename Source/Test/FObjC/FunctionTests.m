#import "GTMSenTestCase.h"
#import "MVFunction.h"
#import "MVP1.h"
#import "MVLog.h"

NEWTYPE(Age, NSString, age);

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
	
	Age *mine = [Age age:@"54"];
	
	NSLog([mine description]);
	NSLog([mine age]);
}
@end
