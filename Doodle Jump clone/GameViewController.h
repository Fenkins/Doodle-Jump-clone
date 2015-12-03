//
//  GameViewController.h
//  Doodle Jump clone
//
//  Created by Fenkins on 09/06/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

#import <UIKit/UIKit.h>

float UpMovement;
int RandomPosition;
int Platform2SideMovement;
int Platform4SideMovement;

float SideMovement;
BOOL BallLeft;
BOOL BallRight;
BOOL StopSideMovement;

float PlatformDropDownFor;

float const MovingConstant = 0.1;

int ScoreNumber;
int HighScoreNumber;
int AddedScore;
int LevelNumber;

BOOL PlatformUsed;
BOOL Platform1Used;
BOOL Platform2Used;
BOOL Platform3Used;
BOOL Platform4Used;


CGFloat screenWidth;
CGFloat screenHeight;


@interface GameViewController : UIViewController
{
    IBOutlet UIButton *Start;
    IBOutlet UIImageView *Ball;
    IBOutlet UIImageView *Platform;
    IBOutlet UIImageView *Platform1;
    IBOutlet UIImageView *Platform2;
    IBOutlet UIImageView *Platform3;
    IBOutlet UIImageView *Platform4;
    
    IBOutlet UILabel *Score;
    IBOutlet UILabel *GameOver;
    IBOutlet UILabel *FinalScore;
    IBOutlet UILabel *HighScore;
    IBOutlet UIButton *RestartGameOut;
    
    IBOutlet UIButton *controlSwitchOutlet;
    
    NSTimer *Movement;
}

- (IBAction)StartGame:(id)sender;
- (IBAction)controlSwitchButton:(id)sender;
- (void)Moving;
- (void)Bounce;
- (void)PlatformMovement;
- (void)PlatformDropDown;
- (void)Scoring;
- (void)GameOver;

@end
