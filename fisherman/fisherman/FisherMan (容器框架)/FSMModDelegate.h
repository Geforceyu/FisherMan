//
//  FMModAppDelegate.h
//  fisherman
//
//  Created by Chonghua Yu on 2018/11/8.
//  Copyright © 2018 keruyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol FSMModDelegate <NSObject>

@required
- (UIViewController *)rootViewControllerForMod;

- (void)modDidFinishLaunchingWithOptions:(NSDictionary *)options;
- (void)modDidEnterBackground;

@optional

@end
