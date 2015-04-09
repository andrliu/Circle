//
//  Player.h
//  Circle
//
//  Created by Andrew Liu on 4/8/15.
//  Copyright (c) 2015 Andrew Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property NSNumber *chairNumber;
@property BOOL isAskedToLeave;

-(instancetype)initWithNumber:(NSNumber *)number;

@end
