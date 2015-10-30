//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Alexander Krupnik on 27/10/15.
//  Copyright (c) 2015 Alexander Krupnik. All rights reserved.
//


#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

-(instancetype) init {
    self = [super init];
    if(self) {
        int rank = (int)[[SetCard validSuits] count];
        for(NSString *suit in [SetCard validSuits] ) {
            for (int color = 0; color < rank; color++) {
                for( int nof = 0; nof < rank; nof++) {
                    for(int filling = 0; filling < rank; filling++ ) {
                         SetCard *card = [[SetCard alloc] init];
                         card.matched = NO;
                         card.color = color;
                         card.nof = nof;
                         card.suit = suit;
                         card.filling = filling;
                         card.chosen = NO;
                         [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}


-(BOOL) isSet:(NSArray *) cards {
    BOOL isSet = YES;
    
    
    return isSet;
    
    
}
@end
