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
    
    NSTimer *Movement;
}

- (IBAction)StartGame:(id)sender;
- (void)Moving;
- (void)Bounce;
- (void)PlatformMovement;
- (void)PlatformDropDown;

@end
