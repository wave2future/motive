#import "GTMSenTestCase.h"
#import "MVFunction.h"
#import "MVLog.h"
#import "MVNewtype.h"

NEWTYPE(Age, NSString);

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
	
	Age *mine = [Age value:@"54"];
	NSLog([mine description]);
	NSLog([mine _1]);
}
@end
