#import "GTMSenTestCase.h"
#import "FKFunction.h"
#import "FKEffect.h"
#import "MVLog.h"
#import "MVNewtype.h"

NEWTYPE(Age, NSString);
NEWTYPE(Name, NSString);
NEWTYPE2(Person, Age, Name);

@interface TestEffect : NSObject <FKEffect> {
	id arg;
}
- (id)arg;
@end
@implementation TestEffect
- (oneway void)e:(id)effectArg {
	arg = effectArg;
}
- (id)arg {
	return arg;
}
@end

@interface MVFunctionUnitTest : GTMTestCase {
    NSObject *object;
}
@end

@implementation MVFunctionUnitTest

- (void)setUp {
	object = [[[NSObject alloc] init] autorelease];
}

- (void)testSelectorFuncAppliesSelector {
	NSString *d = [object description];
	id <FKFunction> f = [FKFunction functionFromSelector:@selector(description)];
	NSString *result = [f :object];
	STAssertEqualObjects(d, result, nil);
	
	Age *age = [Age value:@"54"];
	Name *name = [Name value:@"Nick"];
	Person *nick = [Person value:age :name];
	NSLog([nick description]);
	NSLog([[nick _1] description]);
	NSLog([[nick _2] description]);
}

- (void)testEffectComapping {
	TestEffect *e = [[[TestEffect alloc] init] autorelease];
	id <FKFunction> f = [FKFunction functionFromSelector:@selector(description)];
	id <FKEffect> comapped = [FKEffect comap:e:f];
	[comapped e:object];	
	STAssertEqualObjects([object description], [e arg], nil);
}

- (void)testSelectorWithTarget {
	id <FKFunction> f = [FKFunction functionFromSelector:@selector(arrayByAddingObject:) target:[NSArray array]];
	STAssertEqualObjects([f :@"yep"], NSARRAY(@"yep"), nil);
}

- (void)testFunctionFailsIfTargetDoesntRespondToSelector {
	@try {
		[FKFunction functionFromSelector:@selector(arrayByAddingObject:) target:@"wat"];		
	}
	@catch (NSException * e) {
		STAssertEqualObjects([e name], @"InvalidOperation", nil);
	}
	@finally {
		
	}

}
@end
