//
//  LandingPageViewController.m
//  ColourMemory
//
//  Created by Ducere Technologies on 10/21/15.
//  Copyright © 2015 SivaCherukuri. All rights reserved.
//

#import "LandingPageViewController.h"
#import "GameBoardViewController.h"

@interface LandingPageViewController ()

@end

@implementation LandingPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)startGameButtonTapped:(id)sender{
    GameBoardViewController* gameBoardView = [GameBoardViewController new];
    [self presentViewController:gameBoardView animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
