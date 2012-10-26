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

@interface LKXAApi : AFHTTPClient

- (void)registerUserWithUserName:(NSString *)userName password:(NSString *)password name:(NSString *)name lastName:(NSString *)lastName andAddress:(NSDictionary *)address;

@end
