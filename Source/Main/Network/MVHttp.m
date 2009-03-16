#import "MVHttp.h"
#import "MVLog.h"

@implementation NSDataToNSString
- (id):(NSData *)arg {
	assert([arg isKindOfClass:[NSData class]]);
	return [[[NSString alloc] initWithData:arg encoding:NSUTF8StringEncoding] autorelease];
}
@end

@implementation NSDataToUIImage
- (id):(NSData *)arg {
	assert([arg isKindOfClass:[NSData class]]);	
	return [UIImage imageWithData:arg];
}
@end

@interface MVHttp (privvy)
+ (NSData *)sendSynchronousRequest:(NSURLRequest*)request returningResponse:(NSURLResponse **)response error:(NSError **)error;
@end

@implementation MVHttp

static NSTimeInterval MVRequestTimeoutInterval = 60.0;
static NSInteger MVDefaultStatusCode = 0;

+ (NSURLRequest *)requestWithUrl:(NSURL *)url {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [request setTimeoutInterval:MVRequestTimeoutInterval];
    [request setHTTPShouldHandleCookies:YES];
    return request;
}

+ (NSURLRequest *)postRequestWithUrl:(NSURL *)url payload:(NSString *)payload mimeType:(NSString *)mimeType {
    NSData *postData = [payload dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = (NSMutableURLRequest *) [self requestWithUrl:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%d", [postData length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:mimeType forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    return request;
}

+ (NSInteger)statusCodeForResponse:(NSURLResponse *)response {
	return response != nil && [response isKindOfClass:[NSHTTPURLResponse class]] ? [((NSHTTPURLResponse *) response) statusCode] : MVDefaultStatusCode;
}

+ (NSString *)stringForStatusCodeForResponse:(NSURLResponse *)response {
    return [NSHTTPURLResponse localizedStringForStatusCode:[self statusCodeForResponse:response]];
}

+ (MVEither *)sendSynchronousRequest:(NSURLRequest *)request {
	return [self sendSynchronousRequest:request withDataMapper:[[[NSDataToNSString alloc] init] autorelease]];
}

+ (MVEither *)sendSynchronousRequest:(NSURLRequest *)request withDataMapper:(id <MVDataMapper>)dataMapper {
    NSURLResponse *response;
    NSError *error;
    NSData *content = [MVHttp sendSynchronousRequest:request returningResponse:&response error:&error];
	if (error == nil && [MVHttp statusCodeForResponse:response] == MVHttpOkStatusCode) {
        LOG(@"Request succeeded, raw response content: %@", content);
        return [MVEither rightWithValue:[dataMapper :content]];
    } else {
        LOG(@"Request failed with: '%d - %@', error: %@, raw response content: %@",
            [MVHttp statusCodeForResponse:response], [MVHttp stringForStatusCodeForResponse:response], [error localizedDescription], content);
        return [MVEither leftWithValue:error];
    }
}

+ (NSData *)sendSynchronousRequest:(NSURLRequest*)request returningResponse:(NSURLResponse **)response error:(NSError **)error {
    return [NSURLConnection sendSynchronousRequest:request returningResponse:response error:error];
}

// TODO This is just a  map . intersperse or maybe a foldL, pull it into a category on NSDictionary.
+ (NSString *)queryStringFromDictionary:(NSDictionary *)dictionary {
    NSMutableString *queryString = [NSMutableString stringWithCapacity:1];
    NSArray *keys = [dictionary allKeys];
    for (int i = 0; i < [keys count]; i++) {
        if (i != 0) [queryString appendString:@"&"];
        NSString *encodedKey = [[[keys objectAtIndex:i] description] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        NSString *encodedValue = [[[dictionary objectForKey:[keys objectAtIndex:i]] description] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        [queryString appendString:[NSString stringWithFormat:@"%@=%@", encodedKey, encodedValue]];
    }
    return queryString;    
}

@end
