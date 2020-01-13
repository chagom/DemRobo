//
//  ViewController.h
//  DemRobo
//
//  Created by Goeum Cha on 02/02/2018.
//  Copyright © 2018 ChaGoEum. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BIG_FONT_SIZE 60.0
#define SMALL_FONT_SIZE 53.0
#define LINE_SPACING 15.0
#define VIEW_TRANSITION_SECONDS 1.0
#define TOTAL_SECONDS_FOR_SUPERMARKET 1.0

@interface ViewController : UIViewController

@property (nonatomic) BOOL isQAOn;
@property (nonatomic) BOOL isEnglish;

+ (NSMutableAttributedString *) getLineSpacedAttributedStringWithString:(NSString *)str;

@end

