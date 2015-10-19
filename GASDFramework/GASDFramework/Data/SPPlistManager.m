//
//  SPPlistManage.m
//  
//
//  Created by Roselifeye on 2015-06-10.
//
//

#import "SPPlistManager.h"

@implementation SPPlistManager


//读取数据
+ (NSMutableArray *)GetBSData {
    NSString *path = @"/Projects/Sipan/SPGASensorDeployment/GASDFramework/GASDFramework/SPBeaconLocationList.plist";
    //NSString *path =  [[NSBundle mainBundle] pathForResource:@"SPBeaconLocationList" ofType:@"plist"];
    NSMutableArray *beaconArray = [[[NSMutableArray alloc] initWithContentsOfFile:path] mutableCopy];
    
    return beaconArray;
}


@end
