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
    RSSI_WEIGHTED_NONE,      // If the RSSI value is < -100 or == 0, the weight is none.
    RSSI_WEIGHTED_VLOW,      // If the RSSI value is -100 <= < -80, the weight is very low.
    RSSI_WEIGHTED_LOW,      // If the RSSI value is -80 <= <-60, the weight is love.
    RSSI_WEIGHTED_MID,      // If the RSSI value is -60 <= <-40, the weight is mid.
    RSSI_WEIGHTED_HIGH,      // If the RSSI value is -40 <= <-20 , the weight is high.
    RSSI_WEIGHTED_VHIGH,      // If the RSSI value is -20 <= , the weight is very high.
};

/**
 *  Calculate the weight by coordiantes of base station and substation.
 *
 *  @param bsCD Coordinate of base station.
 *  @param ssCD Coordinate of substation.
 *
 *  @return weight.
 */
+ (RSSI_WEIGHTED_LEVEL)weightCalculateWithBSCD:(SPPosition)bsCD andSSCD:(SPPosition)ssCD;

@end
