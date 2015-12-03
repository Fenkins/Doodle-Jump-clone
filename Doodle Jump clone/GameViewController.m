//
//  GameViewController.m
//  Doodle Jump clone
//
//  Created by Fenkins on 09/06/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
@property (nonatomic) BOOL controlSwitched;
@property (nonatomic) CMMotionManager *motionManager;
@end

@implementation GameViewController
-(void) GameOver {
    Ball.hidden = YES;
    Platform.hidden = YES;
    Platform1.hidden = YES;
    Platform2.hidden = YES;
    Platform3.hidden = YES;
    Platform4.hidden = YES;
    Score.hidden = YES;
    GameOver.hidden = NO;
    RestartGameOut.hidden = NO;
    FinalScore.hidden = NO;
    
    FinalScore.text = [NSString stringWithFormat:@"Final score is %i", ScoreNumber];
    [Movement invalidate];
    if (ScoreNumber > HighScoreNumber) {
        HighScoreNumber = ScoreNumber;
        [[NSUserDefaults standardUserDefaults] setInteger:ScoreNumber forKey:@"HighScoreSaved"];
        HighScore.hidden = NO;
    }
    UpMovement = 0;
    SideMovement = 0;
}

-(void) Scoring {
    // We raising a score as the ball goes higher scoring is ticking with Moving method
    ScoreNumber += AddedScore;
    AddedScore -= 1;
    if (AddedScore < 0) {
        AddedScore = 0;
    }
    Score.text = [NSString stringWithFormat:@"%i", ScoreNumber];
    
    if (ScoreNumber > (screenHeight + Ball.bounds.size.height) && ScoreNumber < 1000) {
        LevelNumber = 2;
    }
    if (ScoreNumber/LevelNumber > 500) {
        LevelNumber += 1;
    }

}

- (void) PlatformDropDown {
    if (Ball.center.y > 500.0) {
        PlatformDropDownFor = 1.0;
    }
    if (Ball.center.y > 450.0) {
        PlatformDropDownFor = 2.0;
    }
    if (Ball.center.y > 400.0) {
        PlatformDropDownFor = 4.0;
    }
    if (Ball.center.y > 300.0) {
        PlatformDropDownFor = 5.0;
    }
    if (Ball.center.y > 250.0) {
        PlatformDropDownFor = 6.0;
    }
    printf("Platform falloff %f    ", PlatformDropDownFor);
    printf("Ball center y coord %f    ", Ball.center.y);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.controlSwitched) {
        StopSideMovement = NO;
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        if (point.x < screenWidth/2){
            BallLeft = YES;
        } else {
            BallRight = YES;
        }
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.controlSwitched) {
        BallLeft = NO;
        BallRight = NO;
        StopSideMovement = YES;
    }
}

- (void)PlatformMovement{
    Platform.center = CGPointMake(Platform.center.x, Platform.center.y + PlatformDropDownFor);
    Platform1.center = CGPointMake(Platform1.center.x, Platform1.center.y + PlatformDropDownFor);
    Platform2.center = CGPointMake(Platform2.center.x + Platform2SideMovement, Platform2.center.y + PlatformDropDownFor);
    Platform3.center = CGPointMake(Platform3.center.x, Platform3.center.y + PlatformDropDownFor);
    Platform4.center = CGPointMake(Platform4.center.x + Platform4SideMovement, Platform4.center.y + PlatformDropDownFor);
    if (Platform2.center.x >=  screenWidth-(Platform2.bounds.size.width/2) || Platform2.center.x <= 0+(Platform2.bounds.size.width/2)) {
        Platform2SideMovement *= -1;
    } else if (Platform4.center.x >= screenWidth-(Platform4.bounds.size.width/2) || Platform4.center.x <= 0+(Platform4.bounds.size.width/2)) {
        Platform4SideMovement *= -1;
    }
    // Stopping the platform falloff
    PlatformDropDownFor -= MovingConstant;
    if (PlatformDropDownFor < 0) {
        PlatformDropDownFor = 0;
    }
    // Bringing platforms back to top of the screen
    if (Platform.center.y > (screenHeight - Platform.bounds.size.height)) {
        RandomPosition = arc4random()%248;
        RandomPosition += 36;
        Platform.center = CGPointMake(RandomPosition, -6);
        PlatformUsed = NO;
    }
    if (Platform1.center.y > (screenHeight - Platform1.bounds.size.height)) {
        RandomPosition = arc4random()%248;
        RandomPosition += 36;
        Platform1.center = CGPointMake(RandomPosition, -6);
        Platform1Used = NO;
    }
    if (Platform2.center.y > (screenHeight - Platform2.bounds.size.height)) {
        RandomPosition = arc4random()%248;
        RandomPosition += 36;
        Platform2.center = CGPointMake(RandomPosition, -6);
        Platform2Used = NO;
    }
    if (Platform3.center.y > (screenHeight - Platform3.bounds.size.height)) {
        RandomPosition = arc4random()%248;
        RandomPosition += 36;
        Platform3.center = CGPointMake(RandomPosition, -6);
        Platform3Used = NO;
    }
    if (Platform4.center.y >(screenHeight - Platform4.bounds.size.height)) {
        RandomPosition = arc4random()%248;
        RandomPosition += 36;
        Platform4.center = CGPointMake(RandomPosition, -6);
        Platform4Used = NO;
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
    
    // So the higher we are going, the faster it is, becouse of platform movement acceleration based on the height. To compensate that we better implement same acceleration to the ball, so it wont move out of the screen eventually
    if (Ball.center.y > 450) {
        UpMovement = 5;
    }
    if (Ball.center.y > 350) {
        UpMovement = 4;
    }
    if (Ball.center.y > 250) {
        UpMovement = 3;
    }
}


- (void)Moving {
    if (Ball.center.y > (screenHeight + Ball.bounds.size.height)) {
        [self GameOver];
    }
    
    // We are dont want for ball to go higher then half of the screen, so if it is going to, we will limit it there
    if (Ball.center.y < screenHeight/2) {
        Ball.center = CGPointMake(Ball.center.x, screenHeight/2);
    }
    if (BallLeft == YES){
        SideMovement -= MovingConstant * 3;
        //Maximum speed is 5
        if (SideMovement <= -5) {
            SideMovement = -5;
        }
        if (Ball.center.x <= Ball.bounds.size.width/2){
            Ball.center = CGPointMake(screenWidth-(Ball.bounds.size.width/2), Ball.center.y);
        }
    }
    if (BallRight == YES){
        SideMovement += MovingConstant * 3;
        //Maximum speed is 5
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
    //Collision check - if the ball is falling down(UpMovement < -2) and it Intersects the platform frame
    if ((CGRectIntersectsRect(Ball.frame, Platform.frame)) && (UpMovement < -2)) {
        [self Bounce];
        [self PlatformDropDown];
        if (PlatformUsed == NO) {
            AddedScore = 10;
            PlatformUsed = YES;
        }
    }
    if ((CGRectIntersectsRect(Ball.frame, Platform1.frame)) && (UpMovement < -2)) {
        [self Bounce];
        [self PlatformDropDown];
        if (Platform1Used == NO) {
            AddedScore = 10;
            Platform1Used = YES;
        }
    }
    if ((CGRectIntersectsRect(Ball.frame, Platform2.frame)) && (UpMovement < -2)) {
        [self Bounce];
        [self PlatformDropDown];
        if (Platform2Used == NO) {
            AddedScore = 10;
            Platform2Used = YES;
        }
    }
    if ((CGRectIntersectsRect(Ball.frame, Platform3.frame)) && (UpMovement < -2)) {
        [self Bounce];
        [self PlatformDropDown];
        if (Platform3Used == NO) {
            AddedScore = 10;
            Platform3Used = YES;
        }
    }
    if ((CGRectIntersectsRect(Ball.frame, Platform4.frame)) && (UpMovement < -2)) {
        [self Bounce];
        [self PlatformDropDown];
        if (Platform4Used == NO) {
            AddedScore = 10;
            Platform4Used = YES;
        }
    }
    UpMovement -= MovingConstant;
    
    [self Scoring];
    if (self.controlSwitched) {
        [self listenToAccelerometer];
    }
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

- (IBAction)controlSwitchButton:(id)sender {
    if (self.controlSwitched) {
        [controlSwitchOutlet setTitle:@"accelerometer" forState:UIControlStateNormal];
        self.controlSwitched = NO;
    } else {
        [controlSwitchOutlet setTitle:@"touches" forState:UIControlStateNormal];
        self.controlSwitched = YES;
    }
}

- (void)listenToAccelerometer {
    if (_motionManager == NULL) {
        _motionManager = [[CMMotionManager alloc]init];
        _motionManager.deviceMotionUpdateInterval = 0.025;
        [_motionManager startDeviceMotionUpdates];
    }
    CMAcceleration gravity = _motionManager.deviceMotion.gravity;
    NSLog(@"Grav X %f",gravity.x);
    if (gravity.x < 0) {
        BallLeft = YES;
        BallRight = NO;
    } else {
        BallRight = YES;
        BallLeft = NO;
    }
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
    screenHeight = screenRect.size.height;
    //New labels
    GameOver.hidden = YES;
    FinalScore.hidden = YES;
    HighScore.hidden = YES;
    RestartGameOut.hidden = YES;
    ScoreNumber = 0;
    AddedScore = 0;
    LevelNumber = 1;
    PlatformUsed = NO;
    Platform1Used = NO;
    Platform2Used = NO;
    Platform3Used = NO;
    Platform4Used = NO;
    
    HighScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
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
