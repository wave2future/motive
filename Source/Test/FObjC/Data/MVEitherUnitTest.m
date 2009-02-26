#import "GTMSenTestCase.h"
#import "MVEither.h"

@interface MVEitherUnitTest : GTMTestCase {
    NSObject *object;
}
@end

@implementation MVEitherUnitTest

- (void)setUp {
    object = [[[NSObject alloc] init] autorelease];
}

- (void)testALeftIsLeft {
    MVEither *left = [MVEither leftWithValue:object];
    STAssertTrue([left isLeft], nil);
    STAssertFalse([left isRight], nil);
}

- (void)testARightIsRight {
    MVEither *right = [MVEither rightWithValue:object];
    STAssertTrue([right isRight], nil);
    STAssertFalse([right isLeft], nil);
}

- (void)testALeftCanHoldAValue {
    MVEither *left = [MVEither leftWithValue:object];
    STAssertEqualObjects(object, [left value], nil);
}

- (void)testARightCanHoldAValue {
    MVEither *right = [MVEither rightWithValue:object];
    STAssertEqualObjects(object, [right value], nil);
}

@end
