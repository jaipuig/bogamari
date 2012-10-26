//
//  LKXAApi.h
//  Client
//
//  Created by Daniel Devesa Derksen-Staats on 26/10/12.
//  Copyright (c) 2012 bogamari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define BASE_URL @"http://finappsapi.bdigital.org/api/2012/"
#define API_KEY @"adcfbc8183/"

enum types {
    kApiRegister,
    kApiLogin
    };

@protocol LKXAApiDelegate

- (void)requestSucceededWithResponse:(NSDictionary *)response forType:(int)type;
- (void)requestFailedWithError:(NSError *)error forType:(int)type;

@end

@interface LKXAApi : AFHTTPClient

@property (strong, nonatomic) id delegate;

- (void)registerUserWithUserName:(NSString *)userName password:(NSString *)password name:(NSString *)name lastName:(NSString *)lastName andAddress:(NSDictionary *)address;
- (void)loginWithUser:(NSString *)user andPassword:(NSString *)password;

- (void)clientPaymentWithIdCard:(NSString *)idCard code:(NSString *)code forValue:(double) value;

//- (void)commerceBilling:

@end
