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
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    //encode properties/values
    NSData *absCD = [NSData dataWithBytes:&_bsCD length:sizeof(_bsCD)];
    [aCoder encodeObject:absCD forKey:@"bsCD"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if((self = [super init])) {
        //decode properties/values
        NSData *absCD = [aDecoder decodeObjectForKey:@"bsCD"];
        [absCD getBytes:&_bsCD length:sizeof(_bsCD)];
    }
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    BaseStation *bs = [BaseStation allocWithZone:zone];
    bs->_bsCD = _bsCD;
    return bs;
}

@end

