//
//  LKXAApi.h
//  Client
//
//  Created by Daniel Devesa Derksen-Staats on 26/10/12.
//  Copyright (c) 2012 bogamari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKXAApi : NSObject

- (void)registerUserWithUserName:(NSString *)userName password:(NSString *)password name:(NSString *)name lastName:(NSString *)lastName andAddress:(NSDictionary *)address;

@end
