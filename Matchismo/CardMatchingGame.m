//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Alexander Krupnik on 21/10/15.
//  Copyright (c) 2015 Alexander Krupnik. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"
#import "SetCard.h"

#define MISMATCH_PENALTY 2;
#define MATCH_BONUS 4
#define COST_TO_CHOOSE 1;
#define SET_REWARD 20;
#define NO_SET_PENALTY 20;



@interface CardMatchingGame () {
    
}
@property(nonatomic, readwrite) NSInteger score;
@property(nonatomic,strong) NSMutableArray *cards;
@property(nonatomic,strong) NSMutableArray *chosenCards;
@property(nonatomic, readwrite) NSAttributedString *lastEvent;

@end


@implementation CardMatchingGame

-(NSMutableArray *) cards {
    if(!_cards) {
       _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}


-(NSMutableArray *) chosenCards {
    if(!_chosenCards) {
        _chosenCards = [[NSMutableArray alloc] init];
    }
    return _chosenCards;
}

-(NSMutableArray *) history {
    if (!_history) {
        _history = [[NSMutableArray alloc] init];
    }
    return _history;
}



-(void) chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    if( [card isKindOfClass:[PlayingCard class]] ) {
        NSLog(@"Playing card");
        [self playWithPlayingCard:card];
    }
    else if([card isKindOfClass:[SetCard class]]) {
        NSLog(@"Set card");
        [self playWithSetCard:card];
    }
    else {
        //for more games
    }
}


-(void) addEventDescriptionToHistory:(NSString *) message description1:(NSAttributedString *) descr1 description2:

    (NSAttributedString *) descr2 decsription3:(NSAttributedString *) descr3  {
    NSAttributedString *empty =[[NSAttributedString alloc] initWithString:@"" attributes:nil];
    NSMutableAttributedString *eventDescription = [[NSMutableAttributedString alloc] initWithAttributedString:empty];
    [eventDescription appendAttributedString:descr1];
    if(descr2) [eventDescription appendAttributedString:descr2];
    if (descr3) [eventDescription appendAttributedString:descr3];
    NSAttributedString *msg = [[NSAttributedString alloc] initWithString:message attributes:nil];
    [eventDescription appendAttributedString:msg];
    self.lastEvent = eventDescription;
    [self.history addObject:eventDescription];
    [self addScoreToHistory:self.score];
    
}

-(void) addScoreToHistory:(NSUInteger) score {
    NSString *message = [NSString stringWithFormat:@"Score: %d",(int)score];
    NSAttributedString *amessage = [[NSAttributedString alloc] initWithString:message attributes:nil];
    [self.history addObject:amessage];
}

-(void) playWithSetCard:(Card *) card {
     if(!card.isMatched) {
        if (!card.isChosen) {
            card.chosen = YES;
            self.score -= COST_TO_CHOOSE;
            [self.chosenCards addObject:card];
            [self addEventDescriptionToHistory:@" is chosen" description1:card.contents description2:nil decsription3:nil];
            if ([self.chosenCards count] == 3) {
                
                BOOL isSet = [card isSet:self.chosenCards];
                if(isSet) {
                    for(Card *card in self.chosenCards) {
                        card.matched = YES;
                    }
                    self.score += SET_REWARD;
                    [self addEventDescriptionToHistory:@" are SET" description1:((Card *)self.chosenCards[0]).contents description2:((Card *)self.chosenCards[1]).contents decsription3:((Card *)self.chosenCards[2]).contents];
                    [self.chosenCards removeAllObjects];
                }
                else {
                    for(Card *card in self.chosenCards) {
                        card.chosen = NO;
                    }
                    self.score -= NO_SET_PENALTY;
                    [self addEventDescriptionToHistory:@" are not SET" description1:((Card *)self.chosenCards[0]).contents description2:((Card *)self.chosenCards[1]).contents decsription3:((Card *)self.chosenCards[2]).contents];
                    [self.chosenCards removeAllObjects];
                }
            }
        }
        else {
            // remove card from chosenCards array;
            for(Card *cardchosen in self.chosenCards) {
                if (cardchosen == card) {
                    [self.chosenCards removeObject:cardchosen];
                    card.chosen = NO;
                    NSLog(@"chosen cards after remove =%lu",[self.chosenCards count]);
                    break;
                }
            }
        }
    }
}

-(void) playWithPlayingCard:(Card *) card {
    if(self.matchingCards == 2) {
        if(!card.isMatched) {
            if(card.isChosen) {
                [self addEventDescriptionToHistory:@"flipped" description1:card.contents description2:nil decsription3:nil];
                card.chosen = NO; //flip card if it is chosen but do not match
            }
            else {
                
                self.score -= COST_TO_CHOOSE;
                [self addEventDescriptionToHistory:@"is chosen" description1:card.contents description2:nil decsription3:nil];
                for (Card *otherCard in self.cards ){
                    if( otherCard.isChosen && !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        if(matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            card.matched = YES;
                            otherCard.matched = YES;
                            [self addEventDescriptionToHistory:@"are matched" description1:card.contents description2:otherCard.contents decsription3:nil];
                        }
                        else {
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                            [self addEventDescriptionToHistory:@"do not match" description1:card.contents description2:otherCard.contents decsription3:nil];
                        }
                        break;
                    }
                }
                card.chosen = YES;
            }
        }
    }
   
}


-(NSArray *) findTwoCardsToCompare {
    NSMutableArray *cardsToCompare = [[NSMutableArray alloc] init];
    for (Card *card in self.cards) {
        if(card.isChosen && !card.isMatched){
            [cardsToCompare addObject:card];
        }
    }
    return cardsToCompare;
}


-(instancetype) initWithCardCount:(NSUInteger) count usingDeck:(Deck *) deck {
    self = [super init];
    if(self) {
        for(int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if(card) {
                [self.cards addObject:card];            }
            else {
               self = nil;
               break;
            }
        }
        
    }
    return self;
}

-(Card *) cardAtIndex:(NSUInteger) index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
