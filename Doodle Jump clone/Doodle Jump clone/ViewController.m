//
//  ViewController.m
//  Doodle Jump clone
//
//  Created by Fenkins on 09/06/15.
//  Copyright (c) 2015 Fenkins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    HighScoreNumberVC = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    HighScoreVC.text = [NSString stringWithFormat:@"High score is %i", HighScoreNumberVC];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
