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
@interface Chromosome : NSObject <NSMutableCopying>

@property (nonatomic, retain) NSMutableArray *cpoints;

@property (nonatomic, assign) int numberOfActivated;

@property (nonatomic, assign) int numberOfAmbiguity;

@property (nonatomic, assign) float ratio;

@property (nonatomic, assign) float fitness;

- (instancetype)initWithPosition:(NSArray *)cpoints andNumberOfActivated:(int)numberOfActivated;

+ (int)getRandomNumberWithRange:(int)range;
+ (NSMutableArray *)getSeriesRanNumWith:(int)number andRange:(int)range;

+ (NSString *)readChromosomeStatus:(NSString *)chromosome;
+ (int)readChromosomeAmbiguity:(NSString *)chromosome;
+ (int)readChromosomeActivated:(NSString *)chromosome;
+ (float)readChromosomeFitness:(NSString *)chromosome;

@end


@interface Cpoint : NSObject <NSMutableCopying>

@property (nonatomic, retain) BaseStation *bs;
/**
 *  This is the activated status of the base station.
 */
@property (nonatomic, assign) BOOL status;

- (instancetype)initWithBS:(BaseStation *)baseStation;

@end
