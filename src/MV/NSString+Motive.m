#import "NSString+Motive.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MotiveExtension)

static NSUInteger MVChunkSize = 1024;

+ (NSString *)stringWithData:(NSData *)data {
    return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
}

- (BOOL)isEmpty {
    return [self length] == 0;
}

- (BOOL)isNotEmpty {
    return !self.isEmpty;
}

- (BOOL)contains:(NSString *)other {
    return [self rangeOfString:other].length > 0;
}

- (NSData *)asData {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)trimNewLines {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)md5 {
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    const char *cStr = [self UTF8String];
    CC_MD5(cStr, strlen(cStr), digest);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            digest[0], digest[1], digest[2], digest[3], digest[4], digest[5], digest[6], digest[7],
            digest[8], digest[9], digest[10], digest[11], digest[12], digest[13], digest[14], digest[15]];
}

- (BOOL)touchFileAtPath {
    return [[NSFileManager defaultManager] createFileAtPath:self contents:nil attributes:nil];
}

- (BOOL)fileExistsAtPath {
    return [[NSFileManager defaultManager] fileExistsAtPath:self];
}

- (BOOL)caseInsensitiveFileExistsAtPath {

  NSError *error = nil;
  NSString *path = [self stringByDeletingLastPathComponent];
  
  if(![path fileExistsAtPath]) {
    // Path doesn't exist yet
    return NO;
  }
  
  NSArray *list = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
  
  if(error) {
    // Couldn't get a directory listing for some reason
    NSLog(@"NSString+Motive:caseInsensitiveFileExistsAtPath - %@, %@", path, [error localizedDescription]);
    return NO;
  }
  
  for(NSString *item in list) {
    if([[self lastPathComponent] caseInsensitiveCompare:item] == NSOrderedSame) {
      // Found it!
      return YES;
    }
  }
  
  // Couldn't find the file
  return NO;
}

- (NSNumber *)fileSizeAtPath {
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:self error:NULL];
    if (fileAttributes == nil) {
        return [NSNumber numberWithInt:-1];
    } else {
        NSNumber *fileSize = [fileAttributes objectForKey:NSFileSize];
        return fileSize == nil ? [NSNumber numberWithInt:-1] : fileSize;
    }
}

- (NSString *)md5ForFileAtPath {
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:self];
	if (handle == nil) {
        return nil;
    } else {
        CC_MD5_CTX md5;        
        CC_MD5_Init(&md5);
        
        BOOL done = NO;
        while (!done) {
            NSAutoreleasePool *p = [[NSAutoreleasePool alloc] init];
            NSData* fileData = [handle readDataOfLength:MVChunkSize];
            CC_MD5_Update(&md5, [fileData bytes], [fileData length]);
            if ([fileData length] == 0) done = YES;
            [p release];
        }
        
        unsigned char digest[CC_MD5_DIGEST_LENGTH];
        CC_MD5_Final(digest, &md5);
        return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                digest[0], digest[1], digest[2], digest[3], digest[4], digest[5], digest[6], digest[7], 
                digest[8], digest[9], digest[10], digest[11], digest[12], digest[13], digest[14], digest[15]];    
    }
}

@end
