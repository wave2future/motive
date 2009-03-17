#import "AdMobHelper.h"
#import "NSString+File.h"
#import "NSString+Motive.h"
#import "MVLog.h"

@interface AdMobHelper (AdMobHelperPrivate)
+ (NSString *)adMobUrlWithAdditionalQueryStringParams:(NSString *)queryStringParams;
+ (void)reportAppStartToAdMobWithUrl:(NSString *)url;
+ (NSInteger)statusCodeForResponse:(NSURLResponse *)response;
@end

@implementation AdMobHelper

+ (NSString *)adMobAppOpenReportedFilePath {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"admob_app_open"];
}

+ (void)reportAppStartToAdMobWithSiteId:(NSString *)siteId {
    [AdMobHelper reportAppStartToAdMobWithUrl:[AdMobHelper adMobUrlWithAdditionalQueryStringParams:[NSString stringWithFormat:@"site_id=%@", siteId]]];
}

+ (void)reportAppStartToAdMobWithAppId:(NSString *)appId {
    [AdMobHelper reportAppStartToAdMobWithUrl:[AdMobHelper adMobUrlWithAdditionalQueryStringParams:[NSString stringWithFormat:@"app_id=%@", appId]]];
}

#pragma mark Private methods.
+ (NSString *)adMobUrlWithAdditionalQueryStringParams:(NSString *)queryStringParams {
    return [NSString stringWithFormat:@"http://a.admob.com/f0?isu=%@&%@", [[UIDevice currentDevice] uniqueIdentifier], queryStringParams];
}

+ (void)reportAppStartToAdMobWithUrl:(NSString *)url {
    if (![[AdMobHelper adMobAppOpenReportedFilePath] fileExists]) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        LOG(@"Reporting initial application start to AdMob on URL %@", [[request URL] absoluteString]);
        NSURLResponse *response;
        NSError *error;
        NSString *content = [NSString stringWithContentsOfURL:[request URL] encoding:NSUTF8StringEncoding error:&error];
        if (error == nil && [self statusCodeForResponse:response] == 200 && [content isNotEmpty]) {
            LOG(@"Successfully reported app open, response: %@", content);
            [[AdMobHelper adMobAppOpenReportedFilePath] touchFile];
        }
    } else {
        LOG(@"App has already been reported");      
    }
}

+ (NSInteger)statusCodeForResponse:(NSURLResponse *)response {
	return response != nil && [response isKindOfClass:[NSHTTPURLResponse class]] ? [((NSHTTPURLResponse *) response) statusCode] : 0;
}

@end
