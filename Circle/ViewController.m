//
//  ViewController.m
//  Circle
//
//  Created by Andrew Liu on 4/8/15.
//  Copyright (c) 2015 Andrew Liu. All rights reserved.
//

#import "ViewController.h"
#import "Player.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *survivorLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)clearTextOnButtonPressed:(UIButton *)sender
{
    self.textField.text = @"";
}

- (IBAction)beginBattlesOnButtonPressed:(UIButton *)sender
{
    [self.textField resignFirstResponder];
    
    self.arrayOfSurvivors = [NSMutableArray array];
    self.isLastPlayerLeaving = NO;
    
    if ([self.textField.text isEqualToString:@"0"])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                                                       message:@"0 is not a valid number"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *OK = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action) {
                                                       self.textField.text = @"";
                                                   }];
        [alert addAction:OK];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        //define number of players
        NSInteger numberOfPlayers = [self.textField.text integerValue];
        
        //assign chair number
        for (int i =0; i < numberOfPlayers; i++)
        {
            NSNumber *chairNumber = [NSNumber numberWithInt:i+1];
            Player *player = [[Player alloc]initWithNumber:chairNumber];
            [self.arrayOfSurvivors addObject:player];
        }
        
        self.arrayOfSurvivors = [self letTheBattlesBegin:self.arrayOfSurvivors];
        
        self.survivorLabel.text = [NSString stringWithFormat:@"Player %@", [self.arrayOfSurvivors.firstObject chairNumber]];
    }
}

- (NSMutableArray *)letTheBattlesBegin:(NSMutableArray *)arrayOfSurvivors
{
    //ask player to leave
    NSMutableArray *arrayToBeRemoved = [NSMutableArray array];

    if (arrayOfSurvivors.count != 1)
    {
        if (self.isLastPlayerLeaving)
        {
            //first player on the next round should skipped
            for (Player *player in arrayOfSurvivors)
            {
                NSUInteger index = [arrayOfSurvivors indexOfObject:player];
                int i = index+1;
                if (i%2 == 0)
                {
                    player.isAskedToLeave = YES;
                    NSLog(@"player %@ is asked to leave", [player chairNumber]);
                    [arrayToBeRemoved addObject:player];
                }
                else
                {
                    NSLog(@"player %@ is staying for next round", [player chairNumber]);
                }
                if (i == arrayOfSurvivors.count)
                {
                    self.isLastPlayerLeaving = player.isAskedToLeave;
                }
            }
            [arrayOfSurvivors removeObjectsInArray:arrayToBeRemoved];
            if (arrayOfSurvivors.count != 1)
            {
                [self letTheBattlesBegin:arrayOfSurvivors];
            }
        }
        else
        {
            //first player on the next round should leave
            for (Player *player in arrayOfSurvivors)
            {
                NSUInteger index = [arrayOfSurvivors indexOfObject:player];
                int i = index+1;
                if (i%2 == 1)
                {
                    player.isAskedToLeave = YES;
                    [arrayToBeRemoved addObject:player];
                    NSLog(@"player %@ is asked to leave", [player chairNumber]);
                }
                else
                {
                    NSLog(@"player %@ is staying for next round", [player chairNumber]);
                }
                if (i == arrayOfSurvivors.count)
                {
                    self.isLastPlayerLeaving = player.isAskedToLeave;
                }
            }
            [arrayOfSurvivors removeObjectsInArray:arrayToBeRemoved];
            if (arrayOfSurvivors.count != 1)
            {
                [self letTheBattlesBegin:arrayOfSurvivors];
            }
        }
    }
    NSLog(@"winner is player %@", [arrayOfSurvivors.firstObject chairNumber]);
    return arrayOfSurvivors;
}



@end
