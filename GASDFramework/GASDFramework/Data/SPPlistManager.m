//
//  SPPlistManage.m
//  
//
//  Created by Roselifeye on 2015-06-10.
//
//

#import "SPPlistManager.h"

@implementation SPPlistManager


+ (NSMutableArray *)GetBSData {
    NSString *path = @"/Projects/Sipan/SPGASensorDeployment/GASDFramework/GASDFramework/SPBeaconLocationList.plist";
    //NSString *path =  [[NSBundle mainBundle] pathForResource:@"SPBeaconLocationList" ofType:@"plist"];
    NSMutableArray *beaconArray = [[[NSMutableArray alloc] initWithContentsOfFile:path] mutableCopy];
    
    return beaconArray;
}

+ (void)StoreSurvivedOffspring:(Chromosome *)offspring {
    NSString *path = @"/Projects/Sipan/SPGASensorDeployment/GASDFramework/GASDFramework/SurvivedOffspring.plist";
    NSMutableArray *offsprings = [[NSMutableArray alloc] initWithContentsOfFile:path];
    if (nil == offsprings) {
        offsprings = [[NSMutableArray alloc] init];
    }
    NSData *encodeOffspring = [NSKeyedArchiver archivedDataWithRootObject:offspring];
    [offsprings addObject:encodeOffspring];
    [offsprings writeToFile:path atomically:YES];
}

+ (NSMutableArray *)GetSurvivedOffspringList {
    NSMutableArray *survivedList = [NSMutableArray array];
    NSString *path = @"/Projects/Sipan/SPGASensorDeployment/GASDFramework/GASDFramework/SurvivedOffspring.plist";
    NSMutableArray *offsprings = [[NSMutableArray alloc] initWithContentsOfFile:path];
    for (NSData *encodeOffspring in offsprings) {
        Chromosome *decodeOne = [NSKeyedUnarchiver unarchiveObjectWithData:encodeOffspring];
        [survivedList addObject:decodeOne];
    }
    return survivedList;
}

+ (void)StoreNoneAmbiguityOffspring:(Chromosome *)offspring {
    NSString *path = @"/Projects/Sipan/SPGASensorDeployment/GASDFramework/GASDFramework/NoneAmbiguityOffspring";
    NSMutableArray *offsprings = [[NSMutableArray alloc] initWithContentsOfFile:path];
    if (nil == offsprings) {
        offsprings = [[NSMutableArray alloc] init];
    }
    NSData *encodeOffspring = [NSKeyedArchiver archivedDataWithRootObject:offspring];
    [offsprings addObject:encodeOffspring];
    [offsprings writeToFile:path atomically:YES];
}

@end
