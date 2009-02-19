#import "GTMSenTestCase.h"
#import "MVOption.h"

@interface MVOptionUnitTest : GTMTestCase {
    NSObject *object;
}
@end

@implementation MVOptionUnitTest

- (void)setUp {
    object = [[[NSObject alloc] init] autorelease];
}

- (void)testANoneIsNone {
    STAssertTrue([[MVOption none] isNone], nil);
    STAssertFalse([[MVOption none] isSome], nil);
}

- (void)testASomeIsSome {
    STAssertTrue([[MVOption some:object] isSome], nil);
    STAssertFalse([[MVOption some:object] isNone], nil);
}

- (void)testCanPullTheSomeValueOutOfASome {
    STAssertEqualObjects(object, [[MVOption some:object] some], nil);
}

- (void)testTransformsNilsIntoNones {
    STAssertTrue([[MVOption fromNil:nil] isNone], nil);
    STAssertTrue([[MVOption fromNil:object] isSome], nil);
}

@end
