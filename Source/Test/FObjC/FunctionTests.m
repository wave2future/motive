#import "GTMSenTestCase.h"
#import "MVFunction.h"

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
}
@end
