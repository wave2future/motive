#import "MVHttp.h"
#import "MVLog.h"
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
    NSURLResponse *response;
    NSError *error;
    NSString *content = [MVHttp sendSynchronousRequest:request returningResponse:&response error:&error];
	if (error == nil && [MVHttp statusCodeForResponse:response] == MVHttpOkStatusCode) {
        LOG(@"Request succeeded, raw response content: %@", content);
        return [MVEither rightWithValue:content];
    } else {
        LOG(@"Request failed with: '%d - %@', error: %@, raw response content: %@",
            [MVHttp statusCodeForResponse:response], [MVHttp stringForStatusCodeForResponse:response], [error localizedDescription], content);
        return [MVEither leftWithValue:error];
    }    
}

+ (NSString *)sendSynchronousRequest:(NSURLRequest*)request returningResponse:(NSURLResponse **)response error:(NSError **)error {
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:response error:error];
    return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
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
