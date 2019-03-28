//
//  FisherManContext.m
//  fisherman
//
//  Created by Chonghua Yu on 2019/3/27.
//  Copyright © 2019 keruyun. All rights reserved.
//

#import "FisherManContext.h"

@implementation FisherManContext

+ (instancetype)context
{
    static dispatch_once_t onceToken;
    static FisherManContext *fsmCon = nil;
    dispatch_once(&onceToken, ^{
        fsmCon = [[FisherManContext alloc] init];
    });
    return fsmCon;
}
@end
