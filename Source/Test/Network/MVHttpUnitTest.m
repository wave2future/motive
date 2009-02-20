#import "GTMSenTestCase.h"
#import "MVHttp.h"

@interface MVHttpUnitTest : GTMTestCase {
}
@end

@implementation MVHttpUnitTest

- (void)testEncodesAnEmptyDictionAryAsAnEmpty {
    STAssertEqualObjects(@"", [MVHttp queryStringFromDictionary:[NSDictionary dictionary]], nil);
}

- (void)testEncodesADictionaryAsAQueryString {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[NSNumber numberWithInt:1] forKey:@"foo"];
    [params setValue:@"somebar" forKey:@"bar"];
    STAssertEqualObjects(@"foo=1&bar=somebar", [MVHttp queryStringFromDictionary:params], nil);
}

@end

