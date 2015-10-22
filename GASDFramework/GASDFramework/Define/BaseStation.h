//
//  BaseStation.h
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSIWeighted.h"


@interface BaseStation : NSObject

@property (nonatomic, assign,  readonly) SPPosition bsCD;

- (instancetype)initWithPosition:(SPPosition)position;

@end

