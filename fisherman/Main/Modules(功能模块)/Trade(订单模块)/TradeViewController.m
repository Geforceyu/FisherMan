//
//  TradeViewController.m
//  fisherman
//
//  Created by Chonghua Yu on 2018/11/8.
//  Copyright © 2018 keruyun. All rights reserved.
//

#import "TradeViewController.h"
#import "LoginService.h"
#import "FisherMan.h"

@interface TradeViewController ()

@end

@implementation TradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    id<LoginService> loginService = [[FisherMan man] findServiceWithName:@"LoginService"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 300, 20)];
    label.text = [NSString stringWithFormat:@"当前登录用户名:%@",[loginService loginUserName]];
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    loginButton.frame = CGRectMake(100, 100, 100, 100);
    [loginButton setTitle:@"关闭" forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
    [loginButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)close
{
    [[FisherMan man] exitCurrentModule];
}


@end
