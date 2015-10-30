//
//  HistoryViewController.h
//  Matchismo
//
//  Created by Alexander Krupnik on 29/10/15.
//  Copyright (c) 2015 Alexander Krupnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *gameHistory;
@property(strong,nonatomic) NSArray *messages;
@property(strong,nonatomic) NSAttributedString *message;

@end
