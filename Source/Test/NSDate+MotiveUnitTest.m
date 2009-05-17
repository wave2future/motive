#import "GTMSenTestCase.h"
#import "NSDate+Motive.h"

@interface NSDateExtensionsUnitTest : GTMTestCase {
    NSDate *yesterday;
    NSDate *today;
    NSDate *tomorrow;
}    
@end

@implementation NSDateExtensionsUnitTest

- (void)setUp {
    yesterday = [NSDate dateWithTimeIntervalSinceNow:-60 * 60 * 24];
    today = [NSDate date];
    tomorrow = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24];
}

- (void)testYesterdayIsNotToday {
    STAssertFalse(yesterday.isToday, nil);
}

- (void)testTodayIsToday {
    STAssertTrue(today.isToday, nil);
}

- (void)testTomorrowIsNotToday {
    STAssertFalse(tomorrow.isToday, nil);
}

@end

