//
//  Repair.m
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import "Repair.h"
#import "UtilityFunc.h"
#import "Chromosome.h"

@implementation Repair

+ (void)RepairOffspring:(Chromosome *)offspring {
    float fitness = [UtilityFunc fitnessFunctionWithChromosome:offspring andRecognitionRatio:OriginalAlpha];
}

@end
