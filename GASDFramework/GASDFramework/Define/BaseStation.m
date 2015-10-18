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
    BSCorresponding *correspondingSS = [[BSCorresponding alloc] initWithSS:substation andWeight:[RSSIWeighted weightCalculateWithBSCD:_bsCD andSSCD:substation.ssCD]];
    [_subSSs addObject:correspondingSS];
}

@end


@implementation BSCorresponding

- (instancetype)initWithSS:(SubStation *)subStation andWeight:(int)weight {
    if(self) {
        _correspondingSS = subStation;
        _RSSIweight = weight;
    }
    return self;
}

@end
