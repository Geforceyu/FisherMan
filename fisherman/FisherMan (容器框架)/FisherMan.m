//
//  FiserMan.m
//  fisherman
//
//  Created by Chonghua Yu on 2018/11/8.
//  Copyright © 2018 keruyun. All rights reserved.
//

#import "FisherMan.h"
#import "FisherManContext.h"
#import "FSMNavigationController.h"

@interface FisherMan ()

@property (nonatomic,strong)UIViewController *appRootViewController;

@end

@implementation FisherMan
{
    NSDictionary *_map;
    NSArray *_registerModules;
    NSArray *_registerServices;
    NSMutableArray *_runingModules;
    NSMutableArray *_runingServices;
    FMModTransitionType _lastTransitionType;
    FSMNavigationController *_rootVC;
}

+ (instancetype)man
{
    static dispatch_once_t onceToken;
    static FisherMan *man = nil;
    dispatch_once(&onceToken, ^{
        man = [[FisherMan alloc] init];
    });
    return man;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _runingModules = [NSMutableArray array];
        _runingServices = [NSMutableArray array];
        
        _map = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[FisherManContext context].profileName ofType:@"plist"]];
        _registerModules = _map[@"Modules"];
        _registerServices = _map[@"Services"];

        //启动注册的服务
        for (NSDictionary *service in _registerServices) {
            Class class = NSClassFromString(service[@"imp"]);
            id<FSMService> service = [class new];
            [_runingServices addObject:service];
            [service serviceStart];
        }
    }
    return self;
}
- (UIViewController *)appRootViewController
{
    //将注册的第一个模块的根视图控制器作为app的根视图控制器
    Class class = NSClassFromString(_registerModules.firstObject[@"delegate"]);
    id<FSMModDelegate> module = [[class alloc] init];
    [module modDidFinishLaunchingWithOptions:nil];
    [_runingModules addObject:module];
    UIViewController *firstModVC = [module rootViewControllerForMod];
    _rootVC = [[FSMNavigationController alloc] initWithRootViewController:firstModVC];
    return _rootVC;
}

- (void)launchModuleWithName:(NSString *)moduleName parameters:(NSDictionary *)parameters transition:(FMModTransitionType)transitionType
{
    for (NSDictionary *registerMod in _registerModules) {
        //遍历判断已注册的模块名
        if ([registerMod[@"name"] isEqualToString:moduleName]) {
            //创建启动模块对象
            Class class = NSClassFromString(registerMod[@"delegate"]);
            id<FSMModDelegate> mod = [[class alloc] init];
            [mod modDidFinishLaunchingWithOptions:parameters];

            //获取启动模块的根视图控制器
            UIViewController *modRootVC = [mod rootViewControllerForMod];
            
            if (transitionType==FMModTransitionTypePush) {
                [_rootVC pushViewController:modRootVC animated:YES];
            }else {
                [_rootVC pushViewController:modRootVC type:@"modal"];
            }
            _lastTransitionType = transitionType;
            break;
        }
    }
}
- (void)exitCurrentModule
{
    UIViewController *presentViewController = [self getCurrentTopViewController];
    if (_lastTransitionType==FMModTransitionTypePush) {
        if ([presentViewController isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController*)presentViewController popViewControllerAnimated:YES];
        }else{
            NSAssert(0, @"当前控制器不在导航控制器栈中");
        }
    }else{
        [presentViewController dismissViewControllerAnimated:YES completion:nil];
    }
}
- (UIViewController *)getCurrentTopViewController
{
    id<FSMModDelegate> firstMod = _runingModules.firstObject;
    
    UIViewController *presentViewController = [firstMod rootViewControllerForMod];
    while (presentViewController.presentedViewController) {
        presentViewController = presentViewController.presentedViewController;
    }
    return presentViewController;
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    for (id<FSMModDelegate> mod in _runingModules) {
        [mod modDidEnterBackground];
    }
}
- (id)findServiceWithName:(NSString *)serviceName
{
    for (id<FSMService> service in _runingServices) {
        if ([NSStringFromClass([service class]) isEqualToString:serviceName]) {
            return service;
        }
    }
    return nil;
}
@end
