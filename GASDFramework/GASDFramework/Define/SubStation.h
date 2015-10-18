//
//  SubStation.h
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubStation : NSObject

@property (nonatomic, assign, readonly) SPPosition ssCD;
@property (nonatomic, assign, readonly) int num;

- (instancetype)initWithPosition:(SPPosition)position andNumber:(int)number;

@end
