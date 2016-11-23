//
//  ScoresViewController.h
//  ColourMemory
//
//  Created by Ducere Technologies on 10/21/15.
//  Copyright © 2015 SivaCherukuri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerScoresCellTableViewCell.h"

@interface ScoresViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

-(IBAction)backButtonTapped:(id)sender;

@end
