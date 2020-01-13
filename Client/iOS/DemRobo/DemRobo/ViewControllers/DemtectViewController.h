//
//  DemTectViewController.h
//  DemRobo
//
//  Created by Goeum Cha on 02/02/2018.
//  Copyright © 2018 ChaGoEum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "WritingArea.h"
//#import <KakaoCommon/KakaoCommon.h>
//#import <KakaoNewtoneSpeech/KakaoNewtoneSpeech.h>
//#import <KakaoNewtoneSpeech/KakaoNewToneTextToSpeech.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVKit/AVKit.h>


@interface DemtectViewController : ViewController

{
    AVAudioRecorder *recorder;
    AVPlayer *player;
}

// sound recognition required
@property (weak, nonatomic) IBOutlet UILabel *statusMessage;



@end
