//
//  SetCard.h
//  Matchismo
//
//  Created by Alexander Krupnik on 27/10/15.
//  Copyright (c) 2015 Alexander Krupnik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface SetCard : Card

@property(strong, nonatomic) NSString *suit;
@property (nonatomic) int nof;
@property(nonatomic) int color;
@property(nonatomic) int filling;

+(NSArray *) validSuits;

@end
