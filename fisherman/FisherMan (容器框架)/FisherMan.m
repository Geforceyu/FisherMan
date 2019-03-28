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
            id<FSMServiceProtocol> service = [class new];
            [_runingServices addObject:service];
            [service serviceStart];
        }
    }
    return self;
}
//将注册的第一个模块的根视图控制器作为app的根视图控制器
- (UIViewController *)appRootViewController
{
    Class class = NSClassFromString(_registerModules.firstObject[@"delegate"]);
    id<FSMModProtocol> module = [[class alloc] init];
    [module modDidFinishLaunchingWithOptions:nil];
    [_runingModules addObject:module];
    UIViewController *firstModVC = [module rootViewControllerForMod];
    _rootVC = [[FSMNavigationController alloc] initWithRootViewController:firstModVC];
    return _rootVC;
}
//启动某个已注册的模块
- (void)launchModuleWithName:(NSString *)moduleName parameters:(NSDictionary *)parameters transition:(FMModTransitionType)transitionType
{
    for (NSDictionary *registerMod in _registerModules) {
        //遍历判断已注册的模块名
        if ([registerMod[@"name"] isEqualToString:moduleName]) {
            //创建启动模块对象
            Class class = NSClassFromString(registerMod[@"delegate"]);
            id<FSMModProtocol> mod = [[class alloc] init];
            if (![mod conformsToProtocol:@protocol(FSMModProtocol)]) {
                NSLog(@"模块[%@]必须遵守FSMModProtocol协议",moduleName);
                return;
            }
            [mod modDidFinishLaunchingWithOptions:parameters];
            [_runingModules addObject:mod];
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
//退出当前模块
- (void)exitCurrentModule
{
    if (_lastTransitionType==FMModTransitionTypePush) {
        [_rootVC popViewControllerAnimated:YES];
    }else{
        [_rootVC popViewControllerAnimated:YES];
    }
}
//查找服务
- (id)findServiceWithName:(NSString *)serviceName
{
    BOOL registed = NO;
    NSString *serviceImpName = nil;
    for (NSDictionary *serviceDict in _registerServices) {
        if ([serviceDict[@"name"] isEqualToString:serviceName]) {
            registed = YES;
            serviceImpName = serviceDict[@"imp"];
            break;
        }
    }
    if (!registed) {
        NSLog(@"查找的服务未注册!");
        return nil;
    }
    if (!serviceImpName) {
        NSLog(@"服务未设置服务者!");
        return nil;
    }
    for (id<FSMServiceProtocol> service in _runingServices) {
        if (![service conformsToProtocol:@protocol(FSMServiceProtocol)]) {
            NSLog(@"服务[%@]必须遵守FSMServiceProtocol协议",serviceName);
            return nil;
        }
        if ([NSStringFromClass([service class]) isEqualToString:serviceImpName]) {
            return service;
        }
    }
    NSLog(@"服务未启动!");
    return nil;
}
#pragma mark -Appdelegate
//将app事件分发到各个运行中的模块

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    for (id<FSMModProtocol> mod in _runingModules) {
        [mod modDidEnterBackground];
    }
}
@end
