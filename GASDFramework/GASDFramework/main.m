//
//  main.m
//  GASDFramework
//
//  Created by roselifeye on 15/10/16.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPPlistManager.h"
#import "Chromosome.h"

NSMutableArray* initSS() {
    NSMutableArray *SSs = [[NSMutableArray alloc] init];
    for (int i = 0; i < CoordinateCount; i++) {
        int theColumn = i/MapRows;
        int x = 25 + (BeaconPreCount * (i - theColumn*MapRows));
        int y = 25 + (BeaconPreCount * theColumn);
        SubStation *ss = [[SubStation alloc] initWithPosition:SPPositionMake(x, y) andNumber:i];
        [SSs addObject:ss];
    }
    return SSs;
}

NSMutableArray* initialBS() {
    NSMutableArray *SSs = initSS();
    
    NSMutableArray *cpoints = [[NSMutableArray alloc] init];
    
    NSMutableArray *beaconData = [SPPlistManager GetBeaconData];
    for (NSDictionary *beacon in beaconData) {
        BaseStation *newBeacon = [[BaseStation alloc] initWithPosition:SPPositionMake([[beacon objectForKey:@"x"] intValue], [[beacon objectForKey:@"y"] intValue])];
        for (SubStation *ss in SSs) {
            [newBeacon addSubStaions:ss];
        }
        Cpoint *cpoint = [[Cpoint alloc] initWithBS:newBeacon];
        [cpoints addObject:cpoint];
    }
    return cpoints;
}

void initChromosome() {
    NSMutableArray *cpoints = initialBS();
    Chromosome *chromosome = [[Chromosome alloc] initWithPosition:cpoints];
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        initChromosome();
    }
    return 0;
}



