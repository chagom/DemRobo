 //
//  DemTectViewController.m
//  DemRobo
//
//  Created by Goeum Cha on 02/02/2018.
//  Copyright © 2018 ChaGoEum. All rights reserved.
//

#import "DemtectViewController.h"
#import "ViewController.h"
#import "stdlib.h"
#import "FileTransferModel.h"
#import "HttpModel.h"

#define WORD_LIST_FIRST_TRIAL 1
#define WORD_LIST_SECOND_TRIAL 2
#define SUPER_MARKET_TASK 3
#define NUMBER_REVERSION 4
#define REPEAT_WORDS 5
#define MARKET_SECONDS 60
#define MULTIPLE_SPACES @"        "


@interface DemtectViewController () <UITextViewDelegate, UITextFieldDelegate>//, //MTTextToSpeechDelegate, MTSpeechRecognizerDelegate, MTSpeechRecognizerViewDelegate>

{
    NSTimer *timer;
    NSTimer *counter;
    int minute, seconds, totalSeconds;
    int threeSeconds;
}

// 0. Recording View
@property (weak, nonatomic) IBOutlet UIView *viewRecording;
@property (weak, nonatomic) IBOutlet UILabel *lbNoticeRecording;
@property (weak, nonatomic) IBOutlet UIButton *btnStopRecording;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *csLayoutToCenter;
@property (weak, nonatomic) IBOutlet UIImageView *ivStopButton;
@property (nonatomic) NSUInteger stepCnt;
@property (weak, nonatomic) IBOutlet UILabel *lbNoticeForSuper;
@property (weak, nonatomic) IBOutlet UILabel *lbTimer;

@property (weak, nonatomic) IBOutlet UILabel *lbRecordNumConversion;


// 0-1. Next View
@property (weak, nonatomic) IBOutlet UIView *viewNext;
@property (weak, nonatomic) IBOutlet UIView *viewProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *barProgress;
@property (weak, nonatomic) IBOutlet UILabel *lbNext;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;

// 1. Word List Test
@property (weak, nonatomic) IBOutlet UIView *viewWordList;
@property (weak, nonatomic) IBOutlet UIButton *btnMicrophone;
@property (weak, nonatomic) IBOutlet UIButton *btnStop;
@property (weak, nonatomic) IBOutlet UILabel *lbWordListCautionSecond;
@property (weak, nonatomic) IBOutlet UILabel *lbWordListCautionFirst;
@property (weak, nonatomic) IBOutlet UIImageView *ivSound;
@property (weak, nonatomic) IBOutlet UIImageView *ivMicrophone;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfNoticeFirst;
@property (weak, nonatomic) IBOutlet UILabel *lbVocaRememberTitle;

@property (nonatomic) BOOL isOnProgressWL;
@property (nonatomic) NSInteger periodWL;
@property (weak, nonatomic) IBOutlet UIButton *btnPlayRecordedTmp;
@property (nonatomic, strong) NSString *questionOne;
@property (nonatomic, strong) NSString *questionTwo;

// Recorder
@property (nonatomic) BOOL isRecording;

// 2 Number Conversion Views
@property (weak, nonatomic) IBOutlet UIView *viewNumberConvNotice;
@property (weak, nonatomic) IBOutlet UILabel *lbNumConvNotice;
@property (weak, nonatomic) IBOutlet UILabel *lbNumConvEx;
@property (weak, nonatomic) IBOutlet UILabel *lbNumConvExAnsOne;
@property (weak, nonatomic) IBOutlet UILabel *lbNumConvExAnsTwo;
@property (weak, nonatomic) IBOutlet UILabel *lbNumConvExQOne;
@property (weak, nonatomic) IBOutlet UILabel *lbNumConvExQTwo;
@property (weak, nonatomic) IBOutlet UILabel *lbNumConvTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbNumConvRiddle;

@property (weak, nonatomic) IBOutlet UIView *viewNumberConvTest;
@property (strong, nonatomic) IBOutlet WritingArea *viewWritingArea;
@property (weak, nonatomic) IBOutlet UILabel *lbNumberConvMethod;
@property (weak, nonatomic) IBOutlet UITextField *txFieldForKeyInput;
@property (weak, nonatomic) IBOutlet UIButton *btnKeyboard;
@property (weak, nonatomic) IBOutlet UIButton *btnNumConvNext;
@property (nonatomic) NSInteger secondPhase;

@property (nonatomic) BOOL isKeyboard;

// 3. Supermarket View
@property (weak, nonatomic) IBOutlet UIView *viewSuperMarketTest;
@property (weak, nonatomic) IBOutlet UIButton *btnSuperMarketRecord;
@property (weak, nonatomic) IBOutlet UILabel *lbSuperMarketNotice;
@property (weak, nonatomic) IBOutlet UILabel *lbSupermarketTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbSupermarketClickPlz;

// 4. Reverse Number View
@property (weak, nonatomic) IBOutlet UIView *viewReverseNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnTrialReverseNum;
@property (weak, nonatomic) IBOutlet UILabel *lbRecognitionResult;
@property (weak, nonatomic) IBOutlet UILabel *lbNoticeReverseNum;
@property (nonatomic, strong) NSString *recognitionResult;
@property (nonatomic, strong) NSString *strReverseNumberProblem;
@property (nonatomic, strong) NSString *strReverseNumberSolution;
@property (weak, nonatomic) IBOutlet UILabel *lbExReverseNum;
@property (weak, nonatomic) IBOutlet UILabel *lbExReNumQ;
@property (weak, nonatomic) IBOutlet UILabel *lbExReNumAns;
@property (weak, nonatomic) IBOutlet UILabel *lbTitleReverseNum;

@property (weak, nonatomic) IBOutlet UIView *viewReverseNotice;
@property (weak, nonatomic) IBOutlet UILabel *lbReverseNotice;
@property (weak, nonatomic) IBOutlet UILabel *lbReverseCount;
@property (weak, nonatomic) IBOutlet UIButton *btnReverseNext;
@property (weak, nonatomic) IBOutlet UIView *viewReverseMethod;

@property (nonatomic) NSInteger fourthPhase;

@property (nonatomic) NSInteger numReverseCnt;
@property (nonatomic) NSMutableArray *fourthProblems;

// 5. Repeat Word List View
@property (weak, nonatomic) IBOutlet UIView *viewRepeatWords;
@property (weak, nonatomic) IBOutlet UIButton *btnRepeatRecord;
@property (weak, nonatomic) IBOutlet UILabel *lbNoticeRepeatWords;
@property (weak, nonatomic) IBOutlet UIButton *btnPlayRepeatTmp;
@property (weak, nonatomic) IBOutlet UILabel *lbRepeatWordsClickBtn;
@property (weak, nonatomic) IBOutlet UILabel *lbRepeatWordsTitle;

// 6. End of the Test  View
@property (weak, nonatomic) IBOutlet UIView *viewEndofTest;
@property (weak, nonatomic) IBOutlet UIButton *btnGoWaitingFromDemTect;
@property (weak, nonatomic) IBOutlet UILabel *lbNoticeTestEnd;


// Kakao Speech
//@property (nonatomic) MTSpeechRecognizerClient *speechRecognizer;

// TTS
//@property (nonatomic, strong) MTTextToSpeechClient *tts;
@property (nonatomic, strong) NSString *targetText;
@property (nonatomic, strong) NSString *voiceType;
@property (nonatomic, strong) NSString *serviceMode;

// Test Variable
@property (nonatomic) BOOL isVoiceOn;

// Transfer audio file
@property (nonatomic) FileTransferModel *transferModel;
@property (nonatomic, strong) NSMutableArray *fileLocation;

// Http
@property (nonatomic) HttpModel *httpModel;

@end

@implementation DemtectViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    
    self.isVoiceOn = YES;
    self.transferModel = [FileTransferModel sharedInstance];
    self.httpModel = [HttpModel sharedInstance];
    
    [self.httpModel getTestSetWithcompletion:^(NSDictionary *json, BOOL success) {
       if(success)
       {
           NSArray *tmpArrQuestion = [NSArray arrayWithArray:[json objectForKey:@"question"]];
           NSDictionary *dicQuestion = [tmpArrQuestion objectAtIndex:0];
           [[NSUserDefaults standardUserDefaults] setObject:[dicQuestion objectForKey:@"idx"] forKey:@"TestID"];
           self.questionOne = [dicQuestion objectForKey:@"firstSet"];
           self.questionTwo = [dicQuestion objectForKey:@"secondSet"];
           NSLog(@"parsed one : %@, parsed two : %@", self.questionOne, self.questionTwo);

       }
        else
        {
            // show alert
        }
    }];
//    self.questionOne = @"Apple/Ink/Nail/Bird/Book/Ticket/Tree/Chair/House/Ship";
//    self.questionTwo = @"209/4054/six hundred and eighty one/two thousand and twenty";
    
    self.fileLocation = [NSMutableArray array];
    
    if(self.isQAOn)
    {
        self.btnPlayRecordedTmp.hidden = NO;
        self.btnPlayRepeatTmp.hidden = NO;
        self.btnStop.hidden = NO;
    }
    else
    {
        self.btnPlayRecordedTmp.hidden = YES;
        self.btnPlayRepeatTmp.hidden = YES;
        self.btnStop.hidden = YES;
    }
    
    // TTS
    if(self.isVoiceOn)
    {
//        self.voiceType = TextToSpeechVoiceTypeWoman;
//        self.serviceMode = NewtoneTalk_1;
//
//        if (_tts != nil) {
//            return;
//        }
//
//        NSDictionary *config = @{
//                                 TextToSpeechConfigKeyVoiceType : self.voiceType,
//                                 TextToSpeechConfigServiceMode : self.serviceMode,
//                                 TextToSpeechConfigKeySpeechSpeed : [NSNumber numberWithFloat:0.4f]};
//        _tts = [[MTTextToSpeechClient alloc] initWithConfig:config];
//        _tts.delegate = self;
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.periodWL = 1;
    self.txFieldForKeyInput.delegate = self;
    
    self.numReverseCnt = 2;
    self.lbTimer.text = @"01:00";
    
    self.strReverseNumberSolution = @"";
    self.isKeyboard = NO;
    self.stepCnt = 1;
    
    totalSeconds = TOTAL_SECONDS_FOR_SUPERMARKET;
    threeSeconds = 3;

    // Number Conversion
    self.secondPhase = 0;
    
    // Number Revsersion
    self.fourthProblems = [NSMutableArray array];
    
    [self settingUpLocalizedLanguage];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self playWordListNoticeFirst];
    NSLog(@"self.question ONe : %@", self.questionOne);
}

- (void)settingUpLocalizedLanguage
{
    [self settingUpLocalizedRecordingView];
    [self settingUpLocalizedNextView];
    [self settingUpLocalizedFirstStep];
    [self settingUpLocalizedSecondStep];
    [self settingUpLocalizedThirdStep];
    [self settingUpLocalizedFourthStep];
    [self settingupLocalizedFifthStep];
    [self settingUpLocalizedTestEndView];
}

- (NSString *)getAttributedStringWithSpace:(NSString *)targetStr
{
    NSString *result = @"              ";
    result = [result stringByAppendingString:targetStr];
    
    return result;
}

#pragma mark -  0. Recording View
- (void)settingUpLocalizedRecordingView
{
    NSString *notice= @"";
    
    notice = NSLocalizedString(@"OnRecording", @"녹음 중입니데이");
    notice = [notice stringByAppendingString:NSLocalizedString(@"RememberAllDone", @"다 말씀하셨으면")];
    
    notice = [notice stringByAppendingString:MULTIPLE_SPACES];
    notice = [notice stringByAppendingString:NSLocalizedString(@"PressingBtn", @"버튼을 눌러서")];
    notice = [notice stringByAppendingString:NSLocalizedString(@"StopRecording", @"프로세스를 정지합니다.")];
    
    self.lbNoticeRecording.attributedText = [ViewController getLineSpacedAttributedStringWithString:notice];
    [self.lbNoticeRecording sizeToFit];
}

- (IBAction)btnClickedStopRecording:(id)sender {
//    [self.tts stop];
//    self.isOnProgressWL = NO;
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:NO error:nil];
    
    if(self.stepCnt == 1)
    {
        // 1-1
        NSLog(@"self.periodWL = %ld, self.isOnProgressWL : %d", self.periodWL, self.isOnProgressWL);
        if(self.periodWL == 1 && self.isOnProgressWL == YES)
        {
            self.isOnProgressWL = NO;
            self.lbWordListCautionFirst.attributedText = [ViewController getLineSpacedAttributedStringWithString:NSLocalizedString(@"WordListNotice3", @"2회차")];
            self.lbWordListCautionSecond.hidden = YES;
            self.ivSound.hidden = YES;
            self.ivMicrophone.hidden = YES;
            self.heightOfNoticeFirst.constant = 300;
            self.periodWL++;
            
            [self playWordListNoticeSecond];

        }
        else if(self.isOnProgressWL == YES && self.periodWL == 2) // 1-2
        {
            self.isOnProgressWL = NO;
            [self bringNextViewToFront];
        }
        else
        {
            NSLog(@"Something went wrong..");
        }
    }
    else if(self.stepCnt == 2) // 실제로 여기 들어오지 않음
    {
        NSLog(@"step 2 : btnClickedStopRecording");
    }
    else if(self.stepCnt == 3)
    {
        NSLog(@"ste 3: btnClickedStopRecording");
        [self bringNextViewToFront];
    }
    else if(self.stepCnt == 4)
    {
        NSLog(@"step 4 : btnClickedStopRecording"); // 4번 UI 바꿔야겠다
        [self bringNextViewToFront];
    }
    else if(self.stepCnt == 5)
    {
        NSLog(@"step 5 : btnClickedStopRecording");
        [self bringNextViewToFront];
    }
    else
    {
        NSLog(@"Something went wrong........ on btnClickedStopRecording");
    }
    
    [self.view sendSubviewToBack:self.viewRecording];
    
}

- (void)bringRecordingViewToFront
{
    if(self.isOnProgressWL)
    {
        NSLog(@"테스트를 끝까지 진행해주세요");
    }
    else
    {
        if(self.stepCnt == 1)
        {
            if(self.periodWL == 1)
                [self recordWordListWithPeriod:WORD_LIST_FIRST_TRIAL];
            else if(self.periodWL == 2)
                [self recordWordListWithPeriod:WORD_LIST_SECOND_TRIAL];
        }
        else if(self.stepCnt == 3)
        {
            [self settingRecordingViewForSuperMarket:YES];
            
            [self recordWordListWithPeriod:SUPER_MARKET_TASK];
        }
        else if(self.stepCnt == 4)
        {
            [self settingRecordingViewForSuperMarket:NO];
            [self recordWordListWithPeriod:NUMBER_REVERSION];
            [self.lbNoticeRecording sizeToFit];
            self.lbNoticeRecording.numberOfLines = 0;
        }
        else if(self.stepCnt == 5)
        {
            [self recordWordListWithPeriod:REPEAT_WORDS];
        }
        else
        {
            NSLog(@"Something went wrong...");
        }
    }
    
    [self.view bringSubviewToFront:self.viewRecording];
}

- (void)settingRecordingViewForSuperMarket:(BOOL)flag
{
    if(flag) // 슈퍼마켓 등장
    {
        self.lbNoticeForSuper.hidden = NO;
        self.lbTimer.hidden = NO;
        self.csLayoutToCenter.constant = -50;
        self.lbNoticeForSuper.attributedText = [ViewController getLineSpacedAttributedStringWithString:NSLocalizedString(@"RecordingSupermarket", @"레코딩~슈퍼마켓~")];
        [self settingCountDownTimer];
        
        self.lbNoticeRecording.hidden = YES;
        self.ivStopButton.hidden = YES;
        self.btnStopRecording.hidden = YES;
    }
    else
    {
        self.lbNoticeForSuper.hidden = YES;
        self.lbTimer.hidden = YES;
        self.csLayoutToCenter.constant = 140;
        
        self.lbNoticeRecording.hidden = NO;
        self.ivStopButton.hidden = NO;
        self.btnStopRecording.hidden = NO;
    }
}

#pragma mark -  0. Recording View : CountDown Timer
- (void)settingCountDownTimer
{
    if([timer isValid]) [timer invalidate];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}

- (void)updateTimer
{
    NSLog(@"TIMER : %d", totalSeconds);
    minute = totalSeconds / 60;
    seconds = totalSeconds % 60;
    self.lbTimer.text = [NSString stringWithFormat:@"%02d:%02d", minute, seconds];
    totalSeconds--;
    
    if(totalSeconds < 0){
        NSLog(@"TIMER IS DONE!!!");
        [timer invalidate];
        [self.btnStopRecording sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark -  0. Next View

- (void)settingUpLocalizedNextView
{
    [self.btnNext setTitle:NSLocalizedString(@"Next", @"다음>") forState:UIControlStateNormal];
    self.lbNext.text = NSLocalizedString(@"NextNotice", @"");
}

- (IBAction)clickedBtnGoNext:(id)sender {
    
    [self.view sendSubviewToBack:self.viewNext];
    
    switch (self.stepCnt) {
        case 1: // 1->2
        {
            [self bringNumberConversionNoticeToFront];
            [self settingUpNumCovAnimation];
            self.stepCnt++;
            break;
        }

        case 2: // 2->3
        {
            if(self.secondPhase == 0)
            {
//                [self ]
                self.secondPhase++;
                [self bringNumberConversionNoticeToFrontWithPhase:self.secondPhase];
                break;
                
            }
            else if(self.secondPhase == 1)
            {
                self.secondPhase++;
                [self bringNumberConversionNoticeToFrontWithPhase:self.secondPhase];
                break;
            }
            else if(self.secondPhase == 2)
            {
                self.secondPhase++;
                [self bringNumberConversionNoticeToFrontWithPhase:self.secondPhase];
                break;
            }
            else // 2-4번째 완료
            {
                [self bringSupermarketTestToFront];
                self.stepCnt++;
                break;
            }
            
        }
        case 3: // 3->4
        {
            self.stepCnt++;
            [self settingRecordingViewForSuperMarket:NO];
            self.lbNoticeRecording.text = @"";
            [self bringReverseNumberViewToFront];
            break;
        }
        case 4: // 4->5
        {
            if(self.fourthPhase % 5 == 0) // first phase 2, second phase 2
            {
                if(self.fourthPhase == 5)
                {
                    //self.fourthPhase++;           // NO NEED BECAUSE OF showReverseNoticeViewWithCnt:
                    for (NSString *str in self.fourthProblems) {
                        NSLog(@"this is 1 str : %@", str);
                    }
                    [self showReverseNoticeViewWithCnt:2];
                    break;
                }
                else if (self.fourthPhase == 10) // final
                {
                    self.fourthPhase = 0;
                    self.stepCnt++;
                    [self bringRepeatWordListViewToFront];
                    break;
                }
                else // 0
                {
                    [self bringReverseNumberViewToFront];
                    [self bringTryViewWithPhase:(self.fourthPhase % 5) + 2];
                    self.fourthPhase++;
                    break;
                }
            }
            else if (self.fourthPhase % 5 == 1) // 3
            {
                [self bringTryViewWithPhase:(self.fourthPhase % 5) + 2];
                self.fourthPhase++;
                break;
            }
            else if (self.fourthPhase % 5 == 2) // 4
            {
                [self bringTryViewWithPhase:(self.fourthPhase % 5) + 2];
                self.fourthPhase++;
                break;
            }
            else if (self.fourthPhase % 5 == 3) // 5
            {
                [self bringTryViewWithPhase:(self.fourthPhase % 5) + 2];
                self.fourthPhase++;
                break;
            }
            else if(self.fourthPhase % 5 == 4)
            {
                if(self.fourthPhase == 9) // final actually 12
                {
                    [self bringTryViewWithPhase:(self.fourthPhase % 5) + 2];
                    self.fourthPhase++;
                    break;
                }
                else        // not final
                {
                    [self bringTryViewWithPhase:(self.fourthPhase % 5) + 2];
                    self.fourthPhase++;
                    break;
                }
            }
            
        }
        case 5: // 5->6
        {
            self.stepCnt++;
            [self bringEndOfTestViewToFront];
            break;
        }
    }
}

- (void)bringNextViewToFront
{
    [self.view bringSubviewToFront:self.viewNext];
}

// Progress of DemTect
#pragma mark -  1. Pressing a button at Word list test --> Recording

- (void)settingUpLocalizedFirstStep
{
    self.lbVocaRememberTitle.text = NSLocalizedString(@"VocaRememberTitle", @"1. 단어 기억하기");
    self.lbWordListCautionFirst.attributedText = [ViewController getLineSpacedAttributedStringWithString:[self getAttributedStringWithSpace:NSLocalizedString(@"WordListNotice1", @"안내문구 1")]];
    self.lbWordListCautionSecond.attributedText = [ViewController getLineSpacedAttributedStringWithString:[self getAttributedStringWithSpace:NSLocalizedString(@"WordListNotice2", @"안내문구 2")]];
}

- (IBAction)btnClickedMicrophone:(id)sender
{
//    [self stopRecorder];
//    if(self.tts)
    [self bringRecordingViewToFront];
}

- (IBAction)btnClickedStopTMP:(id)sender
{
//    [recorder stop];
    
}

- (IBAction)btnClickedPlay:(id)sender
{
    // This is not a play button
    [self recordReplay];
}

- (IBAction)btnClickedGiveProblem:(id)sender {

    // Only self.question ONE
    NSString *wordList = [self getParsedStringWithString:self.questionOne];
    
//    [self.tts play:wordList];
}

- (NSString *)getParsedStringWithString:(NSString *)question
{
    // question : //Apple/Ink/Nail/Bird/Book/Ticket/Tree/Chair/House/Ship
    NSString *result = @"";
    NSArray *subString = [question componentsSeparatedByString:@"/"];
    result = [subString componentsJoinedByString:@",  "];
    NSLog(@"result : %@", result);
    
    // desired result = @"Apple, Ink, Nail, Bird, Book, Ticket, Tree, Chair, House, Ship";
    return result;
}

- (void)playWordListNoticeFirst
{
//    [self.tts play:@"여기는 첫번째 테스트"];
    //    [self.tts play:@"When you pressed Speaker button, I will tell you ten words slowly. When I'm done, press microphone button and please tell us as many of these words as possible. The order is not important."];
}

- (void)playWordListNoticeSecond
{
//    [self.tts play:@"다시 한번 말씀해주세요. 밑에 누르고"];;
}

- (IBAction)btnClickedSpeakerAgain:(id)sender
{
    NSString *notice = @"";
    
    if(self.periodWL == 1)
    {
        if(self.isVoiceOn)
        {
            if(self.isEnglish)
            {
                notice = @"When you pressed Speaker button, I will tell you ten words slowly. When I'm done, press microphone button and please tell us as many of these words as possible. The order is not important. ";
            }
            else
            {
                notice = NSLocalizedString(@"Speaker", @"");
                [notice stringByAppendingString:NSLocalizedString(@"WordListNotice1", @"10개 단어 불러줌")];
                [notice stringByAppendingString:NSLocalizedString(@"Microphone", @"마이크")];
                [notice stringByAppendingString:NSLocalizedString(@"WordListNotice2", @"많이 말할수록 굿")];
            }
//            [self.tts play:notice];
        }
    }
    else if(self.periodWL == 2) // SECOND STEP
    {
        if(self.isVoiceOn)
        {
            notice = NSLocalizedString(@"WordListNotice3", @"2회차");
//            [self.tts play:self.lbWordListCaution.text];
//            [self.tts play:self.lbWordListCautionSecond.text];
        }
    }
    else
    {
        NSLog(@"something went wrong...");
    }
}

#pragma mark -  2. Number Conversion test
- (void)settingUpLocalizedSecondStep
{
    self.lbNumConvTitle.text = NSLocalizedString(@"NumConversionTitle", @"숫자변환제목");
    self.lbNumConvNotice.text = NSLocalizedString(@"NumConvMethod", @"숫자는 문자로");
    self.lbNumConvEx.text = NSLocalizedString(@"Example", @"예시");
    self.lbNumConvExAnsOne.text = NSLocalizedString(@"209", @"이백구");
    self.lbNumConvExQTwo.text = NSLocalizedString(@"354", @"삼백오십사");
    
    self.lbNumberConvMethod.text = NSLocalizedString(@"WriteHere", @"이곳에 써주어");
    
    [self.btnNumConvNext setTitle:NSLocalizedString(@"Next", @"다 음 >") forState:UIControlStateNormal];
}

- (void)bringNumberConversionNoticeToFront
{
    [self.view bringSubviewToFront:self.viewNumberConvTest];
    self.lbNumConvRiddle.text = [self getParsedSecondQuestionWithString:self.questionTwo AndIndex:0];
    NSString *numConvTTSNotice = NSLocalizedString(@"NumberConversion_TTS", @"숫자변환 안내사항");
//    [self.tts play:numConvTTSNotice];
}

- (NSString *)getParsedSecondQuestionWithString:(NSString *)question AndIndex:(NSInteger)cnt
{
    NSString *result = @"";
    //@"209/4054/six hundred and eighty one/two thousand and twenty";
    
    NSArray *subString = [question componentsSeparatedByString:@"/"];
    result = [subString objectAtIndex:cnt];
    
    return result;
}

- (void)captureWritingView:(UIView *)targetView
{
//    UIGraphicsBeginImageContextWithOptions(targetView.bounds.size, targetView.isOpaque, 1.0);
//    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
//    return resultImage;
    
    NSString *dirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSDateFormatter *fileNameFormat = [[NSDateFormatter alloc] init];
    [fileNameFormat setDateFormat:@"yyyyMMddHHmmss"];
    NSString *fileName = @"";
    fileName = [fileNameFormat stringFromDate:[NSDate date]];
    fileName = [fileName stringByAppendingString:[NSString stringWithFormat:@"_2_%ld.png", self.secondPhase]];
    NSLog(@"captureWritingView filename : %@", fileName);
    
    NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
    [self.fileLocation addObject:fileName];
    
    /* creating image context to create an image using view */
    
    UIGraphicsBeginImageContext(targetView.bounds.size);
    [targetView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    [imageData writeToFile:filePath atomically:YES];
    
}

- (void)bringNumberConversionNoticeToFrontWithPhase:(NSInteger)cnt
{
    self.lbNumConvRiddle.text = [self getParsedSecondQuestionWithString:self.questionTwo AndIndex:cnt];
    [self.view bringSubviewToFront:self.viewNumberConvTest];
}

- (void)settingUpNumCovAnimation
{
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(NumConvNoticeAnimation:) userInfo:nil repeats:NO];
}

- (void)NumConvNoticeAnimation:(NSTimer *)timer
{
    [UIView animateWithDuration:2.0 animations:^{
        self.lbNumConvExQOne.alpha= 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 delay:2.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.lbNumConvExAnsOne.alpha= 1.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.4 delay:2.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.lbNumConvExQTwo.alpha= 1.0;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.4 delay:2.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    self.lbNumConvExAnsTwo.alpha= 1.0;
                } completion:^(BOOL finished) {
                    // 화면 전환
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        self.viewNumberConvNotice.alpha = 0.0;
                        [UIView animateWithDuration:1.0 delay:2.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                            self.lbNumberConvMethod.alpha = 0.0;
                        } completion:nil];
                    });
                }];
            }];
        }];
    }];
    [UIView commitAnimations];
    
}

- (IBAction)btnClickedReplayInst:(id)sender
{
    // Replay Number Conversion Instruction
    NSLog(@"Movie????? How to replay instruction?");
}

- (IBAction)btnClickedProgress:(id)sender
{
    // Progress Number Conversion Test
    self.viewNumberConvNotice.hidden = YES;
    
    CATransition *animation = [CATransition animation];
    animation.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionFade;
    animation.duration = 1.0;
    [self.lbNumberConvMethod.layer addAnimation:animation forKey:@"kCATransitionFade"];
    
    self.lbNumberConvMethod.alpha = 0.0;
    self.lbNumberConvMethod.hidden = YES;
    [self. lbNumberConvMethod setUserInteractionEnabled:NO];
    
}

- (void)retrieveNewWritingArea
{
    self.viewWritingArea = [self.viewWritingArea initWithFrame:self.viewWritingArea.frame];
}

- (IBAction)btnClickedConversionNext:(id)sender
{
    [self captureWritingView:self.viewWritingArea];
    [self retrieveNewWritingArea];
    [self.view bringSubviewToFront:self.viewNext];
    
}

- (IBAction)btnClickedKeyboardInput:(id)sender
{
    if(!self.isKeyboard)
    {
        self.txFieldForKeyInput.hidden = NO;
        self.viewWritingArea.userInteractionEnabled = NO;
        [self.txFieldForKeyInput becomeFirstResponder];
        [self.btnKeyboard setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateNormal];
        self.isKeyboard = YES;
    }
    else
    {
        self.txFieldForKeyInput.hidden = YES;
        self.viewWritingArea.userInteractionEnabled = YES;
        [self.txFieldForKeyInput resignFirstResponder];
        [self.btnKeyboard setImage:[UIImage imageNamed:@"pen"] forState:UIControlStateNormal];
        self.isKeyboard = NO;
    }
}

#pragma mark -  TextField Delegate

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

#pragma mark -  3. Record Answers of patient for 1 minutes
- (void)settingUpLocalizedThirdStep
{
    self.lbSupermarketTitle.text = NSLocalizedString(@"SupermarketTitle", @"이름 대기 타이틀");
    self.lbSuperMarketNotice.attributedText = [ViewController getLineSpacedAttributedStringWithString:NSLocalizedString(@"SupermarketNotice", @"말해주세용")];
    self.lbSupermarketClickPlz.text = NSLocalizedString(@"SupermarketButton", @"버튼 플리즈");
}


- (void)bringSupermarketTestToFront
{
    [self.view bringSubviewToFront:self.viewSuperMarketTest];
}

- (IBAction)btnClickedSuperMarketRecord:(id)sender
{
    [self bringRecordingViewToFront];
}

- (IBAction)btnClickedNumReversionTmp:(id)sender
{
    // NEXT
    [self.view bringSubviewToFront:self.viewReverseNumber];
//    [self.tts play:self.lbNoticeReverseNum.text];
    NSString *noticeForNumReversionTTS = NSLocalizedString(@"SupermarketNotice_TTS", @"슈퍼마켓 안내");
//    [self.tts play:noticeForNumReversionTTS];
}


#pragma mark -  4. Number reverse given number sequences
- (void)settingUpLocalizedFourthStep
{
    self.lbTitleReverseNum.text = NSLocalizedString(@"ReverseNumber", @"4. 숫자거꾸로말하기");
    self.lbNoticeReverseNum.text = NSLocalizedString(@"NumReverseNotice", @"거꾸로안내");
    self.lbExReverseNum.text = NSLocalizedString(@"Example", @"예시");
    self.lbExReNumQ.text = NSLocalizedString(@"FourFive", @"사오");
    self.lbExReNumAns.text = NSLocalizedString(@"FiveFour", @"오사");
    [self.btnTrialReverseNum setTitle:NSLocalizedString(@"GoQuestion", @"문제를푸세용") forState:UIControlStateNormal];
}

- (void)bringReverseNumberViewToFront
{
    [self.view bringSubviewToFront:self.viewReverseNumber];
    NSString *noticeForNumReverseTTS = NSLocalizedString(@"NumReverseNotice_TTS", @"숫자 역순환 안내");
//    [self.tts play:noticeForNumReverseTTS];
}

- (void)bringTryViewWithPhase:(NSInteger)phase
{
    NSLog(@"phase : %ld", self.fourthPhase);
    [self setTryViewWithCnt:phase];
    
}

- (IBAction)btnClickedReverseNumReplay:(id)sender
{
    // TTS
    if(self.isVoiceOn)
    {
//        [self.tts play:self.lbNoticeReverseNum.text];
    }
}

// 문제풀기
- (IBAction)btnClickedReverseNumRecord:(id)sender
{
    [self showReverseNoticeViewWithCnt:1];
//    // Record and analysis
//    if(self.isVoiceOn && !self.isRecording)
//    {
//        if(self.speechRecognizer != nil) {
//            if(self.speechRecognizer.checkIsWorking == YES) {
//                NSLog(@"It's already working!!!");
//                return ;
//            }
//        }
//
//        // 문제 출제!
//        self.strReverseNumberProblem = [self createRandomNumberForReversionWithNumber:self.numReverseCnt];
//        self.lbNoticeReverseNum.text = self.strReverseNumberProblem;
//
//        // 답지 생성
//        self.strReverseNumberSolution = [self reverseProblemStringWithTargetString:self.strReverseNumberProblem];
//
//        self.isRecording = YES;
//        [self.btnTrialReverseNum setTitle:@"Recording..." forState:UIControlStateNormal];
//
//        NSMutableDictionary *config = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                       SpeechRecognizerServiceTypeDictation, SpeechRecognizerConfigKeyServiceType, nil];
//
//        self.speechRecognizer = [[MTSpeechRecognizerClient alloc] initWithConfig:config];
//        [self.speechRecognizer setDelegate:self];
//
//        [self.speechRecognizer startRecording];
//    }
//    else // RECORDING 일 때 STOP THE RECORDER
//    {
//        if(self.isRecording == YES)
//        {
//            [self.btnTrialReverseNum setTitle:@"시도하기" forState:UIControlStateNormal];
//            [self.speechRecognizer stopRecording];
//            self.isRecording = NO;
//
//        }
//    }
}

- (void)showReverseNoticeViewWithCnt:(NSInteger)cnt
{
    [self.viewReverseNumber bringSubviewToFront:self.viewReverseNotice];
    self.lbReverseNotice.text = [NSString stringWithFormat:@"This is your %ld try.", cnt];
    self.lbReverseCount.text = @"3";
    [self settingThreeSecondsTimer];
}

- (void)dissolveReverseNoticeView
{
    threeSeconds = 3;
    self.fourthPhase++;
    [self setTryViewWithCnt:2];
}

-(void)setRecordingViewForNumberConversion:(BOOL)flag andCount:(NSInteger)cnt
{
    if(flag)
    {
        NSString *notice = [NSString localizedStringWithFormat:NSLocalizedString(@"NumReverseNoticeCnt", @"2~6개 거꾸로 말해보세요"), cnt];
        
        notice = [notice stringByAppendingString:@"\n\n"];
        notice = [notice stringByAppendingString:[self getAttributedStringWithSpace:NSLocalizedString(@"NumReverseNoticeRecording2", @"")]];
        
        //    NSLog(@"this is notie : %@", notice);
        self.lbNoticeRecording.attributedText = [ViewController getLineSpacedAttributedStringWithString:notice];
    }
    else
    {
        [self settingUpLocalizedRecordingView];
    }
}

- (void)setTryViewWithCnt:(NSInteger)cnt
{
    [self setRecordingViewForNumberConversion:YES andCount:cnt];
    
    NSString *problem = [self createRandomNumberForReversionWithNumber:cnt];
    [self.fourthProblems addObject:problem];
    
//    [self.view bringSubviewToFront:self.viewRecording];
//    [self bringRecordingViewToFront];
    [self bringRecordingViewToFrontWithFourthProblems:problem];
}

- (void)bringRecordingViewToFrontWithFourthProblems:(NSString *)prob
{
//    [self.tts play:prob];
    [self bringRecordingViewToFront];
}

- (void)settingThreeSecondsTimer
{
    if([counter isValid]) [counter invalidate];
    
    counter = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
}

- (void)countDown
{
    NSLog(@"TIMER : %d", threeSeconds);
    self.lbReverseCount.text = [NSString stringWithFormat:@"%d", threeSeconds];
    threeSeconds--;
    
    if(threeSeconds < 0){
        NSLog(@"TIMER IS DONE!!!");
        [counter invalidate];
        [self dissolveReverseNoticeView];
    }
}

- (NSString *)createRandomNumberForReversionWithNumber:(NSInteger)desiredCnt
{
    NSString *problemStr = @"";
    for (int i = 1; i < desiredCnt+1; i++) {
        
        int r1 = arc4random_uniform(9); // 0 , 1
//        NSLog(@"create number : %d", r1);
        if([problemStr length] == 0)
        {
//            NSLog(@"the first one r1 : %d", r1);
            problemStr = [problemStr stringByAppendingString:[NSString stringWithFormat:@"%d", r1]];
//            NSLog(@"the first string : %@", string);
            continue;
        }
        else // 첫번째 숫자가 아닐 때
        {
//            NSString *lastChar = [problemStr substringFromIndex:[problemStr length] - 1];
//            NSLog(@"last char : %@", lastChar);
            BOOL isSame = [problemStr hasSuffix:[NSString stringWithFormat:@"%d", r1]];
            if(isSame) // 같은 숫자일때 다시 생성
            {
                int r2 = arc4random_uniform(9);
                problemStr = [problemStr stringByAppendingString:[NSString stringWithFormat:@"%d", r2]];
//                NSLog(@"r2 : %d", r2);
//                NSLog(@"result string : %@", string);
            }
            else
            {
                problemStr = [problemStr stringByAppendingString:[NSString stringWithFormat:@"%d", r1] ];
//                NSLog(@"Added different value = %@", string);
            }
        }
    }
    return problemStr;
}

- (NSString *)reverseProblemStringWithTargetString:(NSString *)input
{
    NSInteger leng = [input length];
    NSMutableString *reverseStr = [[NSMutableString alloc] initWithCapacity:leng];
    for(NSInteger i = leng-1; i>=0; i--)
    {
        [reverseStr appendString:[NSString stringWithFormat:@"%c",[input characterAtIndex:i]]];
    }
    NSLog(@"reverseStr : %@", reverseStr);
    
    return reverseStr;
}

- (NSString *)makeCombinationStringOfFourthProblems
{
    NSMutableString *append = [NSMutableString string];
    
    for (int i=0; i<self.fourthProblems.count; i++) {
        [append appendString:[NSMutableString stringWithFormat:@"%@/", [self.fourthProblems objectAtIndex:i]]];
//        NSLog(@"append : %@", append);
    }
    
    NSString *result = [NSString stringWithString:append];
//    NSLog(@"result : %@", append);
    
    return result;
}

- (IBAction)btnClickedGotoRepeatWordTmp:(id)sender
{
    [self.view bringSubviewToFront:self.viewRepeatWords];
//    [self.tts play:self.lbNoticeRepeatWords.text];
}


#pragma mark -  5. Repeat Word List
- (void)settingupLocalizedFifthStep
{
    self.lbRepeatWordsTitle.text = NSLocalizedString(@"RepeatWordsTitle", @"5. 기억회상하기");
    self.lbNoticeRepeatWords.attributedText = [ViewController getLineSpacedAttributedStringWithString:NSLocalizedString(@"RepeatWordsNotice", @"말해주쎄용")];
    self.lbRepeatWordsClickBtn.text = NSLocalizedString(@"RepeatWordsButton", @"클릭엔쎄이");
}

-(void)bringRepeatWordListViewToFront
{
    [self setRecordingViewForNumberConversion:NO andCount:0];
    [self.view bringSubviewToFront:self.viewRepeatWords];
}

- (IBAction)btnClickedWordListRecord:(id)sender {

    [self bringRecordingViewToFront];
}
- (IBAction)btnClickedReplayRecordedOne:(id)sender{
    [self recordReplay];
}

#pragma mark -      6. End of Test

- (void)settingUpLocalizedTestEndView
{
    self.lbNoticeTestEnd.attributedText = [ViewController getLineSpacedAttributedStringWithString:NSLocalizedString(@"TestEndNotice", @"테스트끄읕")];
}

- (void)bringEndOfTestViewToFront
{
    [self.view bringSubviewToFront:self.viewEndofTest];
    
    NSLog(@"count : %ld", self.fileLocation.count);
    
    [self.transferModel startFileTransferWithFileURLArray:self.fileLocation WithView:self.viewProgress WithProgress:self.barProgress];
    
    NSDictionary *testInfo = @{@"PAT_ID" : [NSString stringWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"index"]],
                               @"TEST_IDX" : [NSString stringWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"TEST_Date"]],
                               @"TEST_SET" : [NSString stringWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"TestID"]],
                               @"TEST_FOURTH_SET" : [self makeCombinationStringOfFourthProblems]};
    
    NSLog(@"testInfo : %@", testInfo);
    
    [self.httpModel sendTestResultsWithTestInformation:testInfo andComplemtion:^(NSDictionary *json, BOOL success)
    {
        if(success)
        {
//            NSDictionary *dictionary = [json objectF]
            NSLog(@"bringEndOfTestViewToFront : Test result enrollment succeed!");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                int i = 0;
                for (i=0; i<self.fileLocation.count; i++) {
                    NSLog(@"file name : %@", [self.fileLocation objectAtIndex:i]);
                }
                [self.btnGoWaitingFromDemTect sendActionsForControlEvents:UIControlEventTouchUpInside];
            });
        }
        else {
            NSLog(@"bringEndOfTestViewToFront : Test result enrollment failed");
        }
    }];

    
}

#pragma mark - RECORDING PACE
// Recording
- (void)recordWordListWithPeriod:(NSInteger)inputPeriod
{
    if(self.stepCnt == 1)    {self.isOnProgressWL = YES;}
    
    NSString *dirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSDateFormatter *fileNameFormat = [[NSDateFormatter alloc] init];
    [fileNameFormat setDateFormat:@"yyyyMMddHHmmss"];
    
    NSString *fileNameStr = @"";
    fileNameStr = [fileNameFormat stringFromDate:[NSDate date]];
    
    if(inputPeriod == 1) // 첫번째 시도
    {
        fileNameStr = [fileNameStr stringByAppendingString:@"_1_1.m4a"];
    }
    else if(inputPeriod == 2)// 두번째 시도
    {
        fileNameStr = [fileNameStr stringByAppendingString:@"_1_2.m4a"];
    }
    else if(inputPeriod == 3) // 3. Supermarket
    {
        fileNameStr = [fileNameStr stringByAppendingString:@"_3.m4a"];
    }
    else if(inputPeriod == 4)
    {
        fileNameStr = [fileNameStr stringByAppendingString:@"_4"];
        fileNameStr = [fileNameStr stringByAppendingFormat:@"_%ld.m4a", self.fourthPhase];
    }
    else if(inputPeriod == 5) // 5. Repeat Words
    {
        fileNameStr = [fileNameStr stringByAppendingString:@"_5.m4a"];
    }
    else
    {
        NSLog(@"recordWordListWithPeriod : SOMETHING WENT WRONG");
    }
    
    NSLog(@"fileNamae : %@", fileNameStr);
    
    NSURL *audioURL = [NSURL fileURLWithPath:[dirPath stringByAppendingPathComponent:fileNameStr]];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    NSMutableDictionary *setting = [[NSMutableDictionary alloc] init];
    [setting setValue:[NSNumber numberWithInteger:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [setting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [setting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    
    recorder = [[AVAudioRecorder alloc] initWithURL:audioURL settings:setting error:nil];
    recorder.meteringEnabled = YES;
    [recorder prepareToRecord];
    [recorder record];
    
}

- (void)stopRecorder
{
    [recorder stop];
    
    AVAudioSession * session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
//    NSLog(@"url : %@", [recorder.url absoluteString]);
    [self.fileLocation addObject:[recorder.url absoluteString]];
    NSLog(@"file location # : %ld", self.fileLocation.count);
//    [self.transferModel startFileTransferWithFileURL:[recorder.url absoluteString] WithView:self.viewProgress WithProgress:self.barProgress]; // NO NEED
}


- (void)recordReplay
{
    if(!recorder.recording)
    {
        NSLog(@"PLAY!!!!!");
        player = [[AVPlayer alloc] initWithURL:recorder.url];
        [player play];
    }
}

// MTTextToSpeechDelegate

- (void) onFinished {
//    if (_tts != nil) {
//        _tts = nil;
//    }
    
    NSLog(@"FINISHED!");
}

- (void)onReady{
    
}

- (void)onBeginningOfSpeech{
    
}

- (void)onEndOfSpeech{
    NSLog(@"SPEECH END!!");
    
}

//- (void) onError:(MTTextToSpeechError)errorCode message:(NSString *)message {
//    NSLog(@"onErrorOccured errorCode : %ld, message : %@", (long)errorCode, message);
//    if (_tts != nil) {
//        _tts = nil;
//    }
//
//    if (self.speechRecognizer) {
//        self.speechRecognizer = nil;
//    }
//    self.statusMessage.text = message;
//}
//
//
//- (void)onPartialResult:(NSString *)partialResult
//{
//    NSString *result = partialResult;
//    if (result.length > 0) {
//        self.statusMessage.text = result;
//        self.statusMessage.frame = CGRectMake(self.statusMessage.frame.origin.x, self.statusMessage.frame.origin.y, 282.f, self.statusMessage.frame.size.height);
//    }
//}
//
//- (void)onResults:(NSArray *)results confidences:(NSArray *)confidences marked:(BOOL)marked
//{
////    self.resultText.text = @"";
//    if (self.speechRecognizer) {
//        self.speechRecognizer = nil;
//    }
//
//    [self.btnTrialReverseNum setTitle:@"시도하기" forState:UIControlStateNormal];
//    [self.speechRecognizer stopRecording];
//    self.isRecording = NO;
//
//    BOOL boolList = TRUE;
//
//    if (boolList) {
//        NSMutableString *resultLabel = [[NSMutableString alloc] initWithString:@"result (confidence)\n"];
//
//        for (int i = 0; i < [results count]; i++) {
//            [resultLabel appendString:[NSString stringWithFormat:@"%@ (%d)\n", [results objectAtIndex:i], [[confidences objectAtIndex:i] intValue]]];
//        }
//
//        NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
//        NSMutableString *result = [results objectAtIndex:0];
//
//        // Confirm string has only numbers
//        if ([result rangeOfCharacterFromSet:notDigits].location == NSNotFound)
//        {
//            // newString consists only of the digits 0 through 9
//            NSInteger confidence = [[confidences objectAtIndex:0] intValue];
//            if(confidence > 5)
//            {
//                NSLog(@"result object at index 0 : %@", [results objectAtIndex:0]);
//                NSLog(@"CLASS IS : %@", NSStringFromClass([[results objectAtIndex:0] class]));
//                // ** [results objectAtIndex:0] : NSTaggedPointerString
//                self.recognitionResult = [NSString stringWithString:[results objectAtIndex:0]];
//
//                if(![self.recognitionResult isEqualToString:@""]) // result가 들어왔을 때
//                {
////                   // 내가 뭘 하려고 했더라 아 문제랑 결과값이랑 같은지 퐌단..? 인가? 틀리면 넘어가나 안 넘어가나 모르겟네
//                    NSLog(@"reconizedResult : %@, Solution : %@", self.recognitionResult, self.strReverseNumberSolution);
//                    if([self.recognitionResult isEqualToString:self.strReverseNumberSolution])
//                    {
//                        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Correct"
//                                                                                       message:@"맞췄당"
//                                                                                preferredStyle:UIAlertControllerStyleAlert];
//
//                        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//                                                                              handler:^(UIAlertAction * action) {}];
//
//                        [alert addAction:defaultAction];
//                        [self presentViewController:alert animated:YES completion:nil];
//                        self.numReverseCnt++;
//
//                    }
//                    else // 검사 중단!!
//                    {
//                        self.numReverseCnt = 2;
//                        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Incorrect"
//                                                                                       message:@"처음부터 다시 시작합니다."
//                                                                                preferredStyle:UIAlertControllerStyleAlert];
//
//                        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//                                                                              handler:^(UIAlertAction * action) {}];
//
//                        [alert addAction:defaultAction];
//                        [self presentViewController:alert animated:YES completion:nil];
//                    }
//                }
//            }
//            else
//            {
//                NSLog(@"잘 인식되지 않습니다. 다시 시도해주세요우~");
//            }
//        }
//        else        // 인식 결과가 숫자가 아닐 때
//        {
//            self.recognitionResult = @"";
//            // 다시 시도하게 하는 로직 필요함
//        }
//
//        NSLog(@"RESULT : %@", resultLabel);
//
//    } else {
//        NSString *result = [results objectAtIndex:0];
//        NSLog(@"results : %@", result);
//    }
//}
//
//- (void)onAudioLevel:(float)audioLevel {
//
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
