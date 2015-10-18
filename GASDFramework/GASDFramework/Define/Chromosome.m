//
//  Chromosome.m
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import "Chromosome.h"

@implementation Chromosome

- (instancetype)initWithPosition:(NSArray *)cpoints {
    if (self) {
        _cpoints = cpoints;
    }
    return self;
}

@end


@implementation Cpoint

- (instancetype)initWithBS:(BaseStation *)baseStation {
    if(self) {
        _bs = baseStation;
        _status = NO;
    }
    return self;
}

@end