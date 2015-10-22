//
//  Crossover.h
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chromosome.h"

@interface Crossover : NSObject

/**
 *  This is a one point crossover function.
 *  First, randomly get a point index, or position.
 *  Second, find the element of both parents in such position.
 *  Third, exchange all elements after this position of two parents.
 *
 *  @param p1 Parent One
 *  @param p2 Parent Two
 */
+ (void)onePointCrossoverWithParentOne:(Chromosome *)p1 andParentTwo:(Chromosome *)p2;

/**
 *  This is a two points crossover function.
 *  First, randomly get two point indexes, or positions.
 *  Second, find the elements of both parents in such positions.
 *  Third, exchange all elements between these two positions of two parents.
 *
 *  @param p1 Parent One
 *  @param p2 Parent Two
 */
+ (void)twoPointsCrossoverWithParentOne:(Chromosome *)p1 andParentTwo:(Chromosome *)p2;

@end
