//
//  IndividualsPool.m
//  GASDFramework
//
//  Created by sy2036 on 2015-10-26.
//  Copyright © 2015 roselifeye. All rights reserved.
//

#import "IndividualsPool.h"
#import "Chromosome.h"
#import "UtilityFunc.h"
#import "SPPlistManager.h"

@implementation IndividualsPool

#pragma mark -
#pragma mark - This is new test function for initializing individuals via string instead of NSObject
+ (NSMutableArray *)InitialPoolWithBSs:(NSMutableArray *)BSs andSSs:(NSMutableArray *)SSs {
    NSMutableArray *originalPool = [[NSMutableArray alloc] init];
    for (int i = 0; i < NumberOfIndividualsInPool; i++) {
        NSString *chro = [self CreateNewParentWithBSs:BSs andSSs:SSs];
        [originalPool addObject:chro];
    }
    [SPPlistManager StoreNewPool:originalPool];
    return originalPool;
}

+ (NSString *)CreateNewParentWithBSs:(NSMutableArray *)BSs andSSs:(NSMutableArray *)SSs {
    NSMutableArray *statusArray = [Chromosome getSeriesRanNumWith:[Chromosome getRandomNumberWithRange:NumberOfPotentialBS] andRange:NumberOfPotentialBS];
    int numberOfActivated = 0;
    NSString *chroStr = @"";
    for (int i = 0; i < BSs.count; i++) {
        BOOL status = NO;
        for (NSNumber *index in statusArray) {
            if (i == [index intValue]) {
                status = YES;
                numberOfActivated += 1;
                break;
            }
        }
        chroStr = [chroStr stringByAppendingFormat:@"%d", status];
    }
    chroStr = [UtilityFunc fitnessFuncWithSS:SSs andChromosome:chroStr andRecognitionRatio:OriginalAlpha];

    return chroStr;
}

@end
