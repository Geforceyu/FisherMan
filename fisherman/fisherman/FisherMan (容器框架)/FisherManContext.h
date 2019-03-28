//
//  FisherManContext.h
//  fisherman
//
//  Created by Chonghua Yu on 2019/3/27.
//  Copyright © 2019 keruyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FisherManContext : NSObject

@property (nonatomic, strong) NSString *profileName;

+ (instancetype)context;

@end
