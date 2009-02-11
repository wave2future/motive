#import "AdMobHelper.h"
#import "NSString+File.h"
#import "MVHttp.h"

@interface AdMobHelper (AdMobHelperPrivate)
+ (NSString *)adMobUrlWithAdditionalQueryStringParams:(NSString *)queryStringParams;
+ (void)reportAppStartToAdMobWithUrl:(NSString *)url;
@end

@implementation AdMobHelper


+ (NSString *)adMobAppOpenReportedFilePath {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"admob_app_open"];
}

+ (void)reportAppStartToAdMobWithSiteId:(NSString *)siteId {
    [AdMobHelper reportAppStartToAdMobWithUrl:[AdMobHelper adMobUrlWithAdditionalQueryStringParams:[NSString stringWithFormat:@"site_id=", siteId]]];
}

+ (void)reportAppStartToAdMobWithAppId:(NSString *)appId {
    [AdMobHelper reportAppStartToAdMobWithUrl:[AdMobHelper adMobUrlWithAdditionalQueryStringParams:[NSString stringWithFormat:@"app_id=", appId]]];
}

#pragma mark Private methods.
+ (NSString *)adMobUrlWithAdditionalQueryStringParams:(NSString *)queryStringParams {
    return [NSString stringWithFormat:@"http://a.admob.com/f0?isu=%@&%@", [[UIDevice currentDevice] uniqueIdentifier], queryStringParams];
}

+ (void)reportAppStartToAdMobWithUrl:(NSString *)url {   
    NSString *appOpenPath = [AdMobHelper adMobAppOpenReportedFilePath];
    if (![appOpenPath fileExists]) {
        NSString *appOpenEndpoint = [NSString stringWithFormat:@"http://a.admob.com/f0?isu=%@&app_id=%@", [[UIDevice currentDevice] uniqueIdentifier], @"<APPLE ITUNES ID>"];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:appOpenEndpoint]];
        NSURLResponse *response;
        NSError *error;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if((!error) && ([(NSHTTPURLResponse *)response statusCode] == 200) && ([responseData length] > 0)) {
            [appOpenPath touchFile];
        }
    }
}

@end
