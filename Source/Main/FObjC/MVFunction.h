#import <Foundation/Foundation.h>

@protocol F
- (id)apply:(id)arg;
@end

@interface MVSelectorF : NSObject <F> {
	SEL selector;
}

+ (MVSelectorF *)functionFromSelector:(SEL)s;
- (MVSelectorF *)initWithSelector:(SEL)s;
@end
