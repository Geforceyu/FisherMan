//
//  FSMNavigationTransition.m
//  fisherman
//
//  Created by Chonghua Yu on 2019/3/27.
//  Copyright © 2019 keruyun. All rights reserved.
//

#import "FSMNavigationTransition.h"

@implementation FSMNavigationTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    CGRect toViewFinalFrame = [transitionContext finalFrameForViewController:toVC];

    [toView setFrame:CGRectMake(0, CGRectGetHeight(toViewFinalFrame), CGRectGetWidth(toViewFinalFrame), CGRectGetHeight(toViewFinalFrame))];
    
    [[transitionContext containerView] addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         [toView setFrame:toViewFinalFrame];
                     }
                     completion:^(BOOL finished) {
                         if (![transitionContext transitionWasCancelled]) {
                             [fromView removeFromSuperview];
                             [transitionContext completeTransition:YES];
                         }
                         else {
                             [toView removeFromSuperview];
                             [transitionContext completeTransition:NO];
                         }
                     }];
}
@end
