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

+ (NSMutableArray *)InitialOriginalPoolWithBSs:(NSMutableArray *)BSs andSSs:(NSMutableArray *)SSs {
    NSMutableArray *originalPool = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < NumberOfIndividualsInPool; i++) {
        Chromosome *chro = [self CreateNewParentProcessWithBSs:BSs andSSs:SSs];
        [SPPlistManager StoreSurvivedOffspring:chro withGeneration:1];
        [originalPool addObject:chro];
    }
    return originalPool;
}


#pragma mark -
#pragma mark - The following three function aims to create new parent.
+ (NSMutableArray *)CreateCPointWithBSs:(NSMutableArray *)BSs andSSs:(NSMutableArray *)SSs andStatus:(NSMutableArray *)statusArray {
    NSMutableArray *cpoints = [[NSMutableArray alloc] init];
    for (int i = 0; i < BSs.count; i++) {
        Cpoint *cpoint = [[Cpoint alloc] initWithBS:[BSs objectAtIndex:i]];
        [cpoints addObject:cpoint];
    }
    for (NSNumber *index in statusArray) {
        ((Cpoint *)[cpoints objectAtIndex:[index intValue]]).status = YES;
    }
    return cpoints;
}

+ (Chromosome *)CreateChromosomeWithCpoints:(NSMutableArray *)cpoints andSSs:(NSMutableArray *)SSs andNumberOfActivated:(int)numberOfActivated {
    Chromosome *chromosome = [[Chromosome alloc] initWithPosition:cpoints andNumberOfActivated:numberOfActivated];
    [UtilityFunc fitnessFunctionWithSS:SSs andChromosome:chromosome andRecognitionRatio:OriginalAlpha];
    return chromosome;
}

+ (Chromosome *)CreateNewParentProcessWithBSs:(NSMutableArray *)BSs andSSs:(NSMutableArray *)SSs {
    NSMutableArray *statusArray = [Chromosome getSeriesRanNumWith:[Chromosome getRandomNumberWithRange:NumberOfPotentialBS] andRange:NumberOfPotentialBS];
    NSMutableArray *cpoints = [self CreateCPointWithBSs:BSs andSSs:SSs andStatus:statusArray];
    Chromosome *chro = [self CreateChromosomeWithCpoints:cpoints andSSs:SSs andNumberOfActivated:NumberOfOActivatedBS];
    return chro;
}

@end
