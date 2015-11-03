//
//  Tournament.m
//  GASDFramework
//
//  Created by sy2036 on 2015-10-26.
//  Copyright © 2015 roselifeye. All rights reserved.
//

#import "Tournament.h"

@implementation Tournament

+ (NSString *)MembersTournament:(NSMutableArray *)pool {
    NSString *chro = [pool objectAtIndex:[Chromosome getRandomNumberWithRange:NumberOfIndividualsInPool*2]];
    for (int i = 0; i < NumberOfTournament; i++) {
        int ranNum = [Chromosome getRandomNumberWithRange:NumberOfIndividualsInPool*2];
        NSString *chro1 = [pool objectAtIndex:ranNum];
        chro = ([Chromosome readChromosomeFitness:chro]<[Chromosome readChromosomeFitness:chro1])?chro:chro1;
    }
    return chro;
}
@end
