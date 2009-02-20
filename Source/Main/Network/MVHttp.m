#import "MVHttp.h"

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
	return response != nil && [response respondsToSelector:@selector(statusCode)] ? [(NSHTTPURLResponse *)response statusCode] : MVDefaultStatusCode;
}

+ (NSString *)sendSynchronousRequest:(NSURLRequest*)request returningResponse:(NSURLResponse **)response error:(NSError **)error {
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:response error:error];
    return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
}

// TODO This is a foldL, pull it into a category on NSDictionary.
+ (NSString *)queryStringFromDictionary:(NSDictionary *)dictionary {    
    NSMutableString *queryString = [NSMutableString stringWithCapacity:1];
    NSArray *keys = [dictionary allKeys];
    for (int i = 0; i < [keys count]; i++) {
        if (i != 0) {
            [queryString appendString:@"&"];
        }
        id key = [keys objectAtIndex:i];
        [queryString appendString:[NSString stringWithFormat:@"%@=%@", key, [dictionary objectForKey:key]]];
    }
    
    
//    for (id key in [dictionary allKeys]) {
//        [queryString appendString:[NSString stringWithFormat:@"&%@=%@", key, [dictionary objectForKey:key]]];
//    }
    return queryString;    
}

@end
