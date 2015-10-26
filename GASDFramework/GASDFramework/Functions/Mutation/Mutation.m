//
//  Mutation.m
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import "Mutation.h"

@implementation Mutation

+ (void)mutateParentsWithOffspring:(Chromosome *)offspring {
    int randNum = [Chromosome getRandomNumberWithRange:NumberOfPotentialBS];
    BOOL reverseStatus = !((Cpoint *)[offspring.cpoints objectAtIndex:randNum]).status;
    ((Cpoint *)[offspring.cpoints objectAtIndex:randNum]).status = reverseStatus;
}


@end
