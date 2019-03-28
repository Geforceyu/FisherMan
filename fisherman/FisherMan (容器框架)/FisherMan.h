//
//  FiserMan.h
//  fisherman
//
//  Created by Chonghua Yu on 2018/11/8.
//  Copyright © 2018 keruyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSMModDelegate.h"
#import "FSMService.h"

typedef enum : NSUInteger {
    FMModTransitionTypeNone,
    FMModTransitionTypePush,
    FMModTransitionTypePresent,
} FMModTransitionType;

@interface FisherMan : NSObject

@property (nonatomic,strong,readonly)UIViewController *appRootViewController;

+ (instancetype)man;

- (void)launchModuleWithName:(NSString *)moduleName parameters:(NSDictionary *)parameters transition:(FMModTransitionType)transitionType;

- (void)exitCurrentModule;

- (id)findServiceWithName:(NSString *)serviceName;

- (void)applicationDidEnterBackground:(UIApplication *)application;

@end

