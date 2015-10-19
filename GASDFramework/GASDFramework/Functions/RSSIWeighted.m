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
    
    if (-80 > rssiValue) {
        weight = RSSI_WEIGHTED_NONE;
    } else if ((-80 <= rssiValue) && (-55 > rssiValue)) {
        weight = RSSI_WEIGHTED_LOW;
    } else if ((-55 <= rssiValue) && (-30 > rssiValue)) {
        weight = RSSI_WEIGHTED_MID;
    } else if ((-30 < rssiValue) && (-5 >= rssiValue)) {
        weight = RSSI_WEIGHTED_HIGH;
    } else weight = RSSI_WEIGHTED_NONE;
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
