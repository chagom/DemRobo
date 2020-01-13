//
//  PatientInfoViewController.m
//  DemRobo
//
//  Created by Goeum Cha on 02/02/2018.
//  Copyright © 2018 ChaGoEum. All rights reserved.
//

#import "PatientInfoViewController.h"

//#import <KakaoNewtoneSpeech/KakaoNewtoneSpeech.h>

#import "stdlib.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

@interface PatientInfoViewController () <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *viewPatientInfo;


//  Storyboard things..
// Splash
@property (weak, nonatomic) IBOutlet UIImageView *imgIconView;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbBirth;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;
@property (weak, nonatomic) IBOutlet UIButton *btnEnroll;
@property (weak, nonatomic) IBOutlet UISwitch *swLanguage;

// Sign Up View
@property (weak, nonatomic) IBOutlet UILabel *lbSignupNotice;
@property (weak, nonatomic) IBOutlet UILabel *lbNameSignup;
@property (weak, nonatomic) IBOutlet UILabel *lbPasswordSignup;
@property (weak, nonatomic) IBOutlet UILabel *lbBirthSignup;
@property (weak, nonatomic) IBOutlet UILabel *lbAcademicSignup;
@property (weak, nonatomic) IBOutlet UILabel *lbHospitalSignup;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

@property (weak, nonatomic) IBOutlet UITextField *txNameSignup;
@property (weak, nonatomic) IBOutlet UITextField *txPasswordSignup;
@property (weak, nonatomic) IBOutlet UITextField *txDateofBirthSignup;
@property (weak, nonatomic) IBOutlet UITextField *txEduYearSignup;
@property (weak, nonatomic) IBOutlet UITextField *txOccupationSignup;


// Login Txfield
@property (weak, nonatomic) IBOutlet UITextField *txInputName;
@property (weak, nonatomic) IBOutlet UITextField *txInputBirth;

// Result View

@property (weak, nonatomic) IBOutlet UIView *viewResult;
@property (weak, nonatomic) IBOutlet UILabel *lbTestNotice;
@property (weak, nonatomic) IBOutlet UILabel *lbWelcome;

// For Navigating
@property (weak, nonatomic) IBOutlet UIButton *btnGoToDemTect;
@property (weak, nonatomic) IBOutlet UIButton *btnGoToWaiting;

// Model
@property (weak, nonatomic) HttpModel *httpModel;
@property (weak, nonatomic) SocketModel *socketModel;

@property (weak, nonatomic) IBOutlet UILabel *txTestIp;

// Picker View
@property (nonatomic, strong) NSArray *arrEducation;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerEducation;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerBirthday;


@end

@implementation PatientInfoViewController


- (void)viewWillAppear:(BOOL)animated
{
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (IBAction)btnTester:(id)sender {
    [self.socketModel startSocketWithType];
}

- (NSString *)getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TEST
    self.txTestIp.text = [self getIPAddress];
    
    
    // MODELS
    self.httpModel = [HttpModel sharedInstance];
    self.socketModel = [SocketModel sharedSocket];

    self.imgIconView.image = [UIImage imageNamed:@"icon.png"];
    
    // Splash
    self.lbName.text = NSLocalizedString(@"Name", @"이름넣기");
    self.lbBirth.text = NSLocalizedString(@"BirthDate", @"생년월일 넣기");
    [self.btnConfirm setTitle:NSLocalizedString(@"Confirm", @"확인 버튼") forState:UIControlStateNormal];
    
    NSMutableAttributedString *enrollTitle = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"First Trial", @"처음이슈")];
    
    enrollTitle = [self getUnderlinedString:enrollTitle];
    [self.btnEnroll setAttributedTitle:enrollTitle forState:UIControlStateNormal];
    
    
    // Sign up
    self.lbSignupNotice.text = NSLocalizedString(@"SignupNotice", @"가입할때 알림문구");
    self.lbNameSignup.text = NSLocalizedString(@"Name", @"이름 넣기 & ID");
    self.lbPasswordSignup.text = NSLocalizedString(@"Password", @"패스워드");
    self.lbBirthSignup.text = NSLocalizedString(@"BirthDate", @"");
    self.lbAcademicSignup.text = NSLocalizedString(@"FinalAcademy", @"최종학력");
    self.lbHospitalSignup.text = NSLocalizedString(@"HospitalName", @"병원이름");
    [self.btnNext setTitle:NSLocalizedString(@"Next", @"다음버튼") forState:UIControlStateNormal];
    self.txOccupationSignup.placeholder = NSLocalizedString(@"N/A", @"병원이름 없을수도 있음");
    
    // Picker
    self.arrEducation = [[NSArray alloc] init];
    // YEAR
//    "morethan12" = "More than 12 years";
//    "lessthan11" = "Less than 11 years";
    self.arrEducation = [NSArray arrayWithObjects:NSLocalizedString(@"lessthan11", @"11년 이하"), NSLocalizedString(@"morethan12", @"12년 이상"), nil];

}

- (NSMutableAttributedString *)getUnderlinedString:(NSMutableAttributedString *)str
{
    NSMutableAttributedString *result = str;
    
    NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    [str addAttributes:underlineAttribute range:NSMakeRange(0, str.length)];
    
    return result;
}


// Language Settings..
- (IBAction)swConverted:(id)sender {
    
    if(self.swLanguage.isOn)
    {
        NSLog(@"Language Settings : ENGLISH");
    }
    else
    {
        NSLog(@"Language Settings : KOREAN");
    }
}


// -1. Start with Login / Sign In
// 가입하기
- (IBAction) clickedSignUpButton
{
    NSLog(@"btnClicked");
    // 정보 입력하는 화면으로 전환
    [UIView animateWithDuration: 2.0f animations:^{
//        NSLog(@"self.arr : %ld", self.arrEducation.count);
         [self.view bringSubviewToFront:self.viewPatientInfo];
        self.splashView.alpha = 0.0;
    }];
   
}
- (IBAction)clickedSignUpWithInput:(id)sender {
    
    NSInteger selectedRow = [self.pickerEducation selectedRowInComponent:0];
    NSInteger educationResult = 0;
    if(selectedRow == 0){ educationResult = 11; }
    else { educationResult = 12; }
    
    NSString *currentDate = [self getStringOfDateFormat:[NSDate date]];
    [[NSUserDefaults standardUserDefaults] setObject:currentDate forKey:@"TEST_Date"];
    
    NSDictionary *enrollInfo = @{@"PAT_NAME" : [NSString stringWithString:self.txNameSignup.text],
                                 @"PAT_PW" : [NSString stringWithString:self.txPasswordSignup.text],
                                 @"PAT_BIRTH" : [self getStringOfDateFormat:self.pickerBirthday.date],
                                 @"PAT_EDUCATION" : [NSString stringWithFormat:@"%ld", educationResult],
                                 @"PAT_HOSPITAL" : [NSString stringWithString:self.txOccupationSignup.text],
                                 @"PAT_PHONE" : @"N/A",
                                 @"PAT_RECENT" : currentDate,
                                 };
    NSInteger test = 1;
    if(test==1)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"3" forKey:@"index"];
        [self.btnGoToDemTect sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
//    [self.httpModel getResultOfUserEnrollmentWithPatientInfo:(NSDictionary *)enrollInfo completion:^(NSDictionary *json, BOOL success) {
//
//
//        if(success)
//        {
//            [self getResultViewToFrontWithLoginStatus:NO];
//            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, VIEW_TRANSITION_SECONDS * NSEC_PER_SEC);
//            [self.socketModel startSocketWithType];
//            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//                [self.btnGoToDemTect sendActionsForControlEvents:UIControlEventTouchUpInside];
//            });
//        }
//        else{
//            NSLog(@"You should try again...");
//        }
//    }];
    
}

- (NSString *)getStringOfDateFormat:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddhhmmss"];
    
    return [dateFormatter stringFromDate:date];
}

- (NSString *)getCurrentDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddhhmmss"];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (NSMutableAttributedString *)getNoticeContentForLoggedInPatient
{
    NSMutableParagraphStyle *styleLineSpacing = [[NSMutableParagraphStyle alloc] init];
    [styleLineSpacing setLineSpacing:LINE_SPACING];
    [styleLineSpacing setAlignment:NSTextAlignmentCenter];
    
    NSMutableAttributedString *notice = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"NextTestDate_TMP", @"TMP")];
    [notice addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BIG_FONT_SIZE] range:NSMakeRange(0, [notice length])];
    [notice addAttribute:NSParagraphStyleAttributeName value:styleLineSpacing range:NSMakeRange(0, [notice length])];
    
    return notice;
}

- (NSMutableAttributedString *)getNoticeContentForEnrolledPatient
{
    NSMutableParagraphStyle *styleLineSpacing = [[NSMutableParagraphStyle alloc] init];
    [styleLineSpacing setLineSpacing:LINE_SPACING];
    [styleLineSpacing setAlignment:NSTextAlignmentCenter];
    
    NSMutableAttributedString *notice = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"FirstVisit", @"첫 방문 알림")];
    NSString *noticeTmp = notice.string;
    NSUInteger lengthOfString = [notice length];
    NSUInteger lengthOfFirstLine = [noticeTmp rangeOfString:@"\n"].location;
    
    [notice addAttribute:NSParagraphStyleAttributeName value:styleLineSpacing range:NSMakeRange(0, lengthOfString)];
    
    [notice addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:BIG_FONT_SIZE] range:NSMakeRange(0, lengthOfFirstLine)];
    [notice addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:SMALL_FONT_SIZE] range:NSMakeRange(lengthOfFirstLine + 1, lengthOfString - lengthOfFirstLine - 1)];
    
    return notice;
}

- (void)getResultViewToFrontWithLoginStatus:(BOOL)status
{
    NSString *welcomeStr = @"";
    
    if(status) // Login
    {
        welcomeStr = self.txInputName.text;
        welcomeStr = [welcomeStr stringByAppendingString:NSLocalizedString(@"Welcome", @"방가방가")];
        self.lbWelcome.text = welcomeStr;
        self.lbTestNotice.attributedText = [self getNoticeContentForLoggedInPatient];
        [self.view bringSubviewToFront:self.viewResult];
        
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            CATransition *animation = [CATransition animation];
            animation.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation.type = kCATransitionFade;
            animation.duration = 5.0;
            self.lbWelcome.hidden = YES;
            [self.lbWelcome.layer addAnimation:animation forKey:@"kCATransitionFade"];
        });
        
    }
    else // Enrolled
    {
        self.lbWelcome.hidden = YES;
        self.lbTestNotice.attributedText = [self getNoticeContentForEnrolledPatient];
        [self.view bringSubviewToFront:self.viewResult];
    }
    
    CATransition *comeOutAnimation = [CATransition animation];
    comeOutAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    comeOutAnimation.type = kCATransitionFade;
    if(status)
        comeOutAnimation.duration = 10.0;
    else
        comeOutAnimation.duration = 2.0;
    self.lbTestNotice.hidden = NO;
    
    [self.lbTestNotice.layer addAnimation:comeOutAnimation forKey:@"kCATransitionFade"];
    
}

// 로그인
- (IBAction)clickedSignInButtonWithInfo:(id)sender
{
    [self.txInputName resignFirstResponder];
    [self.txInputBirth resignFirstResponder];
    
    // DB에 정보 넘겨버리고 확인 뜨면 push로 넘기기
    
    [UIView animateWithDuration:2.0f delay:2.0f options:UIViewAnimationOptionCurveEaseOut animations:^{

    } completion:^(BOOL finished) {
        
        NSDictionary *userInfo = @{@"PAT_ID" : self.txInputName.text, @"PAT_PW" : self.txInputBirth.text};
        NSLog(@"patid : %@, pat_pw : %@", self.txInputName.text, self.txInputBirth.text);
        
        [self.httpModel getLoginWithPatientInfo:userInfo completion:^(NSDictionary *json, BOOL success) {
            if(success)
            {
                // 여기서 처리가 완료되면 넘기자!
                [self getResultViewToFrontWithLoginStatus:YES];
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, VIEW_TRANSITION_SECONDS * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [self.btnGoToWaiting sendActionsForControlEvents:UIControlEventTouchUpInside];
                });
            }
        }];
    }];
}


// Actions of Hidden Buttons

- (IBAction)touchedButtonGoingToDemtect:(id)sender {
}

- (IBAction)touchedButtonGoingToWaiting:(id)sender {
}



-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:TRUE];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y -200., self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:TRUE];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y +200., self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

#pragma mark - Picker View
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
//    NSLog(@"numberOfRowsInComponent : %ld", self.arrEducation.count);
    return self.arrEducation.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.arrEducation objectAtIndex:row];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
