//
//  RSSIWeighted.h
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSIWeighted : NSObject

typedef NS_ENUM(NSInteger, RSSI_WEIGHTED_LEVEL){
    RSSI_WEIGHTED_NONE,      // If the RSSI value is < -80, the weight is none.
    RSSI_WEIGHTED_LOW,      // If the RSSI value is -80 <= <-55, the weight is small.
    RSSI_WEIGHTED_MID,      // If the RSSI value is -55 <= <-30, the weight is mid.
    RSSI_WEIGHTED_HIGH,      // If the RSSI value is -30 <= , the weight is high.
};


/**
 *  Calculate the weight by coordiantes of base station and substation.
 *
 *  @param bsCD Coordinate of base station.
 *  @param ssCD Coordinate of substation.
 *
 *  @return weight.
 */
+ (RSSI_WEIGHTED_LEVEL)weightCalculateWithBSCD:(Coordinate *)bsCD andSSCD:(Coordinate *)ssCD;

@end
