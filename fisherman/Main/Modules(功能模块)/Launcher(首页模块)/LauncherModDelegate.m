//
//  LauncherModDelegate.m
//  fisherman
//
//  Created by Chonghua Yu on 2018/11/8.
//  Copyright © 2018 keruyun. All rights reserved.
//

#import "LauncherModDelegate.h"
#import "LauncherModRootViewController.h"

@implementation LauncherModDelegate
{
    LauncherModRootViewController *_rootVC;
}
//模块启动完成
- (void)modDidFinishLaunchingWithOptions:(NSDictionary *)options
{
    _rootVC = [[LauncherModRootViewController alloc] init];
}
//模块的根视图控制器
- (UIViewController *)rootViewControllerForMod
{
    return _rootVC;
}
//模块进入后台
- (void)modDidEnterBackground
{
    
}

@end
