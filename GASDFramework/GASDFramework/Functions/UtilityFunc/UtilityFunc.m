//
//  UtilityFunc.m
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import "UtilityFunc.h"

@implementation UtilityFunc

+ (void)fitnessFunctionWithSS:(NSMutableArray *)SSs andChromosome:(Chromosome *)chromosome andRecognitionRatio:(float)ratio {
    float fitness = .0f;
    NSMutableArray *numArray = [UtilityFunc numberOfRecognitionSSAndActivatedBSWithSS:SSs andChromosome:chromosome];
    int numOfActivatedBS = [[numArray objectAtIndex:0] intValue];
    int numOfAmbiguity = [[numArray objectAtIndex:1] intValue];
//    fitness = numOfActivatedBS + numOfAmbiguity*ratio;
    
    fitness = (1-ratio) * (float)numOfActivatedBS/NumberOfPotentialBS + ratio * (float)numOfAmbiguity/19900;
    
    chromosome.numberOfActivated = numOfActivatedBS;
    chromosome.numberOfAmbiguity = numOfAmbiguity;
    chromosome.ratio = ratio;
    chromosome.fitness = fitness;
}

+ (NSMutableArray *)numberOfRecognitionSSAndActivatedBSWithSS:(NSMutableArray *)SSs andChromosome:(Chromosome *)chromosome {
    
    int numOfActivatedBS = 0;
    NSMutableArray *numArray = [[NSMutableArray alloc] init];
    
    //  The following comment function causes more complexity, thus, I comment it.
    /**
     *  This is the SS weight array, every SS will get their own rate, and store in this array.
     *  Particularly, if the SS is not coverd by all base station, the totalWeight will be 0.
     *
     *  The reason using NSMutableSet here is avoiding to add duplicated element into the array.
     *  We think that if the totalWeight is equal, thus, the two SSs cannnot be distinguish.
     */
    
    int numOfAmbiguity = 0;
    
    //  Calculate the Activated BS.
    NSMutableArray *activatedIndexes = [[NSMutableArray alloc] init];
    for (int i = 0; i < chromosome.cpoints.count; i++) {
        Cpoint *point = [chromosome.cpoints objectAtIndex:i];
        //  If Point Status is Yes, which means this point is activated, and will dominat in chromosome, the system will add its weight.
        if (point.status) {
            numOfActivatedBS += 1;
            [activatedIndexes addObject:[NSNumber numberWithInt:i]];
        }
    }
    
    for (int i = 0; i < NumberOfSS-1; i++) {
        for (int j = i+1; j< NumberOfSS; j++) {
            SubStation *ss1 = [SSs objectAtIndex:i];
            SubStation *ss2 = [SSs objectAtIndex:j];
            int similiarity = 0;
            for (NSNumber *index in activatedIndexes) {
                CorrespondingBS *cBS1 = [ss1.correspongBSs objectAtIndex:[index intValue]];
                CorrespondingBS *cBS2 = [ss2.correspongBSs objectAtIndex:[index intValue]];
                if (cBS1.RSSIweight == cBS2.RSSIweight) {
                    similiarity += 1;
                }
            }
            if ([activatedIndexes count] == similiarity) {
                numOfAmbiguity += 1;
            }
        }
    }
    
    [numArray addObject:[NSNumber numberWithInt:numOfActivatedBS]];
    [numArray addObject:[NSNumber numberWithInt:numOfAmbiguity]];
    
    return numArray;
}

/*
- (int)calculateDuplicateWithArray:(NSMutableArray *)array {
    int duplicateNum = 0;
    
    [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 intValue] > [obj2 intValue];
    }];
    
    return duplicateNum;
}
 */

@end
