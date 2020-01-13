//
//  ViewController.m
//  DemRobo
//
//  Created by Goeum Cha on 02/02/2018.
//  Copyright © 2018 ChaGoEum. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.isQAOn = NO;
    self.isEnglish = YES;
}

+ (NSMutableAttributedString *) getLineSpacedAttributedStringWithString:(NSString *)str
{
    NSMutableParagraphStyle *styleLineSpacing = [[NSMutableParagraphStyle alloc] init];
    [styleLineSpacing setLineSpacing:LINE_SPACING];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
    [string addAttribute:NSParagraphStyleAttributeName value:styleLineSpacing range:NSMakeRange(0, [string length])];
    
    return string;
}

- (void)showAlertViewWithRetrial
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Some errors are occured"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
