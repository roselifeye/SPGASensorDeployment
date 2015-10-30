//
//  Tournament.m
//  GASDFramework
//
//  Created by sy2036 on 2015-10-26.
//  Copyright © 2015 roselifeye. All rights reserved.
//

#import "Tournament.h"

@implementation Tournament

+ (Chromosome *)FourMemberTournament:(NSMutableArray *)pool {
    Chromosome *chro = [pool objectAtIndex:[Chromosome getRandomNumberWithRange:NumberOfIndividualsInPool*2]];
    for (int i = 0; i < 5; i++) {
        int ranNum = [Chromosome getRandomNumberWithRange:NumberOfIndividualsInPool*2];
        Chromosome *chro1 = [pool objectAtIndex:ranNum];
        chro = (chro.fitness<chro1.fitness)?chro:chro1;
    }
//    NSLog(@"Beacon:%d, Ambig:%d, fit:%f", chro.numberOfActivated, chro.numberOfAmbiguity, chro.fitness);
    return chro;
}


@end
