//
//  PatientInfoViewController.h
//  DemRobo
//
//  Created by Goeum Cha on 02/02/2018.
//  Copyright © 2018 ChaGoEum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "HttpModel.h"
#import "SocketModel.h"


@interface PatientInfoViewController : UIViewController 


// getting information of patient by input label such as name, age, ...

@property (strong, nonatomic) IBOutlet UIView *splashView;

// input values go to database

@end
