//
//  TradeModAppDelegate.m
//  fisherman
//
//  Created by Chonghua Yu on 2018/11/8.
//  Copyright © 2018 keruyun. All rights reserved.
//

#import "TradeModDelegate.h"
#import "TradeModRootViewController.h"

@implementation TradeModDelegate
{
    TradeModRootViewController *_rootVC;
}
- (void)modDidFinishLaunchingWithOptions:(NSDictionary *)options
{
    NSLog(@"订单模块启动");

    _rootVC = [[TradeModRootViewController alloc] init];
}
- (UIViewController *)rootViewControllerForMod
{
    return _rootVC;
}
@end
