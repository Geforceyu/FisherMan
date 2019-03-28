//
//  FMService.h
//  fisherman
//
//  Created by Chonghua Yu on 2018/11/8.
//  Copyright © 2018 keruyun. All rights reserved.
//

#import <Foundation/Foundation.h>

//容器内所有注册的服务遵循的根协议
@protocol FSMServiceProtocol <NSObject>

@optional

- (void)serviceStart;

@end

