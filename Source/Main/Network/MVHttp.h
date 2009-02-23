#import <Foundation/Foundation.h>
#import "MVEither.h"

// Status codes
#define MVHttpOkStatusCode   200

// Mime Types
#define MVXWwwFormUrlEncodedMimeType    @"application/x-www-form-urlencoded"
#define MVJsonMimeType                  @"application/application/json"


@interface MVHttp : NSObject

+ (NSURLRequest *)requestWithUrl:(NSURL *)url;

+ (NSURLRequest *)postRequestWithUrl:(NSURL *)url payload:(NSString *)payload mimeType:(NSString *)mimeType;

+ (NSInteger)statusCodeForResponse:(NSURLResponse *)response;
+ (NSString *)stringForStatusCodeForResponse:(NSURLResponse *)response;

// Returns an MVEither with an NSError on the left or NSString with response content on the right.
+ (MVEither *)sendSynchronousRequest:(NSURLRequest *)request;
+ (NSString *)sendSynchronousRequest:(NSURLRequest*)request returningResponse:(NSURLResponse **)response error:(NSError **)error;

+ (NSString *)queryStringFromDictionary:(NSDictionary *)dictionary;

@end
