//
//  LKXAApi.m
//  Client
//
//  Created by Daniel Devesa Derksen-Staats on 26/10/12.
//  Copyright (c) 2012 bogamari. All rights reserved.
//

#import "LKXAApi.h"

@interface LKXAApi ()
- (NSString *)composeURLWithFunction:(NSString *)function andToken:(NSString *)token;
@end

@implementation LKXAApi

- (void)registerUserWithUserName:(NSString *)userName password:(NSString *)password name:(NSString *)name lastName:(NSString *)lastName andAddress:(NSDictionary *)address {
    
    NSString *function = @"access/client";
    
    NSURL *url = [NSURL URLWithString:[self composeURLWithFunction:@"" andToken:nil]];
    
    NSLog(@"BaseURL: %@", url);
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:userName forKey:@"username"];
    [parameters setObject:password forKey:@"password"];
    [parameters setObject:name forKey:@"firstName"];
    [parameters setObject:lastName forKey:@"lastName"];
    //[parameters setObject:@"address" forKey:address];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:function parameters:parameters];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSLog(@"JSON: %@", JSON);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        NSLog(@"Error: %@", error.description);
        
    }];
    
    [operation start];
    
    [operation start];
    
}

#pragma mark - private

- (NSString *)composeURLWithFunction:(NSString *)function andToken:(NSString *)token {
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@", BASE_URL, API_KEY, function];
    
    return url;
}

@end
