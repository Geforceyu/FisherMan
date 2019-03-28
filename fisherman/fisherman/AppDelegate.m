//
//  AppDelegate.m
//  fisherman
//
//  Created by Chonghua Yu on 2018/11/8.
//  Copyright © 2018 keruyun. All rights reserved.
//

#import "AppDelegate.h"
#import "FisherManContext.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [FisherManContext context].profileName = @"MyAppProfile";
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}
@end
