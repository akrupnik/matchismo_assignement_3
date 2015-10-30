//
//  ViewController.h
//  Matchismo
//
//  Created by Alexander Krupnik on 20/10/15.
//  Copyright (c) 2015 Alexander Krupnik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property(strong, nonatomic) CardMatchingGame *game;
-(Deck *) createDeck;// to be implemented in subclass
-(void) updateUI;
@end

