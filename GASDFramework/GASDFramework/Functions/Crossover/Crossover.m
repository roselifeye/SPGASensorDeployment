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
    int randomPoint = [Chromosome getRandomNumberWithRange:NumberOfPotentialBS];
    NSArray *exP1 = [p1.cpoints subarrayWithRange:NSMakeRange(randomPoint, [p1.cpoints count]-randomPoint)];
    NSArray *exP2 = [p2.cpoints subarrayWithRange:NSMakeRange(randomPoint, [p2.cpoints count]-randomPoint)];
    
    [p1.cpoints replaceObjectsInRange:NSMakeRange(randomPoint, [p1.cpoints count]-randomPoint) withObjectsFromArray:exP2];
    [p2.cpoints replaceObjectsInRange:NSMakeRange(randomPoint, [p2.cpoints count]-randomPoint) withObjectsFromArray:exP1];

//    NSLog(@"Before Remove %d", p1.cpoints.count);
//    [p1.cpoints removeObjectsInRange:NSMakeRange(randomPoint, [p1.cpoints count]-randomPoint)];
//    [p2.cpoints removeObjectsInRange:NSMakeRange(randomPoint, [p2.cpoints count]-randomPoint)];
//    [p1.cpoints removeObjectsInArray:exP1];
//    [p2.cpoints removeObjectsInArray:exP2];
//
//    NSLog(@"After Remove %d", p1.cpoints.count);
//    
//    [p1.cpoints addObjectsFromArray:exP2];
//    [p2.cpoints addObjectsFromArray:exP1];
//    if (p1.cpoints.count > 50) {
//        NSLog(@"Finished %d", p1.cpoints.count);
//    }
}

+ (void)twoPointsCrossoverWithParentOne:(Chromosome *)p1 andParentTwo:(Chromosome *)p2 {
    NSMutableArray *randomPoints = [Chromosome getSeriesRanNumWith:2 andRange:NumberOfPotentialBS];
    int randomPoint1 = [[randomPoints objectAtIndex:0] intValue];
    int randomPoint2 = [[randomPoints objectAtIndex:1] intValue];
    int length = abs(randomPoint1-randomPoint2);
    NSRange crossoverRange = NSMakeRange((randomPoint1<randomPoint2)?randomPoint1:randomPoint2, length);
    NSArray *exP1 = [p1.cpoints subarrayWithRange:crossoverRange];
    NSArray *exP2 = [p2.cpoints subarrayWithRange:crossoverRange];
    [p1.cpoints replaceObjectsInRange:crossoverRange withObjectsFromArray:exP2];
    [p2.cpoints replaceObjectsInRange:crossoverRange withObjectsFromArray:exP1];
}

@end
