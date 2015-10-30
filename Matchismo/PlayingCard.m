//
//  PlayingCard.m
//  Matchismo
//
//  Created by Alexander Krupnik on 21/10/15.
//  Copyright (c) 2015 Alexander Krupnik. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "PlayingCard.h"

@implementation PlayingCard


- (NSAttributedString *)contents {
    NSAttributedString *aspace =[[NSAttributedString alloc] initWithString:@" " attributes:nil];
    NSDictionary *redAttr = @{NSForegroundColorAttributeName: [UIColor redColor]};
    NSDictionary *blackAttr = @{NSForegroundColorAttributeName: [UIColor blackColor]};
    NSArray *rankStrings = [PlayingCard rankStrings];
    NSString *str = [rankStrings[self.rank] stringByAppendingString:self.suit];
    NSAttributedString *content;
    if ([self.suit isEqualToString:@"♦︎"] || [self.suit isEqualToString:@"♥︎"]) {
        content = [[NSAttributedString alloc] initWithString:str attributes:redAttr];
    }
    else {
        content = [[NSAttributedString alloc] initWithString:str attributes:blackAttr];
    }
    NSMutableAttributedString *contentWithSpace = [[NSMutableAttributedString alloc] initWithAttributedString:content];
    [contentWithSpace appendAttributedString:aspace];
    return contentWithSpace;
}


-(int) match:(NSArray *)otherCards {
    int score = 0;
    if([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if([self.suit isEqualToString:otherCard.suit]) {
            score = 1;
        }
        else if (self.rank == otherCard.rank) {
            score = 4;
        }
    }
    else if([otherCards count] == 2) {
        score = 0;
        int suitMatch = 0;
        int rankMatch = 0;
        NSMutableArray *allToCompare = [[NSMutableArray alloc] initWithArray:otherCards];
        [allToCompare addObject:self];
        
        for (int i = 0; i < 3 ; i++ ) {
            for (int j=i+1; j < 3; j++) {
                if( [((PlayingCard *)allToCompare[i]).suit isEqualToString:
                    ((PlayingCard *)allToCompare[j]).suit] ) {
                    score += (suitMatch) ? 1 : 4;
                    suitMatch++;
                }
                else if ( ((PlayingCard *)allToCompare[i]).rank == ((PlayingCard *)allToCompare[j]).rank ) {
                    score += (rankMatch) ? 4 : 16;
                    rankMatch++;
                }
            }
        }
    }
    return score;
}


+(NSArray *) rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",
             @"8",@"9",@"10",@"J",@"Q",@"K"];
}


+(NSArray *) validSuits {
    return @[@"♣︎",@"♠︎",@"♦︎",@"♥︎"];
}

+(NSUInteger) maxRank {
    return [[PlayingCard rankStrings] count] -1;
}


@end
