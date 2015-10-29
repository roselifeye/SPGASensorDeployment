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
float currentFitness;

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
        bestChromosome = chro;
        NSLog(@"Get the Result");
        exit(0);
    }
}

void eliteRecognize(Chromosome *chro) {
    [UtilityFunc fitnessFunctionWithSS:SSs andChromosome:chro andRecognitionRatio:ratioOfAmbiguity];
    if (chro.fitness < currentFitness) {
        currentFitness = chro.fitness;
    }
    if (0 == chro.numberOfAmbiguity) {
        [offsprings addObject:chro];
        [SPPlistManager StoreSurvivedOffspring:chro withGeneration:generation];
        [SPPlistManager StoreNoneAmbiguityOffspring:chro withGeneration:generation];
        getReslut(chro);
    }
}

NSMutableArray* pairParentsAndEvoluateOffspring(NSMutableArray *pool) {
    NSMutableArray *firstOffsprings = [[NSMutableArray alloc] init];
    //  Randomly obtain Index of NumberOfIndividualsInPool.
    NSMutableArray *pairArray = [Chromosome getSeriesRanNumWith:NumberOfIndividualsInPool andRange:NumberOfIndividualsInPool];
    for (int i = 0; i < NumberOfIndividualsInPool;) {
        Chromosome *chro1 = [[pool objectAtIndex:[[pairArray objectAtIndex:i] intValue]] copy];
        Chromosome *chro2 = [[pool objectAtIndex:[[pairArray objectAtIndex:i+1] intValue]] copy];
        /**
         *  According to the Ratio of the Crossover,
         *  calculate the Crossover for parents.
         */
        float ratioCros = (float)[Chromosome getRandomNumberWithRange:10]/10;
        if (ratioCros <= RatioOfCrossover) {
            [Crossover onePointCrossoverWithParentOne:chro1 andParentTwo:chro2];
            /**
             *  According to the Ratio of the Crossover,
             *  calculate the Crossover for parents.
             */
            float ratioMut = (float)[Chromosome getRandomNumberWithRange:10]/10;
            if (ratioMut <= RatioOfMutation) {
                [Mutation mutateParentsWithOffspring:chro1];
                [Mutation mutateParentsWithOffspring:chro2];
            }
            eliteRecognize(chro1);
            eliteRecognize(chro2);
            [firstOffsprings addObject:chro1];
            [firstOffsprings addObject:chro2];
        }
        i += 2;
    }
    return firstOffsprings;
}

void initialValues() {
    generation = 2;
    
    ratioOfAmbiguity = OriginalAlpha;
    latestFitness = StartFitness;
    currentFitness = StartFitness;
    
    numberOfCurrentIteration = 1;
    numberOfTotalIteration = 1;
    
    offsprings = [NSMutableArray array];
    
    BSs = initialBS();
    SSs = initSS(BSs);
}

void displayResult() {
    NSMutableArray *results = [SPPlistManager GetSurvivedOffspringListWithGeneration:6];
    NSLog(@"Got it!");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        displayResult();
        NSLog(@"Hello, World!");
        initialValues();
        //  Obtain the Original Pool for individuals.
        NSMutableArray *originalPool = [IndividualsPool InitialOriginalPoolWithBSs:BSs andSSs:SSs];
        
        while (1) {
            //  Double the size of Pool by Pairwised Crossover and Mutaion.
            [originalPool addObjectsFromArray:pairParentsAndEvoluateOffspring(originalPool)];
            while (offsprings.count < NumberOfIndividualsInPool) {
                Chromosome *chro = [[Tournament FourMemberTournament:originalPool] copy];
                [offsprings addObject:chro];
                [SPPlistManager StoreSurvivedOffspring:chro withGeneration:generation];
                getReslut(chro);
            }
            originalPool = [NSMutableArray arrayWithArray:offsprings];
            offsprings = [NSMutableArray array];;
            generation ++;
            if (RatioReduceIteration == numberOfCurrentIteration) {
                ratioOfAmbiguity *= RatioReduce;
            }
            if (currentFitness < latestFitness) {
                numberOfCurrentIteration++;
            } else numberOfCurrentIteration = 0;
            NSLog(@"New Generation.");
        }
    }
    return 0;
}

