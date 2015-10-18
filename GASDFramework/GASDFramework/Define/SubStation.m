//
//  SubStation.m
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import "SubStation.h"

@implementation SubStation

- (instancetype)initWithPosition:(SPPosition)position andNumber:(int)number {
    if(self) {
        _ssCD = position;
        _num = number;
    }
    return self;
}

@end
