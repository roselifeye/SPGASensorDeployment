//
//  GlobalDefine.h
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#ifndef GlobalDefine_h
#define GlobalDefine_h

/**
 *  Number of Original Activated BS
 */
#define NumberOfOActivatedBS        15
/**
 *  Number of Beacons
 */
#define NumberOfPotentialBS         50

#define NumberOfIndividualsInPool   200

#define NumberOfDesireBeacons       10

#define NumberOfMutation            5

#define OriginalAlpha               0.6

#define StartFitness                1

/**
 *  The Ratio of Ambiguity will reduce every
 *  RatioReduceIteration iteration.
 */
#define RatioReduceIteration        2
/**
 *  The Ratio of ambiguity will reduce the value by times
 *  RatioReduce
 */
#define RatioReduce                 1.0

#define RatioOfCrossover            1.0
#define RatioOfMutation             1.0


/**
 *  The unit of Map
 */
#define MapUnit 50
/**
 *  Size of Map
 */
#define MapRows 20
#define MapColumns 10
/**
 *  Number of Coordinate
 */
#define NumberOfSS MapRows * MapColumns

#endif /* GlobalDefine_h */
