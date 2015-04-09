//
//  Player.m
//  Circle
//
//  Created by Andrew Liu on 4/8/15.
//  Copyright (c) 2015 Andrew Liu. All rights reserved.
//

#import "Player.h"

@implementation Player

- (instancetype)initWithNumber:(NSNumber *)number
{
    self = [super init];
    if (self) {
        self.chairNumber = number;
        self.isAskedToLeave = NO;
    }
    return self;
}

@end
