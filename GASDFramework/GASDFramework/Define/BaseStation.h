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

@property (nonatomic, assign,  readonly) SPPosition bsCD;

/**
 *  The element of the array is class BSCorrespoing;
 */
@property (nonatomic, retain) NSMutableArray *subSSs;

- (instancetype)initWithPosition:(SPPosition)position;

- (void)addSubStaions:(SubStation *)substation;

@end


@interface BSCorresponding : NSObject

@property (nonatomic, retain, readonly) SubStation *correspondingSS;
@property (nonatomic, assign, readonly) int RSSIweight;

- (instancetype)initWithSS:(SubStation *)subStation andWeight:(int)weight;

@end
