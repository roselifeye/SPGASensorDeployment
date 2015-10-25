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
#define NumberOfOActivatedBS    15
/**
 *  Number of Beacons
 */
#define NumberOfBSPool          50

#define OriginalAlpha           0.6

#define StartFitness            4000

/**
 *  The Ratio of Ambiguity will reduce every
 *  RatioReduceIteration iteration.
 */
#define RatioReduceIteration    3
/**
 *  The Ratio of ambiguity will reduce the value by times
 *  RatioReduce
 */
#define RatioReduce             0.8

#define NumberOfDesireBeacons   8


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
