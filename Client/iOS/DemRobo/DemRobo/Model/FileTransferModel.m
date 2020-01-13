//
//  FileTransferModel.m
//  DemRobo
//
//  Created by Goeum Cha on 23/05/2018.
//  Copyright © 2018 ChaGoEum. All rights reserved.
//

#import "FileTransferModel.h"

@implementation FileTransferModel

+(instancetype)sharedInstance
{
    static FileTransferModel *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FileTransferModel alloc] init];
    });
    
    return sharedInstance;
}

- (void)startFileTransferWithFileURL:(NSString *)url WithView:(UIView *)targView WithProgress:(UIProgressView *)targProgress
{
    targView.hidden = NO;
    AWSS3TransferUtilityUploadExpression *expression = [AWSS3TransferUtilityUploadExpression new];
    AWSS3TransferUtilityProgressBlock progressBlock = ^(AWSS3TransferUtilityTask *task, NSProgress *progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            targProgress.progress = progress.fractionCompleted;
        });
    };
    expression.progressBlock = progressBlock;
    
    NSLog(@"METHOD file url : %@", url);

    self.completionHandler = ^(AWSS3TransferUtilityUploadTask *task, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"Error to upload");
            } else {
                NSLog(@"Successful");
                targProgress.progress = 1.0;
            }
        });
    };
    
    AWSS3TransferUtility *transferUtility = [AWSS3TransferUtility defaultS3TransferUtility];
    [transferUtility enumerateToAssignBlocksForUploadTask:^(AWSS3TransferUtilityUploadTask * _Nonnull uploadTask, AWSS3TransferUtilityProgressBlock  _Nullable __autoreleasing * _Nullable uploadProgressBlockReference, AWSS3TransferUtilityUploadCompletionHandlerBlock  _Nullable __autoreleasing * _Nullable completionHandlerReference) {
        NSLog(@"%lu", (unsigned long)uploadTask.taskIdentifier);
        
//        *uploadProgressBlockReference = weakSelf.progressBlock;
//        *completionHandlerReference = weakSelf.completionHandler;
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            self.statusLabel.text = @"Uploading...";
        });
    } downloadTask:nil];
    
    
    // 앞에 "/" 붙이면 이름 없는 폴더 하나 생김
    /* TEST
    NSString *S3UploadKeyName = @"PAT_0001/thisistestXZ.m4a";
    [transferUtility uploadFile:[NSURL URLWithString:url]
                         bucket:S3BucketName
                            key:S3UploadKeyName
                    contentType:@"multipart/form-data"
                     expression:expression
              completionHandler:^(AWSS3TransferUtilityUploadTask * _Nonnull task, NSError * _Nullable error) {
                   NSLog(@"Completed!");
              }];
     */

}

- (void)startFileTransferWithFileURLArray:(NSMutableArray *)nameArr WithView:(UIView *)targView WithProgress:(UIProgressView *)targProgress
{
    targView.hidden = NO;
    AWSS3TransferUtilityUploadExpression *expression = [AWSS3TransferUtilityUploadExpression new];
    AWSS3TransferUtilityProgressBlock progressBlock = ^(AWSS3TransferUtilityTask *task, NSProgress *progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //            targProgress.progress = progress.fractionCompleted;
        });
    };
    expression.progressBlock = progressBlock;

    
    self.completionHandler = ^(AWSS3TransferUtilityUploadTask *task, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"Error to upload");
            } else {
                NSLog(@"Successful");
                targProgress.progress = 1.0;
            }
        });
    };
    
    AWSS3TransferUtility *transferUtility = [AWSS3TransferUtility defaultS3TransferUtility];
    [transferUtility enumerateToAssignBlocksForUploadTask:^(AWSS3TransferUtilityUploadTask * _Nonnull uploadTask, AWSS3TransferUtilityProgressBlock  _Nullable __autoreleasing * _Nullable uploadProgressBlockReference, AWSS3TransferUtilityUploadCompletionHandlerBlock  _Nullable __autoreleasing * _Nullable completionHandlerReference) {
        NSLog(@"%lu", (unsigned long)uploadTask.taskIdentifier);
        
        //        *uploadProgressBlockReference = weakSelf.progressBlock;
        //        *completionHandlerReference = weakSelf.completionHandler;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //            self.statusLabel.text = @"Uploading...";
        });
    } downloadTask:nil];
    
    
    
    
    for (NSString *str in nameArr)
    {
        NSLog(@"target file str : %@", str);
        NSString *patientIdx = [[NSUserDefaults standardUserDefaults] objectForKey:@"index"];
        
        NSDateFormatter *fileNameFormat = [[NSDateFormatter alloc] init];
        [fileNameFormat setDateFormat:@"yyyyMMddHHmmss"];
        
        NSString *fileDateStr = @"";
        fileDateStr = [fileNameFormat stringFromDate:[NSDate date]];
        
        NSString *fileName = [str lastPathComponent];
        NSLog(@"last path : %@", fileName);
        
        // 앞에 "/" 붙이면 이름 없는 폴더 하나 생김
        NSString *fileKeyname = [NSString stringWithFormat:@"PAT_%@/%@/%@", patientIdx, fileDateStr, fileName];
        NSString *S3UploadKeyName = fileKeyname;
        
        //    dispatch_group_t transferGroup = dispatch_group_create();
        
        //    dispatch_group_enter(transferGroup);
        
        //    for (NSString *filePath in nameArr) {
        [transferUtility uploadFile:[NSURL URLWithString:str]
                             bucket:S3BucketName
                                key:S3UploadKeyName
                        contentType:@"multipart/form-data"
                         expression:expression
                  completionHandler:^(AWSS3TransferUtilityUploadTask * _Nonnull task, NSError * _Nullable error) {
                      //                      dispatch_group_leave(transferGroup);
                  }];
        //    }
    }
    
    

}


- (NSString *)getS3PathOfRecordedFile
{
    NSString *target = @"";
    
    return target;
}


@end
