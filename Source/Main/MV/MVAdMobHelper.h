#import <Foundation/Foundation.h>

@interface MVAdMobHelper : NSObject

+ (NSString *)adMobAppOpenReportedFilePath;
+ (void)reportAppStartToAdMobWithSiteId:(NSString *)siteId;
+ (void)reportAppStartToAdMobWithAppId:(NSString *)appId;

@end
