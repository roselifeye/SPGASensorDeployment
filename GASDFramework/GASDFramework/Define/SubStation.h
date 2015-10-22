//
//  SubStation.h
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseStation.h"
#import "RSSIWeighted.h"

@interface SubStation : NSObject

@property (nonatomic, assign, readonly) SPPosition ssCD;
@property (nonatomic, assign, readonly) int num;

/**
 *  The element of the array is class CorrespoingBS;
 */
@property (nonatomic, retain, readonly) NSMutableArray *correspongBSs;

- (instancetype)initWithPosition:(SPPosition)position andNumber:(int)number andBS:(NSMutableArray *)BSs;

@end


@interface CorrespondingBS : NSObject

@property (nonatomic, retain, readonly) BaseStation *correspondingBS;
@property (nonatomic, assign, readonly) RSSI_WEIGHTED_LEVEL RSSIweight;

- (instancetype)initWithBS:(BaseStation *)subStation andWeight:(RSSI_WEIGHTED_LEVEL)weight;

@end