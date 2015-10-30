//
//  RSSIWeighted.m
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import "RSSIWeighted.h"

@implementation RSSIWeighted

+ (RSSI_WEIGHTED_LEVEL)weightCalculateWithBSCD:(SPPosition)bsCD andSSCD:(SPPosition)ssCD {
    RSSI_WEIGHTED_LEVEL weight = RSSI_WEIGHTED_NONE;
    int rssiValue = [RSSIWeighted rssiValueCalculateWithBSCD:bsCD andSSCD:ssCD];
    
    if (-100 > rssiValue || 0 == rssiValue) {
        weight = RSSI_WEIGHTED_NONE;
    } else if (-100 <= rssiValue && -80 > rssiValue) {
        weight = RSSI_WEIGHTED_LOW;
    } else if (-80 <= rssiValue && -60 > rssiValue) {
        weight = RSSI_WEIGHTED_VLOW;
    } else if (-60 <= rssiValue && -40 > rssiValue) {
        weight = RSSI_WEIGHTED_MID;
    } else if (-40 <= rssiValue && -20 > rssiValue) {
        weight = RSSI_WEIGHTED_HIGH;
    } else if (-20 <= rssiValue && -5>= rssiValue) {
        weight = RSSI_WEIGHTED_VHIGH;
    }
    return weight;
}

+ (int)rssiValueCalculateWithBSCD:(SPPosition)bsCD andSSCD:(SPPosition)ssCD {
    int rssiValue = 0;
    
    /**
     *  Caculate the distance from the beacon to destination.
     */
    float distance = sqrtf(pow((ssCD.x-bsCD.x), 2) + pow((ssCD.y-bsCD.y), 2));
    
    /**
     *  The Original RSSI is -5.
     *  The Fadding is based on the distance.
     *  Every Unit will reduce 35.
     *  So that a single beacon can only influence 2 near coordinates.
     *
     */
    rssiValue = -5 - (distance/MapUnit)*35;
    if (rssiValue < -100) {
        rssiValue = 0;
    }
    return rssiValue;
}

@end
