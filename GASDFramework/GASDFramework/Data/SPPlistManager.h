//
//  SPPlistManage.h
//  
//
//  Created by Roselifeye on 2015-06-10.
//
//

#import <Foundation/Foundation.h>
#import "Chromosome.h"

@interface SPPlistManager : NSObject

/**
 *  Get Station Informations From Plist.
 *
 *  @return Array of the Informations.
 */
+ (NSMutableArray *)GetBSData;

+ (int)StoreSurvivedOffspring:(Chromosome *)offspring withGeneration:(int)generation;

+ (NSMutableArray *)GetSurvivedOffspringListWithGeneration:(int)generation;

+ (void)StoreNoneAmbiguityOffspring:(Chromosome *)offspring withGeneration:(int)generation;

+ (void)StoreCurrentPool:(NSMutableArray *)pool withGenetation:(int)generation;

@end
