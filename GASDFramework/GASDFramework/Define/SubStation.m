//
//  SubStation.m
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import "SubStation.h"

@implementation SubStation

- (instancetype)initWithPosition:(SPPosition)position andNumber:(int)number andBS:(NSMutableArray *)BSs {
    if(self) {
        _ssCD = position;
        _num = number;
        _correspongBSs = [[NSMutableArray alloc] init];
        for (BaseStation *bs in BSs) {
            RSSI_WEIGHTED_LEVEL weight = [RSSIWeighted weightCalculateWithBSCD:bs.bsCD andSSCD:position];
            CorrespondingBS *cBS = [[CorrespondingBS alloc] initWithBS:bs andWeight:weight];
            [_correspongBSs addObject:cBS];
        }
    }
    return self;
}

@end

@implementation CorrespondingBS

- (instancetype)initWithBS:(BaseStation *)subStation andWeight:(RSSI_WEIGHTED_LEVEL)weight {
    if(self) {
        _correspondingBS = subStation;
        _RSSIweight = weight;
    }
    return self;
}

@end
