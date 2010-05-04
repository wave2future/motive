#import "UIView+Motive.h"

@implementation  UIView (MotiveExtensions)

- (void)centreWithinView:(UIView *)view {
    self.center = CGPointMake(view.center.x, self.bounds.size.height / 2);
}

- (void)moveToTopCentreOfView:(UIView *)view {
    self.center = CGPointMake(view.center.x, self.bounds.size.height / 2);
}

@end
