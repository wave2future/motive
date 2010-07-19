#import "UITableView+Motive.h"


@implementation UITableView (Motive)

- (void)reloadDataOnMainThread {
    [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

@end
