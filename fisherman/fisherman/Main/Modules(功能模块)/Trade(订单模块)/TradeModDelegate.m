//
//  TradeModAppDelegate.m
//  fisherman
//
//  Created by Chonghua Yu on 2018/11/8.
//  Copyright © 2018 keruyun. All rights reserved.
//

#import "TradeModDelegate.h"
#import "TradeViewController.h"

@implementation TradeModDelegate

- (UIViewController *)rootViewControllerForMod
{
    return [[TradeViewController alloc] init];
}
- (void)modDidFinishLaunchingWithOptions:(NSDictionary *)options
{
    NSLog(@"订单模块启动");
}
@end
