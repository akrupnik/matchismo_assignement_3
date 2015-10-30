//
//  SetCardViewController.m
//  Matchismo
//
//  Created by Alexander Krupnik on 27/10/15.
//  Copyright (c) 2015 Alexander Krupnik. All rights reserved.
//

#import "SetCardViewController.h"
#import "SetCardDeck.h"
#import "HistoryViewController.h"


@interface SetCardViewController ()
//@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

//@property (weak, nonatomic) IBOutlet UILabel *history;
@end

@implementation SetCardViewController

-(void) updateUI {
    [super updateUI];
    for (UIButton *cardButton  in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [[cardButton layer] setBorderWidth:1.0f];
        [cardButton setBackgroundImage:card.isMatched? [UIImage imageNamed:@"cardback"] : [UIImage imageNamed:@"cardfront"]  forState:UIControlStateNormal];
        CGColorRef borderColor = (card.isChosen) ? [UIColor redColor].CGColor :[UIColor blackColor].CGColor;
        [[cardButton layer] setBorderColor: borderColor];
    }
}

-(UIImage *) backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isMatched ? @"cardback":@"cardfront"];
}

-(NSAttributedString *) titleForCard:(Card *)card {
    NSAttributedString *emptyString = [[NSAttributedString alloc] initWithString:@"" attributes:nil];
    return card.isMatched ?  emptyString : card.contents ;
}




//- (IBAction)resetGame:(id)sender {
//}
-(Deck *) createDeck {
    return [[SetCardDeck alloc] init];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    HistoryViewController *vk = [segue destinationViewController];
    vk.messages = self.game.history;
}




@end
