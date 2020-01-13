//
//  FileTransferModel.h
//  DemRobo
//
//  Created by Goeum Cha on 23/05/2018.
//  Copyright © 2018 ChaGoEum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AWSS3/AWSS3.h>
//@import AWSCore;
#import "Config.h"

@interface FileTransferModel : NSObject

@property (copy, nonatomic) AWSS3TransferUtilityUploadCompletionHandlerBlock completionHandler;
@property (copy, nonatomic) AWSS3TransferUtilityProgressBlock progressBlock;

+(instancetype)sharedInstance;
- (void)startFileTransferWithFileURL:(NSString *)url WithView:(UIView *)targView WithProgress:(UIProgressView *)targProgress;
- (void)startFileTransferWithFileURLArray:(NSMutableArray *)nameArr WithView:(UIView *)targView WithProgress:(UIProgressView *)targProgress;
@end
