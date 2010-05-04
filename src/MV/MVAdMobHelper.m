#import "MVAdMobHelper.h"
#import "NSString+Motive.h"
#import "MVLog.h"

@interface MVAdMobHelper (AdMobHelperPrivate)
+ (NSString *)adMobUrlWithAdditionalQueryStringParams:(NSString *)queryStringParams;
+ (void)reportAppStartToAdMobWithUrl:(NSString *)url;
+ (NSInteger)statusCodeForResponse:(NSURLResponse *)response;
@end

@implementation MVAdMobHelper

+ (NSString *)adMobAppOpenReportedFilePath {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"admob_app_open"];
}

+ (void)reportAppStartToAdMobWithSiteId:(NSString *)siteId {
    [MVAdMobHelper reportAppStartToAdMobWithUrl:[MVAdMobHelper adMobUrlWithAdditionalQueryStringParams:[NSString stringWithFormat:@"site_id=%@", siteId]]];
}

+ (void)reportAppStartToAdMobWithAppId:(NSString *)appId {
    [MVAdMobHelper reportAppStartToAdMobWithUrl:[MVAdMobHelper adMobUrlWithAdditionalQueryStringParams:[NSString stringWithFormat:@"app_id=%@", appId]]];
}

#pragma mark Private methods.
+ (NSString *)adMobUrlWithAdditionalQueryStringParams:(NSString *)queryStringParams {
    return [NSString stringWithFormat:@"http://a.admob.com/f0?isu=%@&%@", [[UIDevice currentDevice] uniqueIdentifier], queryStringParams];
}

+ (void)reportAppStartToAdMobWithUrl:(NSString *)url {
    if (![[MVAdMobHelper adMobAppOpenReportedFilePath] fileExistsAtPath]) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        LOG(@"Reporting initial application start to AdMob on URL %@", [[request URL] absoluteString]);
        NSURLResponse *response;
        NSError *error;
        NSString *content = [NSString stringWithContentsOfURL:[request URL] encoding:NSUTF8StringEncoding error:&error];
        if (error == nil && [self statusCodeForResponse:response] == 200 && [content isNotEmpty]) {
            LOG(@"Successfully reported app open, response: %@", content);
            [[MVAdMobHelper adMobAppOpenReportedFilePath] touchFileAtPath];
        }
    } else {
        LOG(@"App has already been reported");      
    }
}

+ (NSInteger)statusCodeForResponse:(NSURLResponse *)response {
	return response != nil && [response isKindOfClass:[NSHTTPURLResponse class]] ? [((NSHTTPURLResponse *) response) statusCode] : 0;
}

@end
