//
//  BaseStation.h
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubStation.h"

@interface BaseStation : NSObject

@property (nonatomic, retain) Coordinate *bsCD;

/**
 *  The element of the array is class BSCorrespoing;
 */
@property (nonatomic, retain) NSArray *subSSs;


@end


@interface BSCorrespoing : NSObject

@property (nonatomic, retain) SubStation *correspondingSS;
@property (nonatomic, assign) int RSSIweight;

@end
