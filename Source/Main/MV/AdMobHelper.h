#import <Foundation/Foundation.h>

@interface AdMobHelper : NSObject

+ (NSString *)adMobAppOpenReportedFilePath;
+ (void)reportAppStartToAdMobWithSiteId:(NSString *)siteId;
+ (void)reportAppStartToAdMobWithAppId:(NSString *)appId;

@end
