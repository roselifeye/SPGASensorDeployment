//
//  main.m
//  GASDFramework
//
//  Created by roselifeye on 15/10/16.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPPlistManager.h"
#import "Chromosome.h"
#import "UtilityFunc.h"
#import "Crossover.h"

NSMutableArray* initialBS() {
    NSMutableArray *BSs = [[NSMutableArray alloc] init];
    NSMutableArray *bsData = [SPPlistManager GetBSData];
    for (NSDictionary *bs in bsData) {
        BaseStation *newBS = [[BaseStation alloc] initWithPosition:SPPositionMake([[bs objectForKey:@"x"] intValue], [[bs objectForKey:@"y"] intValue])];
        [BSs addObject:newBS];
    }
    return BSs;
}

NSMutableArray* initSS(NSMutableArray *BSs) {
    NSMutableArray *SSs = [[NSMutableArray alloc] init];
    for (int i = 0; i < NumberOfSS; i++) {
        int theColumn = i/MapRows;
        int x = 25 + (NumberOfBSPool * (i - theColumn*MapRows));
        int y = 25 + (NumberOfBSPool * theColumn);
        SubStation *ss = [[SubStation alloc] initWithPosition:SPPositionMake(x, y) andNumber:i andBS:BSs];
        [SSs addObject:ss];
    }
    return SSs;
}

NSMutableArray* createCPoint(NSMutableArray *BSs, NSMutableArray *statusArray) {
    NSMutableArray *cpoints = [[NSMutableArray alloc] init];
    for (int i = 0; i < BSs.count; i++) {
        Cpoint *cpoint = [[Cpoint alloc] initWithBS:[BSs objectAtIndex:i]];
        [cpoints addObject:cpoint];
    }
    for (NSNumber *index in statusArray) {
        ((Cpoint *)[cpoints objectAtIndex:[index intValue]-1]).status = YES;
    }
    return cpoints;
}

Chromosome* createChromosome(NSMutableArray *SSs, NSMutableArray *cpoints, int numberOfActivated) {
    Chromosome *chromosome = [[Chromosome alloc] initWithPosition:cpoints andNumberOfActivated:numberOfActivated];
    chromosome.fitness = [UtilityFunc fitnessFunctionWithSS:SSs andChromosome:chromosome andRecognitionRatio:OriginalAlpha];
    return chromosome;
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        /*
        NSMutableArray *statusArray = [Chromosome getSeriesRanNumWith:NumberOfOActivatedBS];
        NSMutableArray *BSs = initialBS();
        NSMutableArray *cpoints = [[NSMutableArray alloc] initWithArray:createCPoint(BSs, statusArray)];
        createChromosome(cpoints, NumberOfOActivatedBS);
        */
        NSMutableArray *BSs = initialBS();
        NSMutableArray *SSs = initSS(BSs);
        
        while (1) {
            NSMutableArray *statusArray1 = [Chromosome getSeriesRanNumWith:NumberOfOActivatedBS];
            sleep(1);
            NSMutableArray *statusArray2 = [Chromosome getSeriesRanNumWith:NumberOfOActivatedBS];
            NSMutableArray *cpoints1 = createCPoint(initialBS(), statusArray1);
            NSMutableArray *cpoints2 = createCPoint(initialBS(), statusArray2);
            Chromosome* chro1 = createChromosome(SSs, cpoints1, NumberOfOActivatedBS);
            Chromosome* chro2 = createChromosome(SSs, cpoints2, NumberOfOActivatedBS);
            [Crossover onePointCrossoverWithParentOne:chro1 andParentTwo:chro2];
            NSLog(@"123");
        }
    }
    return 0;
}

