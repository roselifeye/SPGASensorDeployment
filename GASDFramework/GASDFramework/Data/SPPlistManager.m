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
    NSString *path = [NSString stringWithFormat:@"%@SPBeaconLocationList.plist", DataStoreAddress];
    //NSString *path =  [[NSBundle mainBundle] pathForResource:@"SPBeaconLocationList" ofType:@"plist"];
    NSMutableArray *beaconArray = [[[NSMutableArray alloc] initWithContentsOfFile:path] mutableCopy];
    
    return beaconArray;
}

+ (int)StoreChromosomeWithPath:(NSString *)path andOffspring:(Chromosome *)offspring withGeneration:(int)generation {
    int num = 0;
    @autoreleasepool{
        NSMutableArray *rootArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
        NSMutableArray *offsprings = [NSMutableArray array];
        if (nil == rootArray) {
            rootArray = [[NSMutableArray alloc] init];
            [rootArray addObject:offsprings];
        }
        if (generation == rootArray.count) {
            offsprings = [rootArray objectAtIndex:generation-1];
        } else [rootArray addObject:offsprings];
        
        
        NSData *encodeOffspring = [NSKeyedArchiver archivedDataWithRootObject:offspring];
        [offsprings addObject:encodeOffspring];
        
        [rootArray writeToFile:path atomically:YES];
        
        num = (int)[offsprings count];
        
        rootArray = nil;
        offsprings = nil;
    }
    return num;
}

+ (NSMutableArray *)GetSurvivedOffspringListWithGeneration:(int)generation {
    NSMutableArray *survivedList = [NSMutableArray array];
    NSString *path = [NSString stringWithFormat:@"%@SurvivedOffspring95.plist", DataStoreAddress];
    NSMutableArray *rootArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    NSMutableArray *offsprings = [NSMutableArray array];
    if (nil == rootArray) {
        rootArray = [[NSMutableArray alloc] init];
        [rootArray addObject:offsprings];
    } else offsprings = [rootArray objectAtIndex:generation-1];
    
    for (NSData *encodeOffspring in offsprings) {
        Chromosome *decodeOne = [NSKeyedUnarchiver unarchiveObjectWithData:encodeOffspring];
        [survivedList addObject:decodeOne];
    }
    return survivedList;
}

#pragma mark -
#pragma mark - Store New Chromosome type
+ (void)StoreNewPool:(NSMutableArray *)pool {
    @autoreleasepool{
        NSString *path = [NSString stringWithFormat:@"%@SurvivedOffspring80.plist", DataStoreAddress];
        NSMutableArray *rootArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
        if (nil == rootArray) {
            rootArray = [[NSMutableArray alloc] init];
        }
        [rootArray addObject:pool];
        [rootArray writeToFile:path atomically:YES];
    }
}

+ (void)StoreNAOffspring:(NSString *)offspring withGeneration:(int)generation {
    @autoreleasepool{
        NSString *path = [NSString stringWithFormat:@"%@NoneAmbiguityOffspring80.plist", DataStoreAddress];
        NSMutableDictionary *rootDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        NSMutableArray *offsprings = [NSMutableArray array];
        if (nil == rootDic) {
            rootDic = [[NSMutableDictionary alloc] init];
            [rootDic setObject:offsprings forKey:[NSString stringWithFormat:@"%d", generation]];
        } else {
            offsprings = [rootDic objectForKey:[NSString stringWithFormat:@"%d", generation]];
        }
        [offsprings addObject:offspring];
        [rootDic writeToFile:path atomically:YES];
    }
}


@end
