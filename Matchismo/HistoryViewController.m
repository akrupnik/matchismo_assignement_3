//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Alexander Krupnik on 29/10/15.
//  Copyright (c) 2015 Alexander Krupnik. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    NSAttributedString *cr = [[NSAttributedString alloc] initWithString: @"\n"];
    NSMutableAttributedString *gamehistory = [[NSMutableAttributedString alloc] initWithString:@""];
    for ( NSAttributedString *message in self.messages){
        [gamehistory appendAttributedString:message];
        [gamehistory appendAttributedString:cr];
    }
    self.gameHistory.attributedText = gamehistory;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
