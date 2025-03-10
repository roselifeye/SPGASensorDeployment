//
//  UtilityFunc.m
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import "UtilityFunc.h"

@implementation UtilityFunc

#pragma mark - 
#pragma mark - This is the test function for new Chromosome Format.
+ (NSString *)fitnessFuncWithSS:(NSMutableArray *)SSs andChromosome:(NSString *)chromosome andRecognitionRatio:(float)ratio {
    chromosome = [UtilityFunc numberOfAmbiguityAndActivatedBSWithSS:SSs andChromosome:chromosome andRecognitionRatio:ratio];
    return chromosome;
}

+ (NSString *)numberOfAmbiguityAndActivatedBSWithSS:(NSMutableArray *)SSs andChromosome:(NSString *)chromosome andRecognitionRatio:(float)ratio{
    int numOfActivatedBS = 0;
    int numOfAmbiguity = 0;
    NSString *status = [Chromosome readChromosomeStatus:chromosome];
    /**
     *  This is the SS weight array, every SS will get their own rate, and store in this array.
     *  Particularly, if the SS is not coverd by all base station, the totalWeight will be 0.
     *
     *  The reason using NSMutableSet here is avoiding to add duplicated element into the array.
     *  We think that if the totalWeight is equal, thus, the two SSs cannnot be distinguish.
     */
    @autoreleasepool {
        //  Calculate the Activated BS.
        NSMutableArray *activatedIndexes = [[NSMutableArray alloc] init];
        for (int i = 0; i < NumberOfPotentialBS; i++) {
            //  If Point Status is Yes, which means this point is activated, and will dominat in chromosome, the system will add its weight.
            if ([[status substringWithRange:NSMakeRange(i, 1)] boolValue]) {
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
    }
    float fitness = (1-ratio) * (float)numOfActivatedBS/NumberOfPotentialBS + ratio * (float)numOfAmbiguity/19900;
    chromosome = [status stringByAppendingString:@","];
    chromosome = [chromosome stringByAppendingFormat:@"%d", numOfActivatedBS];
    chromosome = [chromosome stringByAppendingString:@","];
    chromosome = [chromosome stringByAppendingFormat:@"%d", numOfAmbiguity];
    chromosome = [chromosome stringByAppendingString:@","];
    chromosome = [chromosome stringByAppendingFormat:@"%f", fitness];

    return chromosome;
}

@end
