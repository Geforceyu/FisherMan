//
//  FMModAppDelegate.h
//  fisherman
//
//  Created by Chonghua Yu on 2018/11/8.
//  Copyright © 2018 keruyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//所有容器内的注册的模块必须遵循的协议

@protocol FSMModProtocol <NSObject>

@required
- (UIViewController *)rootViewControllerForMod;

@optional
- (void)modDidFinishLaunchingWithOptions:(NSDictionary *)options;
- (void)modDidEnterBackground;

@end
