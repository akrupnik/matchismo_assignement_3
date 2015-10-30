//
//  CommonCardViewController.m
//  Matchismo
//
//  Created by Alexander Krupnik on 27/10/15.
//  Copyright (c) 2015 Alexander Krupnik. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"
#import "HistoryViewController.h"

@interface PlayingCardViewController ()

@end

@implementation PlayingCardViewController

-(Deck *) createDeck {
    return [[PlayingCardDeck alloc] init];
}

-(UIImage *) backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront":@"cardback"];
}

-(NSAttributedString *) titleForCard:(Card *)card {
    NSAttributedString *emptyString = [[NSAttributedString alloc] initWithString:@"" attributes:nil];
    return card.isChosen ? card.contents : emptyString;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    HistoryViewController *vk = [segue destinationViewController];
    vk.messages = self.game.history;
}

@end


