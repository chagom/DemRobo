//
//  HttpModel.m
//  DemRobo
//
//  Created by Goeum Cha on 02/06/2018.
//  Copyright © 2018 ChaGoEum. All rights reserved.
//

#import "HttpModel.h"



@implementation HttpModel

+(instancetype)sharedInstance
{
    static HttpModel *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HttpModel alloc] init];
    });
    
    return sharedInstance;
}

- (BOOL)getLogout
{
    BOOL result = FALSE;
    NSString *logoutURL = [URLString stringByAppendingString:@"logout.php"];
    NSLog(@"logout URL = %@", logoutURL);
//    NSDictionary *parameters = @{@"serial" : @"logout", @"info" : @{@"PAT_ID" : @"", @"session" : @""}};
    
//    NSMutableURLRequest *response = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:logoutURL parameters:parameters error:nil];
    // BLOW OUT ALL SESSIONS;
    
    return result;
    
}

- (void)getResultOfUserEnrollmentWithPatientInfo:(NSDictionary *)infoDic completion:(void (^)(NSDictionary *json, BOOL success))completion
{
    NSString *baseURL = [URLString stringByAppendingString:@"enroll.php"];
    
    NSLog(@"info Dictionary : %@", infoDic);
    
    NSDictionary *parameters =@{@"serial" : @"enroll", @"info" : infoDic};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:baseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"response object : %@", responseObject);
        NSLog(@"response class : %@", [responseObject class]);
        NSDictionary *js = responseObject;
//        NSDictionary *js = [responseObject objectAtIndex:0];
//        NSLog(@"response : %@", responseObject);
        
        if([[js objectForKey:@"status"] isEqualToString:@"OK"])
        {
            NSString *PAT_IDX = [[[js objectForKey:@"info"] objectAtIndex:0] objectForKey:@"idx"];
            NSLog(@"idx : %@", PAT_IDX);
            [[NSUserDefaults standardUserDefaults] setObject:PAT_IDX forKey:@"index"];
//            NSLog(@"SAVED default : %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"index"]);
            NSString *session = [[[js objectForKey:@"info"] objectAtIndex:0] objectForKey:@"sess"];
            [[NSUserDefaults standardUserDefaults] setObject:session forKey:@"sess"];
            if (completion)
                completion(js, YES);
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[ERROR]: %@", error);
        completion(nil, NO);
    }];
        
}

- (void)getLoginWithPatientInfo:(NSDictionary *)infoDic completion:(void (^)(NSDictionary *json, BOOL success))completion
{
    NSString *baseURL = [URLString stringByAppendingString:@"login.php"];
    NSDictionary *userInfo = @{@"serial" : @"login", @"info" : infoDic};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:baseURL parameters:userInfo progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"2");
        
        NSDictionary *js = [responseObject objectAtIndex:0];
        
        if([[js objectForKey:@"result"] isEqualToString:@"success"])
        {
            NSString *PAT_IDX = [[js objectForKey:@"info"] objectForKey:@"idx"];
            [[NSUserDefaults standardUserDefaults] setObject:PAT_IDX forKey:@"index"];
            if (completion)
                completion(js, YES);
        }
        else
        {
            if(completion)
                completion(nil, NO);
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[ERROR]: %@", error);
        completion(nil, NO);
    }];
}

- (void)getTestSetWithcompletion:(void (^)(NSDictionary *json, BOOL success))completion
{
    NSString *baseURL = [URLString stringByAppendingString:@"getTestSet.php"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:baseURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"response : %@", responseObject);
        completion(responseObject, YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[ERROR]: %@", error);
        completion(nil, NO);
    }];
}

- (void)sendTestResultsWithTestInformation:(NSDictionary *)testInfo andComplemtion:(void (^)(NSDictionary *json, BOOL success))completion
{
    NSString *baseURL = [URLString stringByAppendingString:@"sendTestResults.php"];
    
    NSDictionary *parameters =@{@"serial" : @"sendTestResults", @"info" : testInfo};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:baseURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"response object : %@", [responseObject class]);
        
        
        completion(responseObject, YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[ERROR] : %@", error);
        completion(nil, NO);
    }];
}

@end
