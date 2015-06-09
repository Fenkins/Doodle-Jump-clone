//
//  GameViewController.m
//  Doodle Jump clone
//
//  Created by Fenkins on 09/06/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (void)Bounce {
    Ball.animationImages = [NSArray arrayWithObjects:
                            [UIImage imageNamed:@"ballSQ1.png"],
                            [UIImage imageNamed:@"ballSQ2.png"],
                            [UIImage imageNamed:@"ballSQ02.png"],
                            [UIImage imageNamed:@"ball.png"], nil];
    [Ball setAnimationRepeatCount:1];
    Ball.animationDuration = 0.2;
    [Ball startAnimating];
    
    UpMovement = 5;
}


- (void)Moving {
    Ball.center = CGPointMake(Ball.center.x, Ball.center.y - UpMovement);
    if ((CGRectIntersectsRect(Ball.frame, Platform.frame)) && (UpMovement < -2)) {
        [self Bounce];
    }
    UpMovement = UpMovement - 0.1;
}

- (IBAction)StartGame:(id)sender {
    Start.hidden = YES;
    UpMovement = -5;
    Movement = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(Moving) userInfo:nil repeats:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
