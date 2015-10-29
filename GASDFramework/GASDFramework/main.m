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

int numberOfCurrentIteration;
int numberOfTotalIteration;

NSMutableArray *selectedIndexArray;
NSMutableArray *offsprings;

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

Chromosome* getNewChromosomeFromPool(NSMutableArray *pool) {
    int randNum = [Chromosome getRandomNumberWithRange:NumberOfIndividualsInPool];
    NSPredicate *dPredi = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", [NSNumber numberWithInt:randNum]];
    NSArray *dArray = [selectedIndexArray filteredArrayUsingPredicate:dPredi];
    if (dArray.count == 0) {
        
    }
    Chromosome *chro = [[pool objectAtIndex:randNum] copy];
    return chro;
}

void eliteRecognize(Chromosome *chro) {
    [UtilityFunc fitnessFunctionWithSS:SSs andChromosome:chro andRecognitionRatio:ratioOfAmbiguity];
    if (0 == chro.numberOfAmbiguity) {
        [offsprings addObject:chro];
    }
}

NSMutableArray* pairParentsAndEvoluateOffspring(NSMutableArray *pool) {
    NSMutableArray *firstOffsprings = [[NSMutableArray alloc] init];
    //  Randomly obtain Index of NumberOfIndividualsInPool.
    NSMutableArray *pairArray = [Chromosome getSeriesRanNumWith:NumberOfIndividualsInPool andRange:NumberOfIndividualsInPool];
    for (int i; i<NumberOfIndividualsInPool;) {
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

void evolutionFunc(Chromosome *chro1, Chromosome *chro2, NSMutableArray *pool) {
    [Crossover onePointCrossoverWithParentOne:chro1 andParentTwo:chro2];
//    [Crossover twoPointsCrossoverWithParentOne:chro1 andParentTwo:chro2];
    [Mutation mutateParentsWithOffspring:chro1];
    [Mutation mutateParentsWithOffspring:chro2];
    
    [UtilityFunc fitnessFunctionWithSS:SSs andChromosome:chro1 andRecognitionRatio:ratioOfAmbiguity];
    [UtilityFunc fitnessFunctionWithSS:SSs andChromosome:chro2 andRecognitionRatio:ratioOfAmbiguity];
    
    BOOL isAreadyAdded = NO;
    int numberOfCurrrentGeneration = 0;
    if (chro1.fitness == chro1.numberOfActivated) {
        [SPPlistManager StoreNoneAmbiguityOffspring:chro1 withGeneration:generation];
        numberOfCurrrentGeneration = [SPPlistManager StoreSurvivedOffspring:chro1 withGeneration:generation];
        isAreadyAdded = YES;
    }
    if (chro2.fitness == chro2.numberOfActivated) {
        [SPPlistManager StoreNoneAmbiguityOffspring:chro2 withGeneration:generation];
        numberOfCurrrentGeneration = [SPPlistManager StoreSurvivedOffspring:chro2 withGeneration:generation];
        isAreadyAdded = YES;
    }
    
    Chromosome *survivedOffspring = (chro1.fitness<chro2.fitness)?chro1:chro2;
    if (!isAreadyAdded) {
        numberOfCurrrentGeneration = [SPPlistManager StoreSurvivedOffspring:survivedOffspring withGeneration:generation];
    }
    
    numberOfTotalIteration++;
    if (survivedOffspring.fitness <= latestFitness) {
        numberOfCurrentIteration++;
        latestFitness = survivedOffspring.fitness;
    } else numberOfCurrentIteration = 0;
    
    if (numberOfCurrentIteration >= RatioReduceIteration) {
        numberOfCurrentIteration = 0;
        ratioOfAmbiguity *= RatioReduce;
    }
    
    if (survivedOffspring.numberOfActivated <= NumberOfDesireBeacons && survivedOffspring.fitness == survivedOffspring.numberOfActivated) {
        [[NSUserDefaults standardUserDefaults] setInteger:numberOfTotalIteration forKey:@"Iteration"];
        exit(0);
    }
    
    if (numberOfCurrrentGeneration == NumberOfIndividualsInPool) {
        NSLog(@"New Generation!");
        pool = [SPPlistManager GetSurvivedOffspringListWithGeneration:generation];
        generation ++;
        evolutionFunc(getNewChromosomeFromPool(pool), getNewChromosomeFromPool(pool), pool);
    } else {
        evolutionFunc(survivedOffspring, getNewChromosomeFromPool(pool), pool);
    }
}

void initialValues() {
    generation = 1;
    
    ratioOfAmbiguity = OriginalAlpha;
    latestFitness = StartFitness;
    
    numberOfCurrentIteration = 0;
    numberOfTotalIteration = 0;
    
    selectedIndexArray = [[NSMutableArray alloc] init];
    offsprings = [[NSMutableArray alloc] init];
    
    BSs = initialBS();
    SSs = initSS(BSs);
}

void displayResult() {
    NSMutableArray *results = [SPPlistManager GetSurvivedOffspringListWithGeneration:11];
    int iteration = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Iteration"] intValue];
    NSLog(@"Got it!");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        initialValues();
        //  Obtain the Original Pool for individuals.
        NSMutableArray *originalPool = [IndividualsPool InitialOriginalPoolWithBSs:BSs andSSs:SSs];
        [originalPool addObjectsFromArray:pairParentsAndEvoluateOffspring(originalPool)];
        
        Chromosome *chro1 = getNewChromosomeFromPool(originalPool);
        Chromosome *chro2 = getNewChromosomeFromPool(originalPool);
        
        evolutionFunc(chro1, chro2, originalPool);
        displayResult();
    }
    return 0;
}

