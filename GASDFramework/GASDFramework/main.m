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

NSMutableArray *BSs;
NSMutableArray *SSs;

float ratioOfAmbiguity;

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

NSMutableArray* createCPoint(NSMutableArray *statusArray) {
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
    chromosome.fitness = [UtilityFunc fitnessFunctionWithSS:SSs andChromosome:chromosome andRecognitionRatio:ratioOfAmbiguity];
    return chromosome;
}

void evolutionFunc(Chromosome *chro1, Chromosome *chro2) {
    [Crossover onePointCrossoverWithParentOne:chro1 andParentTwo:chro2];
    chro1.fitness = [UtilityFunc fitnessFunctionWithSS:SSs andChromosome:chro1 andRecognitionRatio:ratioOfAmbiguity];
    chro2.fitness = [UtilityFunc fitnessFunctionWithSS:SSs andChromosome:chro2 andRecognitionRatio:ratioOfAmbiguity];
}

void initialValues() {
    ratioOfAmbiguity = OriginalAlpha;
    BSs = initialBS();
    SSs = initSS(BSs);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        initialValues();
        
        while (1) {
            NSMutableArray *statusArray1 = [Chromosome getSeriesRanNumWith:NumberOfOActivatedBS];
            sleep(1);
            NSMutableArray *statusArray2 = [Chromosome getSeriesRanNumWith:NumberOfOActivatedBS];
            NSMutableArray *cpoints1 = createCPoint(statusArray1);
            NSMutableArray *cpoints2 = createCPoint(statusArray2);
            Chromosome *chro1 = createChromosome(cpoints1, NumberOfOActivatedBS);
            Chromosome *chro2 = createChromosome(cpoints2, NumberOfOActivatedBS);
            
            [SPPlistManager StoreSurvivedOffspring:chro1];
            
            evolutionFunc(chro1, chro2);
        }
    }
    return 0;
}

