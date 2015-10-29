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
    Chromosome *chro;
    for (int i = 0; i < 4; i++) {
        Chromosome *chro1 = [pool objectAtIndex:[Chromosome getRandomNumberWithRange:NumberOfIndividualsInPool*2]];
        Chromosome *chro2 = [pool objectAtIndex:[Chromosome getRandomNumberWithRange:NumberOfIndividualsInPool*2]];
        chro = (chro1.fitness>chro2.fitness)?chro1:chro2;
    }
    return chro;
}

@end
