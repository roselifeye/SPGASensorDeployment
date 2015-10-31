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
#import "Mutation.h"
#import "IndividualsPool.h"
#import "Tournament.h"

NSMutableArray *BSs;
NSMutableArray *SSs;

//  The number of the generation.
int generation;

//  This is the ratio of the ambiguity.
float ratioOfAmbiguity;
/**
 *  Latest fitness from the last generation.
 *  If the lastest offspring's fitness is better than the value, 
 *  it will be updated.
 */
float latestFitness;

int bestNumber;
int bestAmbiguity;
float bestFitness;
float avgFitness;

int numberOfCurrentIteration;
int numberOfTotalIteration;

NSMutableArray *offsprings;

Chromosome *bestChromosome;

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
        int x = 25 + (NumberOfPotentialBS * (i - theColumn*MapRows));
        int y = 25 + (NumberOfPotentialBS * theColumn);
        SubStation *ss = [[SubStation alloc] initWithPosition:SPPositionMake(x, y) andNumber:i andBS:BSs];
        [SSs addObject:ss];
    }
    return SSs;
}

void getReslut(Chromosome *chro) {
    if (chro.numberOfActivated <= NumberOfDesireBeacons && chro.numberOfAmbiguity == 0) {
        bestChromosome = [chro mutableCopy];
        NSLog(@"Get the Result");
        exit(0);
    }
}

void eliteRecognize(Chromosome *chro) {
    [UtilityFunc fitnessFunctionWithSS:SSs andChromosome:chro andRecognitionRatio:ratioOfAmbiguity];
    avgFitness += chro.fitness;
    //  If the best fitness is larger than the current individual, the bestChromosom will be updated by chro.
    if (bestFitness >= chro.fitness) {
//        bestChromosome = [chro mutableCopy];
        bestChromosome = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:chro]];
        bestFitness = chro.fitness;
    }
    //  When Amiguity equals to zero, we think it's elite and advanced survived to the next generation.
    if (0 == chro.numberOfAmbiguity) {
//        [offsprings addObject:[chro mutableCopy]];
        Chromosome *temp = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:chro]];
        [offsprings addObject:temp];
        [SPPlistManager StoreNoneAmbiguityOffspring:temp withGeneration:generation];
        getReslut(chro);
    }
}

NSMutableArray* pairParentsAndEvoluateOffspring(NSMutableArray *pool) {
    NSMutableArray *firstOffsprings = [[NSMutableArray alloc] init];
    @autoreleasepool {
        for (int i = 0; i < NumberOfIndividualsInPool;) {
            Chromosome *chro1 = [pool objectAtIndex:i];
            Chromosome *chro2 = [pool objectAtIndex:i+1];
            /**
             *  According to the Ratio of the Crossover,
             *  calculate the Crossover for parents.
             */
            float ratioCros = (float)[Chromosome getRandomNumberWithRange:10]/10;
            if (ratioCros <= RatioOfCrossover) {
//                [Crossover onePointCrossoverWithParentOne:chro1 andParentTwo:chro2];
                [Crossover twoPointsCrossoverWithParentOne:chro1 andParentTwo:chro2];
                /**
                 *  According to the Ratio of the Crossover,
                 *  calculate the Crossover for parents.
                 */
                float ratioMut = (float)[Chromosome getRandomNumberWithRange:10]/10;
                if (ratioMut <= RatioOfMutation) {
                    for (int j = 1; j < NumberOfMutation; j++) {
                        [Mutation mutateParentsWithOffspring:chro1];
                        [Mutation mutateParentsWithOffspring:chro2];
                    }
                }
                eliteRecognize(chro1);
                eliteRecognize(chro2);
                [firstOffsprings addObject:chro1];
                [firstOffsprings addObject:chro2];
            }
            i += 2;
        }
        [offsprings addObject:[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:bestChromosome]]];
    }
    return firstOffsprings;
}

void initialValues() {
    generation = 2;
    
    ratioOfAmbiguity = OriginalAlpha;
    latestFitness = StartFitness;
    
    bestNumber = NumberOfPotentialBS;
    bestAmbiguity = 5000;
    bestFitness = StartFitness;
    avgFitness = 0;
    
    numberOfCurrentIteration = 1;
    numberOfTotalIteration = 1;
    
    offsprings = [[NSMutableArray alloc] init];
    
    BSs = initialBS();
    SSs = initSS(BSs);
}

void displayResult() {
    NSMutableArray *results = [SPPlistManager GetSurvivedOffspringListWithGeneration:0];
    NSLog(@"Got it!");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        srand(1);
        // insert code here...
//        displayResult();
        NSLog(@"Hello, World!");
        initialValues();
        //  Obtain the Original Pool for individuals.
        NSMutableArray *originalPool = [IndividualsPool InitialOriginalPoolWithBSs:BSs andSSs:SSs];
        bestChromosome = [originalPool objectAtIndex:0];
        avgFitness = 0;
        for (Chromosome *origChro in originalPool) {
            avgFitness += origChro.fitness;
            if (bestFitness >= origChro.fitness) {
                bestChromosome = origChro;
                bestFitness = origChro.fitness;
            }
        }
        NSLog(@"BestN:%d, BestA:%d, BestF:%f, AvgF:%f", bestChromosome.numberOfActivated, bestChromosome.numberOfAmbiguity, bestChromosome.fitness, avgFitness/NumberOfIndividualsInPool);
        NSLog(@"Generation 1.");
        while (1) {
            avgFitness = 0.0;
            bestFitness = StartFitness;
            bestChromosome = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:[originalPool objectAtIndex:0]]];
            //  Double the size of Pool by Pairwised Crossover and Mutaion.
            NSMutableArray *tempArray = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:originalPool]];
            [originalPool addObjectsFromArray:pairParentsAndEvoluateOffspring(tempArray)];
            while (offsprings.count < NumberOfIndividualsInPool) {
//                Chromosome *chro = [[Tournament FourMemberTournament:originalPool] mutableCopy];
                Chromosome *temp = [Tournament MemberTournament:originalPool];
                Chromosome *chro = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:temp]];
                avgFitness += chro.fitness;
                if (bestFitness >= chro.fitness) {
                    bestChromosome = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:chro]];
                    bestFitness = chro.fitness;
                }
                [offsprings addObject:chro];
                getReslut(chro);
            }
            [SPPlistManager StoreCurrentPool:offsprings withGenetation:generation];
            [originalPool removeAllObjects];
            originalPool = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:offsprings]];
            [offsprings removeAllObjects];
            offsprings = [[NSMutableArray alloc] init];;
            if (RatioReduceIteration == numberOfCurrentIteration) {
                ratioOfAmbiguity *= RatioReduce;
            }
            if (bestFitness < latestFitness) {
                latestFitness = bestFitness;
                numberOfCurrentIteration++;
            } else numberOfCurrentIteration = 0;
            NSLog(@"BestN:%d, BestA:%d, BestF:%f, AvgF:%f", bestChromosome.numberOfActivated, bestChromosome.numberOfAmbiguity, bestChromosome.fitness, avgFitness/NumberOfIndividualsInPool);
            NSLog(@"Generation %d.", generation);
            generation ++;
        }
    }
    return 0;
}

