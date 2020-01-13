//
//  SocketModel.h
//  DemRobo
//
//  Created by Goeum Cha on 10/06/2018.
//  Copyright © 2018 ChaGoEum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GCDAsyncSocket.h>



@interface SocketModel : NSObject <GCDAsyncSocketDelegate>


+ (instancetype)sharedSocket;
- (void)startSocketWithType;
@end
