//
//  Chromosome.h
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Each chromosome point contains a basestation information and its status.
 */
@interface Chromosome : NSObject

@property (nonatomic, retain) NSArray *cpoints;

@property (nonatomic, assign) int numberOfActivated;

- (instancetype)initWithPosition:(NSArray *)cpoints andNumberOfActivated:(int)numberOfActivated;

+ (int)getRandomNumber;
+ (NSMutableArray *)getSeriesRanNumWith:(int)number;

@end


@interface Cpoint : NSObject

@property (nonatomic, retain, readonly) BaseStation *bs;
/**
 *  This is the activated status of the base station.
 */
@property (nonatomic, assign) BOOL status;

- (instancetype)initWithBS:(BaseStation *)baseStation;

@end
