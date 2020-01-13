//
//  WaitingViewController.m
//  DemRobo
//
//  Created by Goeum Cha on 02/02/2018.
//  Copyright © 2018 ChaGoEum. All rights reserved.
//

#import "WaitingViewController.h"

@interface WaitingViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csFirstRobotTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csSecondRobotTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csThirdRobotTop;

@end

@implementation WaitingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [UIView animateKeyframesWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
//        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
//            self.csFirstRobotTop.constant = 400;
//            [self.view layoutIfNeeded];
//        }];
//        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.0 animations:^{
//            self.csSecondRobotTop.constant = 400;
//            [self.view layoutIfNeeded];
//        }];
//        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^{
//            self.csThirdRobotTop.constant = 400;
//            [self.view layoutIfNeeded];
//        }];
//
//    } completion:nil];
    
    
    [UIView animateKeyframesWithDuration:3.0 delay:0.0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^{
            self.csFirstRobotTop.constant = 400;
            [self.view layoutIfNeeded];
        }];
    } completion:^(BOOL finished) {
    
    }];
    
    [UIView animateKeyframesWithDuration:3.0 delay:1.0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^{
            self.csSecondRobotTop.constant = 400;
            [self.view layoutIfNeeded];
        }];
    } completion:^(BOOL finished) {
        
    }];
    
    
    [UIView animateKeyframesWithDuration:3.0 delay:2.0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^{
            self.csThirdRobotTop.constant = 400;
            [self.view layoutIfNeeded];
        }];
    } completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
