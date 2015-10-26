//
//  Chromosome.m
//  GASDFramework
//
//  Created by roselifeye on 15/10/17.
//  Copyright © 2015年 roselifeye. All rights reserved.
//

#import "Chromosome.h"
#import "UtilityFunc.h"

@implementation Chromosome

- (instancetype)initWithPosition:(NSMutableArray *)cpoints andNumberOfActivated:(int)numberOfActivated {
    if (self) {
        _cpoints = cpoints;
        _numberOfActivated = numberOfActivated;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    //encode properties/values
    [aCoder encodeInt:self.numberOfActivated forKey:@"numberOfActivated"];
    [aCoder encodeInt:self.numberOfAmbiguity forKey:@"numberOfAmbiguity"];
    [aCoder encodeFloat:self.ratio forKey:@"ratio"];
    [aCoder encodeFloat:self.fitness forKey:@"fitness"];
    [aCoder encodeObject:self.cpoints forKey:@"cpoints"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if((self = [super init])) {
        //decode properties/values
        self.cpoints = [aDecoder decodeObjectForKey:@"cpoints"];
        self.numberOfActivated = [aDecoder decodeIntForKey:@"numberOfActivated"];
        self.numberOfAmbiguity = [aDecoder decodeIntForKey:@"numberOfAmbiguity"];
        self.ratio = [aDecoder decodeFloatForKey:@"ratio"];
        self.fitness = [aDecoder decodeFloatForKey:@"fitness"];
    }
    return self;
}

+ (int)getRandomNumberWithRange:(int)range {
    /**
     *  Seed the random-number generator with current time
     *  so that the numbers will be different every time we run.
     */
    int randNum = arc4random()%range;
    return randNum;
}

+ (NSMutableArray *)getSeriesRanNumWith:(int)number andRange:(int)range{
    NSMutableArray *seriesRN = [[NSMutableArray alloc] init];
    for (int i = 0; i < number;) {
        seriesRN[i] = [NSNumber numberWithInt:[Chromosome getRandomNumberWithRange:range]];
        int j;
        for (j = 0; j < i; j++) {
            if ([[seriesRN objectAtIndex:j] intValue] == [[seriesRN objectAtIndex:i] intValue]) break;
        }
        if (j == i) i++;
    }
    return seriesRN;
}

@end


@implementation Cpoint

- (instancetype)initWithBS:(BaseStation *)baseStation {
    if(self) {
        _bs = baseStation;
        _status = NO;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    //encode properties/values
    [aCoder encodeObject:self.bs forKey:@"bs"];
    [aCoder encodeBool:self.status forKey:@"status"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if((self = [super init])) {
        //decode properties/values
        _bs = [aDecoder decodeObjectForKey:@"bs"];
        self.status = [aDecoder decodeBoolForKey:@"status"];
    }
    return self;
}

@end