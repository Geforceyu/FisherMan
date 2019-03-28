//
//  LoginService.h
//  fisherman
//
//  Created by Chonghua Yu on 2018/11/8.
//  Copyright © 2018 keruyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSMService.h"

@protocol LoginService <FSMService>

- (void)loginWithUserName:(NSString *)userName passwd:(NSString *)passwd;

- (NSString *)loginUserName;

@end

