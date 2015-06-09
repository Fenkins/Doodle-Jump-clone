//
//  GameViewController.h
//  Doodle Jump clone
//
//  Created by Fenkins on 09/06/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

#import <UIKit/UIKit.h>

float UpMovement;

@interface GameViewController : UIViewController
{
    IBOutlet UIButton *Start;
    IBOutlet UIImageView *Ball;
    IBOutlet UIImageView *Platform;
    
    NSTimer *Movement;
}

- (IBAction)StartGame:(id)sender;
- (void)Moving;
- (void)Bounce;

@end
