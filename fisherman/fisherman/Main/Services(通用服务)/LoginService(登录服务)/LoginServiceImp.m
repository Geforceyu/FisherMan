//
//  LoginServiceImp.m
//  fisherman
//
//  Created by Chonghua Yu on 2018/11/8.
//  Copyright © 2018 keruyun. All rights reserved.
//

#import "LoginServiceImp.h"

@implementation LoginServiceImp
{
    NSString *_userName;
}
- (void)serviceStart
{
    NSLog(@"LoginService Start");
}
- (NSString *)loginUserName
{
    return _userName;
}
- (void)loginWithUserName:(NSString *)userName passwd:(NSString *)passwd
{
    _userName = userName;
}
@end
