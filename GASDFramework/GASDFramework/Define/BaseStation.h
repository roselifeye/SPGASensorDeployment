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

@property (nonatomic, assign) SPPosition bsCD;

/**
 *  The element of the array is class BSCorrespoing;
 */
@property (nonatomic, retain) NSMutableArray *subSSs;

- (instancetype)initWithPosition:(SPPosition)position;

@end


@interface BSCorrespoing : NSObject

@property (nonatomic, retain) SubStation *correspondingSS;
@property (nonatomic, assign) int RSSIweight;

@end
