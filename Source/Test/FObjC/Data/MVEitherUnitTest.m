#import "GTMSenTestCase.h"
#import "MVEither.h"

@interface MVEitherUnitTest : GTMTestCase {
    NSObject *o1;
    NSObject *o2;
}
@end

@implementation MVEitherUnitTest

- (void)setUp {
    o1 = [[[NSObject alloc] init] autorelease];
    o2 = [[[NSObject alloc] init] autorelease];
}

- (void)testALeftIsLeft {
    MVEither *leftEither = [MVEither leftWithValue:o1];
    MVLeftProjection *left = leftEither.left;
    STAssertTrue(leftEither.isLeft, nil);
    STAssertFalse(leftEither.isRight, nil);
    STAssertEqualObjects(o1, left.value, nil);
}

- (void)testARightIsRight {
    MVEither *rightEither = [MVEither rightWithValue:o1];
    MVRightProjection *right = rightEither.right;
    STAssertTrue(rightEither.isRight, nil);
    STAssertFalse(rightEither.isLeft, nil);
    STAssertEqualObjects(o1, right.value, nil);
}

- (void)testTwoLeftsWithEqualValuesAreEqual {
    MVEither *l1 = [MVEither leftWithValue:o1];
    MVEither *l2 = [MVEither leftWithValue:o1];
    STAssertEqualObjects(l1, l2, nil);
}

- (void)testTwoRightsWithEqualValuesAreEqual {
    MVEither *r1 = [MVEither rightWithValue:o1];
    MVEither *r2 = [MVEither rightWithValue:o1];
    STAssertEqualObjects(r1, r2, nil);
}

- (void)testTwoLeftsWithUnEqualValuesAreNotEqual {
    MVEither *l1 = [MVEither leftWithValue:o1];
    MVEither *l2 = [MVEither leftWithValue:o2];
    STAssertNotEqualObjects(l1, l2, nil);
}

- (void)testTwoRightsWithUnEqualValuesAreNotEqual {
    MVEither *r1 = [MVEither rightWithValue:o1];
    MVEither *r2 = [MVEither rightWithValue:o2];
    STAssertNotEqualObjects(r1, r2, nil);
}

- (void)testALeftAndARightAreNotEqual {
    MVEither *l = [MVEither leftWithValue:o1];
    MVEither *r = [MVEither rightWithValue:o1];
    STAssertNotEqualObjects(l, r, nil);
}

- (void)testAccessingTheRightValueInLeftThrowsAnError {
    MVEither *l = [MVEither leftWithValue:o1];
    @try {
        l.right.value;
        STFail(@"Expected an exception to be thrown");
    }
    @catch (id exception) {
    }
}

- (void)testAccessingTheLeftValueInLeftThrowsAnError {
    MVEither *r = [MVEither rightWithValue:o1];
    @try {
        r.left.value;
        STFail(@"Expected an exception to be thrown");
    }
    @catch (id exception) {
    }
}

- (void)testMappingAcrossTheLeft {
	MVEither *l = [MVEither leftWithValue:[NSNumber numberWithInt:54]];
	MVEither *mapped = [l mapLeftWithSelector:@selector(description)];
	STAssertTrue(mapped.isLeft,nil);
	STAssertEqualObjects(mapped.left.value, @"54",nil);
}

- (void)testMappingAcrossTheRight {
	MVEither *l = [MVEither rightWithValue:[NSNumber numberWithInt:54]];
	MVEither *mapped = [l mapRightWithSelector:@selector(description)];
	STAssertTrue(mapped.isRight,nil);
	STAssertEqualObjects(mapped.right.value, @"54",nil);	
}

@end
