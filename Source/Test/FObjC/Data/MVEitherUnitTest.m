// (c) Xumii, All Rights Reserved

#import <OCMock/OCMock.h>
#import "GTMSenTestCase.h"
#import "XIEither.h"

@interface XIEitherUnitTest : GTMTestCase {
    NSObject *object;
}
@end

@implementation XIEitherUnitTest

- (void)setUp {
    object = [[[NSObject alloc] init] autorelease];
}

- (void)testALeftIsLeft {
    XIEither *left = [XIEither leftWithObject:object];
    STAssertTrue([left isLeft], nil);
    STAssertFalse([left isRight], nil);
}

- (void)testARightIsRight {
    XIEither *right = [XIEither rightWithObject:object];
    STAssertTrue([right isRight], nil);
    STAssertFalse([right isLeft], nil);
}

- (void)testALeftHoldsAValue {
    XIEither *left = [XIEither leftWithObject:object];
    STAssertEqualObjects(object, [left value], nil);
}

- (void)testARightHoldsAValue {
    XIEither *right = [XIEither rightWithObject:object];
    STAssertEqualObjects(object, [right value], nil);
}

@end
