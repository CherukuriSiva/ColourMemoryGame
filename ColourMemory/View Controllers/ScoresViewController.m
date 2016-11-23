//
//  ScoresViewController.m
//  ColourMemory
//
//  Created by Ducere Technologies on 10/21/15.
//  Copyright © 2015 SivaCherukuri. All rights reserved.
//

#import "ScoresViewController.h"
#import "CoreDataManager.h"
#import "ScoresDetails.h"

@interface ScoresViewController (){
    NSArray* scoreDetailsArray;
}
@end

@implementation ScoresViewController

NSMutableArray *arrayName;
NSMutableArray *arrayScore;
NSMutableArray *arrayPosition;
UIActivityIndicatorView *activityIndicator;
int total = 0;
int positions[50];

@synthesize myTableView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.alpha = 1.0;
    activityIndicator.center = CGPointMake(160, 240);
    activityIndicator.hidesWhenStopped = NO;
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    
    arrayName = [[NSMutableArray alloc] initWithCapacity:50];
    arrayScore = [[NSMutableArray alloc] initWithCapacity:50];
    arrayPosition = [[NSMutableArray alloc] initWithCapacity:50];
    
    scoreDetailsArray = [[CoreDataManager sharedManager] getScoresDetails];
    
    total = scoreDetailsArray.count;
    
    for(int i = 0; i < scoreDetailsArray.count; i++){
        ScoresDetails* scoresObj = scoreDetailsArray[i];
        
        [arrayName addObject:scoresObj.name];
        [arrayScore addObject:scoresObj.score];
        [arrayPosition addObject:scoresObj.score];
        positions[i] = i;
        
    }
    
    [[self myTableView] setDataSource:self];
    [[self myTableView] setDelegate:self];
    [myTableView reloadData];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return total;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"PlayerScoresCellTableViewCell";
    
    PlayerScoresCellTableViewCell *cell = (PlayerScoresCellTableViewCell *)[self.myTableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PlayerScoresCellTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSMutableString *currentScore = [[NSMutableString alloc] init];
    [currentScore setString:@""];
    [currentScore appendFormat:@"%d", positions[indexPath.item]];
    
    cell.namesLabel.text = [arrayName objectAtIndex:indexPath.item];
    cell.scoresLabel.text = [arrayScore objectAtIndex:indexPath.item];
    cell.positionsLabel.text = currentScore;
    
    return cell;
    
}

-(IBAction)backButtonTapped:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
