//
//  UtilityFunc.h
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chromosome.h"

@interface UtilityFunc : NSObject

+ (void)fitnessFunctionWithSS:(NSMutableArray *)SSs andChromosome:(Chromosome *)chromosome andRecognitionRatio:(float)ratio;

//  New Fitness Function with NSString
+ (NSMutableArray *)fitnessFuncWithSS:(NSMutableArray *)SSs andChromosome:(NSString *)chromosome andRecognitionRatio:(float)ratio;

@end
