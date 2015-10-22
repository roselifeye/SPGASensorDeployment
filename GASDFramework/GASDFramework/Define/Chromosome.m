//
//  Chromosome.m
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import "Chromosome.h"
#import "UtilityFunc.h"

@implementation Chromosome

- (instancetype)initWithPosition:(NSMutableArray *)cpoints andNumberOfActivated:(int)numberOfActivated {
    if (self) {
        _cpoints = cpoints;
        _numberOfActivated = numberOfActivated;
    }
    return self;
}

+ (int)getRandomNumber {
    /**
     *  Seed the random-number generator with current time
     *  so that the numbers will be different every time we run.
     */
    int randNum = rand()%NumberOfBSPool + 1;;
    return randNum;
}

+ (NSMutableArray *)getSeriesRanNumWith:(int)number {
    NSMutableArray *seriesRN = [[NSMutableArray alloc] init];
    srand((unsigned)time(NULL));
    for (int i = 0; i < number; i++) {
        [seriesRN addObject:[NSNumber numberWithInt:[Chromosome getRandomNumber]]];
    }
    return seriesRN;
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