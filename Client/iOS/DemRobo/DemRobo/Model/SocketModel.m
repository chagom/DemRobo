//
//  SocketModel.m
//  DemRobo
//
//  Created by Goeum Cha on 10/06/2018.
//  Copyright © 2018 ChaGoEum. All rights reserved.
//

#import "SocketModel.h"
#import "Config.h"
//#import <NEHotspotConfiguration>

@interface SocketModel ()
{
    GCDAsyncSocket *socket;
}

@end

@implementation SocketModel

+ (instancetype)sharedSocket
{
    static SocketModel *sharedSocket = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedSocket = [[SocketModel alloc] init];
    });
    
    return sharedSocket;
}

- (void)startSocketWithType
{
    socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    socket.delegate = self;
    
    NSError *error = nil;
    if([socket connectToHost:@"192.168.2.163" onPort:59 error:&error])
    {
        // If there was an error, it's likely something like "already connected" or "no delegate set"
        NSLog(@"I goofed: %@", error);
        NSLog(@"errorcode : %ld", error.code);
    }
    NSString *publicIP = [NSString stringWithContentsOfURL:[NSURL URLWithString:QboHost] encoding:NSUTF8StringEncoding error:nil];
    publicIP = [publicIP stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]]; // IP comes with a newline for some reason
    NSLog(@"publicIP : %@", publicIP);
    

    
}

- (void)socket:(GCDAsyncSocket *)sender didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSNumber *idxResult = [[NSUserDefaults standardUserDefaults] objectForKey:@"index"];
    NSLog(@"idxResult class : %@", [idxResult class]);
    //    NSData* idxData = [idxResult dataUsingEncoding:NSUTF8StringEncoding];
    [socket writeData:[[idxResult stringValue] dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:1];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag");
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag");
}



@end
