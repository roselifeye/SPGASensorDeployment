//
//  main.m
//  GASDFramework
//
//  Created by roselifeye on 15/10/16.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPPlistManager.h"


void initialBS() {
    NSMutableArray *beaconData = [SPPlistManager GetBeaconData];
    
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        initialBS();
    }
    return 0;
}



