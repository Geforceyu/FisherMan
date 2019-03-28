//
//  FSMTransition.m
//  fisherman
//
//  Created by Chonghua Yu on 2019/3/27.
//  Copyright © 2019 keruyun. All rights reserved.
//

#import "FSMNavigationDelegate.h"
#import "FSMNavigationTransition.h"

@implementation FSMNavigationDelegate
{
    FSMNavigationTransition *_transition;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _transition = [[FSMNavigationTransition alloc] init];
    }
    return self;
}
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (_isPush) {
        return nil;
    }
    return _transition;
}
@end

