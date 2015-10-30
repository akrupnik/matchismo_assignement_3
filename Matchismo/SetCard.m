//
//  SetCard.m
//  Matchismo
//
//  Created by Alexander Krupnik on 27/10/15.
//  Copyright (c) 2015 Alexander Krupnik. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SetCard.h"

@implementation SetCard

- (NSAttributedString *)contents {
    NSAttributedString *aspace =[[NSAttributedString alloc] initWithString:@" " attributes:nil];
    NSMutableString *str = [[NSMutableString alloc]init];
   
    for(int i= 0; i <= self.nof; i++ ) {
        [str appendString:self.suit];
    }
    
    UIColor *color;
    if (self.color == 0) {
        color = [UIColor colorWithRed:255.0/255 green:81.0/255 blue:142.0/255 alpha:1.0];
    }
    else if (self.color == 1) {
        color = [UIColor purpleColor];
    }
    else {
        color = [UIColor greenColor];
    }
    
    NSString *string = str;
    NSMutableDictionary *attrs = [@{ NSForegroundColorAttributeName : color } mutableCopy];
    
    if (self.filling == 0)
        [attrs setObject:@0
                       forKey:NSStrokeWidthAttributeName];
    if (self.filling == 1)
        [attrs setObject:@-10
                  forKey:NSStrokeWidthAttributeName];
    if (self.filling == 2)
        [attrs setObject:@-20
                  forKey:NSStrokeWidthAttributeName];
    NSAttributedString *content = [[NSAttributedString alloc] initWithString:string attributes:attrs];
    NSMutableAttributedString *contentWithSpace = [[NSMutableAttributedString alloc] initWithAttributedString:content];
    [contentWithSpace appendAttributedString:aspace];
    return contentWithSpace;
    //return content;
}


-(BOOL) isSet:(NSArray *)cards {
    BOOL isSet = YES;
    BOOL firstCondition  = NO;
    BOOL secondCondition = NO;
    BOOL thirdCondition  = NO;
    BOOL fourthCondition = NO;
  
    SetCard *card1 = cards[0];
    SetCard *card2 = cards[1];
    SetCard *card3 = cards[2];
    if( ([card1.suit isEqualToString:card2.suit] && [card1.suit isEqualToString:card3.suit]  &&
        [card2.suit isEqualToString:card3.suit]) ||
        (![card1.suit isEqualToString:card2.suit] && ![card1.suit isEqualToString:card3.suit]  &&
         ![card2.suit isEqualToString:card3.suit])) {
        
        firstCondition = YES;
    }
    
    if( (card1.nof == card2.nof && card1.nof == card3.nof  && card2.nof == card3.nof) ||
       (card1.nof != card2.nof && card1.nof != card3.nof  && card2.nof != card3.nof)) {
           
           secondCondition = YES;
    }
    
    if( (card1.color == card2.color && card1.color == card3.color  && card2.color == card3.color) ||
       (card1.color != card2.color && card1.color != card3.color  && card2.color != card3.color)) {
        
        thirdCondition = YES;
    }
    
    if( (card1.filling == card2.filling && card1.filling == card3.filling  && card2.filling == card3.filling) ||
       (card1.filling != card2.filling && card1.filling != card3.filling  && card2.filling != card3.filling) ) {
        
        fourthCondition = YES;
    }
    
    if(firstCondition && secondCondition && thirdCondition && fourthCondition) {
        isSet = YES;
    }
    else {
        isSet = NO;
    }
    return isSet;
}


+(NSArray *) validSuits {
   return @[@"△",@"☐",@"○"];
}

@end
