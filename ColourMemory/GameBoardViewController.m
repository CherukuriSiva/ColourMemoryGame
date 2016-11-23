//
//  GameBoardViewController.m
//  ColourMemory
//
//  Created by Ducere Technologies on 10/21/15.
//  Copyright © 2015 SivaCherukuri. All rights reserved.
//

#import "GameBoardViewController.h"
#import "ScoresViewController.h"
#import "CoreDataManager.h"

@interface GameBoardViewController ()

@end

@implementation GameBoardViewController

@synthesize button1, button2, button3, button4, button5;
@synthesize button6, button7, button8, button9, button10;
@synthesize button11, button12, button13, button14, button15, button16;
@synthesize scoreLabel;

NSMutableArray *colorCards;
NSMutableArray *repeated;
NSMutableString *currentScore;
NSString *colorIntent1;
NSString *colorIntent2;

int tagButton1 = 0;
int tagButton2 = 0;
int intents = 0;
int totalCards = 16;
int numberCardsControl = 16;
int randd = 0;
int score = 0;

@synthesize nameTextField, messageView, messageLabel;

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    /* Initializing arrays */
    colorCards = [[NSMutableArray alloc] initWithCapacity:16];
    repeated   = [[NSMutableArray alloc] initWithCapacity:16];
    currentScore = [[NSMutableString alloc] init];
    nameTextField.delegate = self;
    
    /* Creation of Cards */
    [self initCards];
    scoreLabel.text = @"Score: 0";
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)selectedCard:(id)sender {
    
    intents++;
    
    if(intents == 1){
        for (int i=0; i<colorCards.count; i++) {
            if([sender tag]==[[colorCards objectAtIndex:i] getButtonNumber]){
                
                colorIntent1 = [[colorCards objectAtIndex:i] getColorCard];
                [sender setImage:[[colorCards objectAtIndex:i] getImageColor] forState:UIControlStateNormal];
            }
        }
        tagButton1 = [sender tag];
    }
    
    /* This method calls... on click of cards*/
    
    if(intents == 2){
        
        for (int i=0; i<colorCards.count; i++) {
            if([sender tag]==[[colorCards objectAtIndex:i] getButtonNumber]){
                [sender setImage:[[colorCards objectAtIndex:i] getImageColor] forState:UIControlStateNormal];
                colorIntent2 = [[colorCards objectAtIndex:i] getColorCard];
            }
        }
        tagButton2 = [sender tag];
        
        intents = 0;
        
        /* Add 2 points in the score */
        
        if([colorIntent1 isEqualToString:colorIntent2]){
            score = score + 2;
            [currentScore setString:@""];
            [currentScore appendString:@"score: "];
            [currentScore appendFormat:@"%d", score];
            scoreLabel.text = currentScore;
            
            [self removeButton1];
            [self removeButton2];
            
            numberCardsControl = numberCardsControl - 2;
            
            /* The game ends and the message view is displayed to enter the player's name */
            
            if(numberCardsControl<=0){
                
                self.messageView.hidden = NO;
                numberCardsControl = 16;
            }
        }
        
        /* subtract 1 point */
        
        else{
            score = score - 1;
            [currentScore setString:@""];
            [currentScore appendString:@"score: "];
            [currentScore appendFormat:@"%d", score];
            scoreLabel.text = currentScore;
            
            /* Flip the cards */
            
            [self performSelector:@selector(resetButtons2) withObject:@"" afterDelay:0.8f];
            [self performSelector:@selector(resetButtons1) withObject:@"" afterDelay:0.8f];
        }
        
    }
}

- (IBAction)sendData:(id)sender {
    
    /* This method sends data to the coredatabase*/
    
    if(![nameTextField.text  isEqualToString: @""]){
        
        NSMutableString *aux = [[NSMutableString alloc] init];
        [aux appendFormat:@"%d", score];
        
        [[CoreDataManager sharedManager] addScoresDetails:nameTextField.text withScore:aux];
        
        [self.nameTextField resignFirstResponder];
        
        self.messageView.hidden = YES;
    }
}

/* This method verifies that a assigned values will not be repeated*/

- (bool) isRepeated: (int) randd{
    
    for(int i=0; i<[repeated count];i++){
        if(randd == [[repeated objectAtIndex:i] integerValue]){
            return true;
        }
    }
    [repeated addObject:[NSNumber numberWithInt:randd]];
    return false;
}


/* Assign random number */
- (int) getRandNumber{
    int randd = 0;
    do {
        randd = arc4random() % totalCards;
    }while ([self isRepeated:randd]);
    if(randd == 0){
        randd = 16;
    }
    
    return randd;
}

- (void) resetButtons1 {
    switch (tagButton1) {
        case 1:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button1 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 2:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button2 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 3:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button3 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 4:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button4 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 5:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button5 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        case 6:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button6 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        case 7:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button7 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        case 8:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button8 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        case 9:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button9 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        case 10:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button10 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 11:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button11 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 12:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button12 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 13:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button13 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 14:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button14 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 15:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button15 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 16:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button16 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        default:
            break;
    }
}

- (void) resetButtons2 {
    switch (tagButton2) {
        case 1:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button1 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 2:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button2 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 3:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button3 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 4:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button4 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 5:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button5 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        case 6:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button6 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        case 7:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button7 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        case 8:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button8 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        case 9:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button9 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        case 10:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button10 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 11:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button11 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 12:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button12 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 13:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button13 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 14:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button14 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 15:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button15 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
        case 16:{
            dispatch_async(dispatch_get_main_queue(),^{
                [button16 setImage:[UIImage imageNamed:@"card_bg.png"] forState:UIControlStateNormal];
            });
        }
            break;
            
        default:
            break;
    }
}

- (void) removeButton1{
    switch (tagButton1) {
        case 1:
            button1.alpha = 0;
            break;
        case 2:
            button2.alpha = 0;
            break;
        case 3:
            button3.alpha = 0;
            break;
        case 4:
            button4.alpha = 0;
            break;
        case 5:
            button5.alpha = 0;
            break;
        case 6:
            button6.alpha = 0;
            break;
        case 7:
            button7.alpha = 0;
            break;
        case 8:
            button8.alpha = 0;
            break;
        case 9:
            button9.alpha = 0;
            break;
        case 10:
            button10.alpha = 0;
            break;
        case 11:
            button11.alpha = 0;
            break;
        case 12:
            button12.alpha = 0;
            break;
        case 13:
            button13.alpha = 0;
            break;
        case 14:
            button14.alpha = 0;
            break;
        case 15:
            button15.alpha = 0;
            break;
        case 16:
            button16.alpha = 0;
            break;
            
        default:
            break;
    }
    
}

- (void) removeButton2{
    switch (tagButton2) {
        case 1:
            button1.alpha = 0;
            break;
        case 2:
            button2.alpha = 0;
            break;
        case 3:
            button3.alpha = 0;
            break;
        case 4:
            button4.alpha = 0;
            break;
        case 5:
            button5.alpha = 0;
            break;
        case 6:
            button6.alpha = 0;
            break;
        case 7:
            button7.alpha = 0;
            break;
        case 8:
            button8.alpha = 0;
            break;
        case 9:
            button9.alpha = 0;
            break;
        case 10:
            button10.alpha = 0;
            break;
        case 11:
            button11.alpha = 0;
            break;
        case 12:
            button12.alpha = 0;
            break;
        case 13:
            button13.alpha = 0;
            break;
        case 14:
            button14.alpha = 0;
            break;
        case 15:
            button15.alpha = 0;
            break;
        case 16:
            button16.alpha = 0;
            break;
            
        default:
            break;
    }
}

- (void) initCards{
    
    /* This method initializes the cards objects , setting the colors to images that will contain and which will be assigned uibutton */
    
    Cards *card1 = [[Cards alloc] init];
    Cards *card2 = [[Cards alloc] init];
    [card1 setImageColor: [UIImage imageNamed:@"colour1.png"]];
    [card1 setColor:@"black"];
    [card2 setImageColor: [UIImage imageNamed:@"colour1.png"]];
    [card2 setColor:@"black"];
    [card1 setButtonNumber: [self getRandNumber]];
    [card2 setButtonNumber: [self getRandNumber]];
    [colorCards addObject:card1];
    [colorCards addObject:card2];
    
    Cards *card3 = [[Cards alloc] init];
    Cards *card4 = [[Cards alloc] init];
    [card3 setImageColor: [UIImage imageNamed:@"colour2.png"]];
    [card3 setColor:@"white"];
    [card4 setImageColor: [UIImage imageNamed:@"colour2.png"]];
    [card4 setColor:@"white"];
    [card3 setButtonNumber:[self getRandNumber]];
    [card4 setButtonNumber:[self getRandNumber]];
    [colorCards addObject:card3];
    [colorCards addObject:card4];
    
    Cards *card5 = [[Cards alloc] init];
    Cards *card6 = [[Cards alloc] init];
    [card5 setImageColor: [UIImage imageNamed:@"colour3.png"]];
    [card5 setColor:@"blue"];
    [card6 setImageColor: [UIImage imageNamed:@"colour3.png"]];
    [card6 setColor:@"blue"];
    [card5 setButtonNumber:[self getRandNumber]];
    [card6 setButtonNumber:[self getRandNumber]];
    [colorCards addObject:card5];
    [colorCards addObject:card6];
    
    Cards *card7 = [[Cards alloc] init];
    Cards *card8 = [[Cards alloc] init];
    [card7 setImageColor: [UIImage imageNamed:@"colour4.png"]];
    [card7 setColor:@"brown"];
    [card8 setImageColor: [UIImage imageNamed:@"colour4.png"]];
    [card8 setColor:@"brown"];
    [card7 setButtonNumber:[self getRandNumber]];
    [card8 setButtonNumber:[self getRandNumber]];
    [colorCards addObject:card7];
    [colorCards addObject:card8];
    
    Cards *card9 = [[Cards alloc] init];
    Cards *card10 = [[Cards alloc] init];
    [card9 setImageColor: [UIImage imageNamed:@"colour5.png"]];
    [card9 setColor:@"green"];
    [card10 setImageColor: [UIImage imageNamed:@"colour5.png"]];
    [card10 setColor:@"green"];
    [card9 setButtonNumber:[self getRandNumber]];
    [card10 setButtonNumber:[self getRandNumber]];
    [colorCards addObject:card9];
    [colorCards addObject:card10];
    
    Cards *card11 = [[Cards alloc] init];
    Cards *card12 = [[Cards alloc] init];
    [card11 setImageColor: [UIImage imageNamed:@"colour6.png"]];
    [card11 setColor:@"purple"];
    [card12 setImageColor: [UIImage imageNamed:@"colour6.png"]];
    [card12 setColor:@"purple"];
    [card11 setButtonNumber:[self getRandNumber]];
    [card12 setButtonNumber:[self getRandNumber]];
    [colorCards addObject:card11];
    [colorCards addObject:card12];
    
    Cards *card13 = [[Cards alloc] init];
    Cards *card14 = [[Cards alloc] init];
    [card13 setImageColor: [UIImage imageNamed:@"colour7.png"]];
    [card13 setColor:@"red"];
    [card14 setImageColor: [UIImage imageNamed:@"colour7.png"]];
    [card14 setColor:@"red"];
    [card13 setButtonNumber:[self getRandNumber]];
    [card14 setButtonNumber:[self getRandNumber]];
    [colorCards addObject:card13];
    [colorCards addObject:card14];
    
    Cards *card15 = [[Cards alloc] init];
    Cards *card16 = [[Cards alloc] init];
    [card15 setImageColor: [UIImage imageNamed:@"colour8.png"]];
    [card15 setColor:@"yellow"];
    [card16 setImageColor: [UIImage imageNamed:@"colour8.png"]];
    [card16 setColor:@"yellow"];
    [card15 setButtonNumber:[self getRandNumber]];
    [card16 setButtonNumber:[self getRandNumber]];
    [colorCards addObject:card15];
    [colorCards addObject:card16];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)highScoresButtonTapped:(id)sender{
    ScoresViewController* scoresView = [ScoresViewController new];
    [self presentViewController:scoresView animated:YES completion:nil];
}
@end

