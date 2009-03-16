#import <Foundation/Foundation.h>
#import "MVEither.h"

// Status codes
#define MVHttpOkStatusCode   200

// Mime Types
#define MVXWwwFormUrlEncodedMimeType    @"application/x-www-form-urlencoded"
#define MVJsonMimeType                  @"application/application/json"

@protocol MVDataMapper <FKFunction>
- (id):(NSData *)arg;
@end

@interface NSDataToNSString : NSObject <MVDataMapper> 
@end

@interface NSDataToUIImage : NSObject <MVDataMapper> 
@end

@interface MVHttp : NSObject

+ (NSURLRequest *)requestWithUrl:(NSURL *)url;

+ (NSURLRequest *)postRequestWithUrl:(NSURL *)url payload:(NSString *)payload mimeType:(NSString *)mimeType;

+ (NSInteger)statusCodeForResponse:(NSURLResponse *)response;
+ (NSString *)stringForStatusCodeForResponse:(NSURLResponse *)response;

// Returns an MVEither with an NSError on the left or NSString with response content on the right.
+ (MVEither *)sendSynchronousRequest:(NSURLRequest *)request;
+ (MVEither *)sendSynchronousRequest:(NSURLRequest *)request withDataMapper:(id <MVDataMapper>)dataMapper;

+ (NSString *)queryStringFromDictionary:(NSDictionary *)dictionary;

@end
