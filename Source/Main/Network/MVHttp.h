#import <Foundation/Foundation.h>

#define HTTP_OK   200

@interface MVHttp : NSObject

+ (NSURLRequest *)requestWithUrl:(NSURL *)url;

+ (NSURLRequest *)postRequestWithUrl:(NSURL *)url payload:(NSString *)payload mimeType:(NSString *)mimeType;

+ (NSInteger)statusCodeForResponse:(NSURLResponse *)response;
	
+ (NSString *)sendSynchronousRequest:(NSURLRequest*)request returningResponse:(NSURLResponse **)response error:(NSError **)error;

+ (NSString *)queryStringFromDictionary:(NSDictionary *)dictionary;

@end
