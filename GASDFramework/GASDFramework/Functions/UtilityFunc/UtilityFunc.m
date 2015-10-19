//
//  UtilityFunc.m
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import "UtilityFunc.h"

@implementation UtilityFunc

+ (float)fitnessFunctionWithChromosome:(Chromosome *)chromosome andRecognitionRatio:(float)ratio {
    float fitness = .0f;
    NSMutableArray *numArray = [UtilityFunc numberOfRecognitionSSAndActivatedBSWithChromosome:chromosome];
    int numOfActivatedBS = [[numArray objectAtIndex:0] intValue];
    int numberOfRecognitionSS = [[numArray objectAtIndex:1] intValue];
    fitness = numOfActivatedBS + numberOfRecognitionSS * ratio;
    
    return fitness;
}

+ (NSMutableArray *)numberOfRecognitionSSAndActivatedBSWithChromosome:(Chromosome *)chromosome {
    int numOfRecognition = 0;
    int numOfActivatedBS = 0;
    NSMutableArray *numArray = [[NSMutableArray alloc] init];
    /**
     *  This is the SS weight array, every SS will get their own rate, and store in this array.
     *  Particularly, if the SS is not coverd by all base station, the totalWeight will be 0.
     * 
     *  The reason using NSMutableSet here is avoiding to add duplicated element into the array.
     *  We think that if the totalWeight is equal, thus, the two SSs cannnot be distinguish.
     */
    NSMutableSet *SSWeightSet = [[NSMutableSet alloc] init];
    
    for (int i = 0; i < NumberOfSS; i++) {
        //  The totalWeight consists of RSSweight times the BS's number. Please check the following code.
        int totalWeight = 0;
        for (int j = 0; j < chromosome.cpoints.count; j++) {
            Cpoint *point = [chromosome.cpoints objectAtIndex:j];
            //  If Point Status is Yes, which means this point is activated, and will dominat in chromosome, the system will add its weight.
            if (point.status) {
                //  This aims to calculate the activated BS at the first time.
                if (0 == i) numOfActivatedBS += 1;
                
                //  Bug Here!!!
                for (BSCorresponding *correspondingSS in point.bs.subSSs) {
                    if (correspondingSS.correspondingSS.num == i) {
                        totalWeight += ((i+1) * correspondingSS.RSSIweight);
                    }
                }
            }
        }
        //NSLog(@"TotalWeight:%d", totalWeight);
        [SSWeightSet addObject:[NSNumber numberWithInt:totalWeight]];
    }
    
    //  Here, we minus number of no added elements to remove the duplicated elements.
    numOfRecognition = (int)(SSWeightSet.count - (NumberOfSS - SSWeightSet.count));
    
    [numArray addObject:[NSNumber numberWithInt:numOfActivatedBS]];
    [numArray addObject:[NSNumber numberWithInt:numOfRecognition]];
    
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
