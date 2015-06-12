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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    StopSideMovement = NO;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if (point.x < screenWidth/2){
        BallLeft = YES;
    } else {
        BallRight = YES;
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    BallLeft = NO;
    BallRight = NO;
    StopSideMovement = YES;
}

- (void)PlatformMovement{

    Platform2.center = CGPointMake(Platform2.center.x + Platform2SideMovement, Platform2.center.y);
    Platform4.center = CGPointMake(Platform4.center.x + Platform4SideMovement, Platform4.center.y);
    if (Platform2.center.x >=  screenWidth-(Platform2.bounds.size.width/2) || Platform2.center.x <= 0+(Platform2.bounds.size.width/2)) {
        Platform2SideMovement *= -1;
    } else if (Platform4.center.x >= screenWidth-(Platform4.bounds.size.width/2) || Platform4.center.x <= 0+(Platform4.bounds.size.width/2)) {
        Platform4SideMovement *= -1;
    }
}


- (void)Bounce {
    Ball.animationImages = [NSArray arrayWithObjects:
                            [UIImage imageNamed:@"ballSQ1.png"],
                            [UIImage imageNamed:@"ballSQ2.png"],
                            [UIImage imageNamed:@"ballSQ1s.png"],
                            [UIImage imageNamed:@"ball.png"], nil];
    [Ball setAnimationRepeatCount:1];
    Ball.animationDuration = 0.2;
    [Ball startAnimating];
    
    UpMovement = 5;
}


- (void)Moving {
    if (BallLeft == YES){
        SideMovement -= MovingConstant * 3;
        if (SideMovement <= -5) {
            SideMovement = 5;
        }
        if (Ball.center.x <= Ball.bounds.size.width/2){
            Ball.center = CGPointMake(screenWidth-(Ball.bounds.size.width/2), Ball.center.y);
        }
    }
    if (BallRight == YES){
        SideMovement += MovingConstant * 3;
        if (SideMovement >= 5) {
            SideMovement = 5;
        }
        if (Ball.center.x >= (screenWidth - Ball.bounds.size.width/2)){
            Ball.center = CGPointMake(Ball.bounds.size.width/2, Ball.center.y);
        }
    }
    if (StopSideMovement == YES && SideMovement > 0) {
        SideMovement -= MovingConstant;
        if (SideMovement < 0){
            SideMovement = 0;
        }
    } else if (StopSideMovement == YES && SideMovement < 0) {
        SideMovement += MovingConstant;
        if (SideMovement > 0){
            SideMovement = 0;
        }
    }
    [self PlatformMovement];
    
    Ball.center = CGPointMake(Ball.center.x + SideMovement, Ball.center.y - UpMovement);
    if ((CGRectIntersectsRect(Ball.frame, Platform.frame)) && (UpMovement < -2)) {
        [self Bounce];
    }
    UpMovement = UpMovement - 0.1;
}

- (IBAction)StartGame:(id)sender {
    Start.hidden = YES;
    Platform1.hidden = NO;
    Platform2.hidden = NO;
    Platform3.hidden = NO;
    Platform4.hidden = NO;
    
    UpMovement = -5;
    Movement = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(Moving) userInfo:nil repeats:YES];
    
    // Generating random position (between 36 and 284)
    RandomPosition = arc4random()%248;
    RandomPosition += Platform1.bounds.size.width/2;
    Platform1.center = CGPointMake(RandomPosition, 448);
    RandomPosition = arc4random()%248;
    RandomPosition += Platform2.bounds.size.width/2;
    Platform2.center = CGPointMake(RandomPosition, 336);
    RandomPosition = arc4random()%248;
    RandomPosition += Platform3.bounds.size.width/2;
    Platform3.center = CGPointMake(RandomPosition, 224);
    RandomPosition = arc4random()%248;
    RandomPosition += Platform4.bounds.size.width/2;
    Platform4.center = CGPointMake(RandomPosition, 112);
    
    Platform2SideMovement = 2;
    Platform4SideMovement = -2;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Platform1.hidden = YES;
    Platform2.hidden = YES;
    Platform3.hidden = YES;
    Platform4.hidden = YES;
    // Just wonna know screen width
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
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
