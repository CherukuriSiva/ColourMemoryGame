//
//  PlayerScoresCellTableViewCell.h
//  ColourMemory
//
//  Created by Ducere Technologies on 10/21/15.
//  Copyright © 2015 SivaCherukuri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerScoresCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *positionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *namesLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoresLabel;
@end
