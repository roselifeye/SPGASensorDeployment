//
//  Tournament.h
//  GASDFramework
//
//  Created by sy2036 on 2015-10-26.
//  Copyright © 2015 roselifeye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chromosome.h"

@interface Tournament : NSObject

+ (Chromosome *)FourMemberTournament:(NSMutableArray *)pool;

@end
