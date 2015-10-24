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

+ (void)StoreSurvivedOffspring:(Chromosome *)offspring;

+ (NSMutableArray *)GetSurvivedOffspringList;

@end
