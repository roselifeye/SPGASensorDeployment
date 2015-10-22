//
//  Crossover.m
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import "Crossover.h"

@implementation Crossover

+ (void)onePointCrossoverWithParentOne:(Chromosome *)p1 andParentTwo:(Chromosome *)p2 {
    int randomPoint = [Chromosome getRandomNumber];
    NSArray *exP1 = [p1.cpoints subarrayWithRange:NSMakeRange(randomPoint, [p1.cpoints count]-randomPoint)];
    NSArray *exP2 = [p2.cpoints subarrayWithRange:NSMakeRange(randomPoint, [p2.cpoints count]-randomPoint)];
    [p1.cpoints removeObjectsInRange:NSMakeRange(randomPoint, [p1.cpoints count]-randomPoint)];
    [p2.cpoints removeObjectsInRange:NSMakeRange(randomPoint, [p2.cpoints count]-randomPoint)];
    [p1.cpoints addObjectsFromArray:exP2];
    [p2.cpoints addObjectsFromArray:exP1];
}

+ (void)twoPointsCrossoverWithParentOne:(Chromosome *)p1 andParentTwo:(Chromosome *)p2 {
    int randomPoint1 = [Chromosome getRandomNumber];
    sleep(1);
    int randomPoint2 = [Chromosome getRandomNumber];
    NSArray *exP1 = [p1.cpoints subarrayWithRange:NSMakeRange(randomPoint1, randomPoint2)];
    NSArray *exP2 = [p2.cpoints subarrayWithRange:NSMakeRange(randomPoint1, randomPoint2)];
    [p1.cpoints replaceObjectsInRange:NSMakeRange(randomPoint1, randomPoint2) withObjectsFromArray:exP2];
    [p2.cpoints replaceObjectsInRange:NSMakeRange(randomPoint1, randomPoint2) withObjectsFromArray:exP1];
}

@end
