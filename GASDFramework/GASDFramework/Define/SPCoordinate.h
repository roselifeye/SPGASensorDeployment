//
//  SPCoordinate.h
//  GASDFramework
//
//  Created by roselifeye on 15/10/18.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#ifndef SPCoordinate_h
#define SPCoordinate_h

struct SPPosition {
    int x;
    int y;
};
typedef struct SPPosition SPPosition;

static inline SPPosition
SPPositionMake(int x, int y) {
    SPPosition position;
    position.x = x;
    position.y = y;
    return position;
}

#endif /* SPCoordinate_h */
