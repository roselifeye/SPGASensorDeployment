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

+ (int)StoreSurvivedOffspring:(Chromosome *)offspring withGeneration:(int)generation {
    NSString *path = [NSString stringWithFormat:@"%@SurvivedOffspring95.plist", DataStoreAddress];
    int numberOfCurrrentGeneration = [SPPlistManager StoreChromosomeWithPath:path andOffspring:offspring withGeneration:generation];
    return numberOfCurrrentGeneration;
}

+ (void)StoreNoneAmbiguityOffspring:(Chromosome *)offspring withGeneration:(int)generation{
    NSString *path = [NSString stringWithFormat:@"%@NoneAmbiguityOffspring95.plist", DataStoreAddress];
    [SPPlistManager StoreChromosomeWithPath:path andOffspring:offspring withGeneration:generation];
}

+ (void)StoreCurrentPool:(NSMutableArray *)pool withGenetation:(int)generation {
    @autoreleasepool{
        NSString *path = [NSString stringWithFormat:@"%@SurvivedOffspring95.plist", DataStoreAddress];
        NSMutableArray *rootArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
        NSMutableArray *offsprings = [NSMutableArray array];
        if (nil == rootArray) {
            rootArray = [[NSMutableArray alloc] init];
            [rootArray addObject:offsprings];
        }
        if (generation == rootArray.count) {
            offsprings = [rootArray objectAtIndex:generation-1];
        } else [rootArray addObject:offsprings];
        
        for (Chromosome *chro in pool) {
            NSData *encodeOffspring = [NSKeyedArchiver archivedDataWithRootObject:chro];
            [offsprings addObject:encodeOffspring];
        }
        [rootArray writeToFile:path atomically:YES];
    }
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

@end
