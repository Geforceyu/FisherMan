//
//  FSMNavigationController.h
//  fisherman
//
//  Created by Chonghua Yu on 2019/3/27.
//  Copyright © 2019 keruyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSMNavigationController : UINavigationController

- (void)pushViewController:(UIViewController *)viewController type:(NSString *)type;

@end
