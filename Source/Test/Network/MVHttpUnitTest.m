#import "GTMSenTestCase.h"

@interface MVHttpUnitTest : GTMTestCase {
}
@end

@implementation MVHttpUnitTest

- (void)testEncodesADictionaryAsAQueryString {
    NSMutableDictionary params = [NSMutableDictionary dictionary];
    [params setValue:[NSNumber numberWithInt:1] forKey:@"foo"];
    [params setValue:@"somebar" forKey:@"bar"];
    STAssertEqualObjects(@"", [MVHttp queryStringFromDictionary:params], nil);
}

@end

