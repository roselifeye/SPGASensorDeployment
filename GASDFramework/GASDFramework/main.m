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
int numberOfStopG;

NSMutableArray *offsprings;

NSString *bestChroStr;

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

void getReslut(NSString *chro) {
    if ([Chromosome readChromosomeActivated:chro] <= NumberOfDesireBeacons && [Chromosome readChromosomeAmbiguity:chro] == 0) {
        bestChroStr = chro;
        NSLog(@"Get the Result");
        exit(0);
    }
}

NSString* eliteRecognize(NSString *chro) {
    chro = [UtilityFunc fitnessFuncWithSS:SSs andChromosome:chro andRecognitionRatio:ratioOfAmbiguity];
    float fitness = [Chromosome readChromosomeFitness:chro];
    avgFitness += fitness;
    //  If the best fitness is larger than the current individual, the bestChromosom will be updated by chro.
    if (bestFitness >= fitness) {
        bestChroStr = chro;
        bestFitness = fitness;
    }
    //  When Amiguity equals to zero, we think it's elite and advanced survived to the next generation.
    if (0 == [Chromosome readChromosomeAmbiguity:chro]) {
        NSString *temp = chro;
        [offsprings addObject:temp];
        [SPPlistManager StoreNAOffspring:temp withGeneration:generation];
        getReslut(chro);
    }
    return chro;
}

NSMutableArray* pairParentsAndEvoluateOffspring(NSMutableArray *pool) {
    NSMutableArray *firstOffsprings = [[NSMutableArray alloc] init];
    @autoreleasepool {
        for (int i = 0; i < NumberOfIndividualsInPool;) {
            NSString *chro1 = [pool objectAtIndex:i];
            NSString *chro2 = [pool objectAtIndex:i+1];
            /**
             *  According to the Ratio of the Crossover,
             *  calculate the Crossover for parents.
             */
            float ratioCros = (float)[Chromosome getRandomNumberWithRange:10]/10;
            if (ratioCros <= RatioOfCrossover) {
                NSArray *parents = [Crossover onePointCrossWithParentOne:chro1 andParentTwo:chro2];
                chro1 = [parents objectAtIndex:0];
                chro2 = [parents objectAtIndex:1];
                /**
                 *  According to the Ratio of the Crossover,
                 *  calculate the Crossover for parents.
                 */
                float ratioMut = (float)[Chromosome getRandomNumberWithRange:10]/10;
                if (ratioMut <= RatioOfMutation) {
                    for (int j = 1; j < NumberOfMutation; j++) {
                        chro1 = [Mutation mutateOffspring:chro1];
                        chro2 = [Mutation mutateOffspring:chro2];
                    }
                }
                chro1 = eliteRecognize(chro1);
                chro2 = eliteRecognize(chro2);
                [firstOffsprings addObject:chro1];
                [firstOffsprings addObject:chro2];
            }
            i += 2;
        }
        [offsprings addObject:bestChroStr];
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
    numberOfStopG = 0;
    
    offsprings = [[NSMutableArray alloc] init];
    
    BSs = initialBS();
    SSs = initSS(BSs);
}

void displayResult() {
    NSMutableArray *eeee = [SPPlistManager GetSurvivedOffspringListWithGeneration:500];
    NSLog(@"Got it!");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        srand((unsigned)time(NULL));
//        displayResult();
        NSLog(@"Hello, World!");
        initialValues();
        //  Obtain the Original Pool for individuals.
        NSMutableArray *originalPool = [IndividualsPool InitialPoolWithBSs:BSs andSSs:SSs];
        bestChroStr = [originalPool objectAtIndex:0];
        avgFitness = 0;
        for (NSString *origChro in originalPool) {
            float fitness = [Chromosome readChromosomeFitness:origChro];
            avgFitness += fitness;
            if (bestFitness >= fitness) {
                bestChroStr = origChro;
                bestFitness = fitness;
            }
        }
        NSLog(@"BestN:%d, BestA:%d, BestF:%f, AvgF:%f", [Chromosome readChromosomeActivated:bestChroStr], [Chromosome readChromosomeAmbiguity:bestChroStr], [Chromosome readChromosomeFitness:bestChroStr], avgFitness/NumberOfIndividualsInPool);
        NSLog(@"Generation 1.");
        while (1) {
            avgFitness = 0.0;
            bestFitness = StartFitness;
            bestChroStr = [originalPool objectAtIndex:0];
            //  Double the size of Pool by Pairwised Crossover and Mutaion.
            NSMutableArray *tempArray = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:originalPool]];
            [originalPool addObjectsFromArray:pairParentsAndEvoluateOffspring(tempArray)];
            while (offsprings.count < NumberOfIndividualsInPool) {
                NSString *chro = [Tournament MembersTournament:originalPool];
                float fitness = [Chromosome readChromosomeFitness:chro];
                avgFitness += fitness;
                if (bestFitness >= fitness) {
                    bestChroStr = chro;
                    bestFitness = fitness;
                }
                [offsprings addObject:chro];
            }
            [SPPlistManager StoreNewPool:offsprings];
            [originalPool removeAllObjects];
            originalPool = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:offsprings]];
            [offsprings removeAllObjects];
            offsprings = [[NSMutableArray alloc] init];;
            if (RatioReduceIteration == numberOfCurrentIteration) {
                ratioOfAmbiguity *= RatioReduce;
            }
            if (bestFitness == latestFitness) {
                numberOfStopG ++;
            } else numberOfStopG = 0;
            if (bestFitness < latestFitness) {
                latestFitness = bestFitness;
                numberOfCurrentIteration++;
            } else numberOfCurrentIteration = 0;
            if (110 == numberOfStopG) {
                NSLog(@"Stop!");
                exit(0);
            }
            NSLog(@"BestN:%d, BestA:%d, BestF:%f, AvgF:%f", [Chromosome readChromosomeActivated:bestChroStr], [Chromosome readChromosomeAmbiguity:bestChroStr], [Chromosome readChromosomeFitness:bestChroStr], avgFitness/NumberOfIndividualsInPool);
            NSLog(@"Generation %d.", generation);
            generation ++;
        }
        
    }
    return 0;
}

