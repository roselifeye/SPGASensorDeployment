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

NSMutableArray* initSS() {
    NSMutableArray *SSs = [[NSMutableArray alloc] init];
    for (int i = 0; i < NumberOfSS; i++) {
        int theColumn = i/MapRows;
        int x = 25 + (NumberOfBSPool * (i - theColumn*MapRows));
        int y = 25 + (NumberOfBSPool * theColumn);
        SubStation *ss = [[SubStation alloc] initWithPosition:SPPositionMake(x, y) andNumber:i];
        [SSs addObject:ss];
    }
    return SSs;
}

NSMutableArray* initialBS() {
    NSMutableArray *SSs = initSS();
    
    NSMutableArray *BSs = [[NSMutableArray alloc] init];
    NSMutableArray *bsData = [SPPlistManager GetBeaconData];
    for (NSDictionary *bs in bsData) {
        BaseStation *newBS = [[BaseStation alloc] initWithPosition:SPPositionMake([[bs objectForKey:@"x"] intValue], [[bs objectForKey:@"y"] intValue])];
        for (SubStation *ss in SSs) {
            [newBS addSubStaions:ss];
        }
        [BSs addObject:newBS];
    }
    return BSs;
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

Chromosome* createChromosome(NSMutableArray *cpoints, int numberOfActivated) {
    Chromosome *chromosome = [[Chromosome alloc] initWithPosition:cpoints andNumberOfActivated:numberOfActivated];
    chromosome.fitness = [UtilityFunc fitnessFunctionWithChromosome:chromosome andRecognitionRatio:OriginalAlpha];
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
        while (1) {
            NSMutableArray *statusArray = [Chromosome getSeriesRanNumWith:NumberOfOActivatedBS];
            NSMutableArray *cpoints = createCPoint(initialBS(), statusArray);
            Chromosome* chro = createChromosome(cpoints, NumberOfOActivatedBS);
            if (chro.fitness >= MinimumFitness) {
                NSLog(@"GOOD");
                break;}
        }
    }
    return 0;
}



