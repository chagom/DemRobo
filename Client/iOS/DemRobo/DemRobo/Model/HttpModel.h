//
//  HttpModel.h
//  DemRobo
//
//  Created by Goeum Cha on 02/06/2018.
//  Copyright © 2018 ChaGoEum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "Config.h"

@interface HttpModel : NSObject

+(instancetype)sharedInstance;
//- (void)jsonRequestWithBaseURL:(NSString *)baseURL function:(NSString *)function parameters:(NSDictionary *)parameters completion:(void (^)(NSDictionary *json, BOOL success))completion;
- (void)getResultOfUserEnrollmentWithPatientInfo:(NSDictionary *)infoDic completion:(void (^)(NSDictionary *json, BOOL success))completion;
- (void)getLoginWithPatientInfo:(NSDictionary *)infoDic completion:(void (^)(NSDictionary *json, BOOL success))completion;
- (void)getTestSetWithcompletion:(void (^)(NSDictionary *json, BOOL success))completion;
- (void)sendTestResultsWithTestInformation:(NSDictionary *)testInfo andComplemtion:(void (^)(NSDictionary *json, BOOL success))completion;

@end
