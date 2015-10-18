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

@end


@implementation BSCorrespoing

- (SubStation *)correspondingSS {
    
    return _correspondingSS;
}

@end
