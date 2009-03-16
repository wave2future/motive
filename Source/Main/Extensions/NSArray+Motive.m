#import "NSArray+Motive.h"

// TODO - Add stuff like these
//@interface NSArray (FK)
//- (NSArray *)map:(id <FKFunction>)f;
//- (NSArray *)zip:(NSArray *)other;
//@end
//
//@implementation NSArray (FK)
//- (NSArray *)map:(id <FKFunction>)f {
//	NSMutableArray *r = [NSMutableArray arrayWithCapacity:[self count]];
//	for (id o in self) {
//		[r addObject:[f :o]];
//	}
//	return [NSArray arrayWithArray:r];
//}
//- (NSArray *)zip:(NSArray *)other {
//	assert([other count] == [self count]);
//	NSMutableArray *r = [NSMutableArray arrayWithCapacity:[self count]];
//	for (int i = 0; i < [self count]; ++i) {
//		[r addObject:[MVP2 p2With_1:[self objectAtIndex:i] _2:[other objectAtIndex:i]]];
//	}
//	return [NSArray arrayWithArray:r];
//}
//@end


@implementation NSArray (MotiveExtensions)

- (BOOL)isEmpty {
    return [self count] == 0;
}

- (BOOL)isNotEmpty {
    return !self.isEmpty;
}

- (BOOL)all:(SEL)predicate {
	for (id object in self) {
		if (![object performSelector:predicate]) {
			return NO;
		}
	}
	return YES;
}

@end
