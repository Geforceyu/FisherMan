//
//  LauncherModRootViewController.m
//  fisherman
//
//  Created by Chonghua Yu on 2018/11/8.
//  Copyright © 2018 keruyun. All rights reserved.
//

#import "LauncherModRootViewController.h"
#import "LoginService.h"
#import "FisherMan.h"

@interface LauncherModRootViewController ()

@end

@implementation LauncherModRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad]; 
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    loginButton.frame = CGRectMake(100, 100, 100, 100);
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
    [loginButton addTarget:self action:@selector(didClikedLoginButton) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)didClikedLoginButton
{
    //调用登录服务·
    id<LoginService> loginService = [[FisherMan man] findServiceWithName:@"LoginService"];
    [loginService loginWithUserName:@"xiaowang" passwd:@"123"];
    //启动订单模块
    [[FisherMan man] launchModuleWithName:@"TradeMod" parameters:nil transition:FMModTransitionTypePush];
}

@end
