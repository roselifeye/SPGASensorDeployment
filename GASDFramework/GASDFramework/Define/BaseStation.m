//
//  BaseStation.m
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import "BaseStation.h"

@implementation BaseStation

- (instancetype)initWithPosition:(SPPosition)position {
    if(self) {
        _bsCD = position;
        _subSSs = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addSubStaions:(SubStation *)substation {
    RSSI_WEIGHTED_LEVEL weight = [RSSIWeighted weightCalculateWithBSCD:_bsCD andSSCD:substation.ssCD];
    if (weight != RSSI_WEIGHTED_NONE) {
        BSCorresponding *correspondingSS = [[BSCorresponding alloc] initWithSS:substation andWeight:weight];
        [_subSSs addObject:correspondingSS];
    }
}

@end


@implementation BSCorresponding

- (instancetype)initWithSS:(SubStation *)subStation andWeight:(RSSI_WEIGHTED_LEVEL)weight {
    if(self) {
        _correspondingSS = subStation;
        _RSSIweight = weight;
    }
    return self;
}

@end
