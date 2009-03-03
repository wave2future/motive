#import <Foundation/Foundation.h>

// TODO Add in F2, F3, etc.

@protocol F
- (id)apply:(id)arg;
@end

@interface MVSelectorF : NSObject <F> {
	SEL selector;
}

+ (MVSelectorF *)functionFromSelector:(SEL)s;
- (MVSelectorF *)initWithSelector:(SEL)s;

@end
