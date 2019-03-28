//
//  FSMNavigationController.m
//  fisherman
//
//  Created by Chonghua Yu on 2019/3/27.
//  Copyright © 2019 keruyun. All rights reserved.
//

#import "FSMNavigationController.h"
#import "FSMNavigationDelegate.h"

@interface FSMNavigationController ()

@end

@implementation FSMNavigationController
{
    FSMNavigationDelegate *_fsdelegate;
}
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        _fsdelegate = [[FSMNavigationDelegate alloc] init];
        
        self.delegate = _fsdelegate;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)pushViewController:(UIViewController *)viewController type:(NSString *)type
{
    if (![type isEqualToString:@"push"])
    _fsdelegate.isPush = NO;
    [super pushViewController:viewController animated:YES];

}
@end
