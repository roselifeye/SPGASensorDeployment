//
//  Mutation.h
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chromosome.h"

@interface Mutation : NSObject

+ (NSString *)mutateOffspring:(NSString *)offspring;

@end
