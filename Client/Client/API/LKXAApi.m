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
        
        //NSLog(@"JSON: %@", JSON);
        
        NSError *errorSerializing;
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:JSON options:kNilOptions error:&errorSerializing];
        
        if (errorSerializing) {
            NSLog(@"Error serializing JSON!");
        }
        else {
            [self.delegate requestSucceededWithResponse:jsonData forType:kApiRegister];
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        //NSLog(@"Error: %@", error.description);
        
        [self.delegate requestFailedWithError:error forType:kApiRegister];
        
    }];
    
    [operation start];
}

- (void)loginWithUser:(NSString *)user andPassword:(NSString *)password {
    
    /*
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue setName:@"Perform request"];
    [queue addOperationWithBlock:^{
        
        NSString *function = @"access/login/";
        NSString *parameters = [NSString stringWithFormat:@"?user=%@&password=%@", user, password];
        NSString *functionWithParameters = [NSString stringWithFormat:@"%@%@", function, parameters];
        
        NSURL *finalURL = [NSURL URLWithString:[self composeURLWithFunction:functionWithParameters andToken:@""]];
        
        NSLog(@"finalURL: %@", finalURL);
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:finalURL
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                           timeoutInterval:10];
        [request setHTTPMethod: @"GET"];
        
        NSError *requestError;
        NSURLResponse *urlResponse = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
        
        if (requestError) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.delegate requestFailedWithError:requestError forType:kApiLogin];
            }];
        }
        else {
            NSError *error;
            
            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            NSLog(@"jsonData: %@", jsonData);
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (!error) {
                    [self.delegate requestSucceededWithResponse:jsonData forType:kApiLogin];
                }
                else {
                    [self.delegate requestFailedWithError:error forType:kApiLogin];
                }
            }];
        }
    }];
    */
    
    NSURL *url = [NSURL URLWithString:[self composeURLWithFunction:@"" andToken:nil]];
    
    NSString *function = @"access/login";
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:user forKey:@"user"];
    [parameters setObject:password forKey:@"password"];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    //[httpClient setParameterEncoding:AFJSONParameterEncoding];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:function parameters:parameters];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        //NSLog(@"JSON: %@", JSON);
        
        NSError *errorSerializing;
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:JSON options:kNilOptions error:&errorSerializing];
        
        if (errorSerializing) {
            NSLog(@"Error serializing JSON!");
        }
        else {
            [self.delegate requestSucceededWithResponse:jsonData forType:kApiRegister];
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        //NSLog(@"Error: %@", error.description);
        
        [self.delegate requestFailedWithError:error forType:kApiRegister];
        
    }];
    
    [operation start];
}

#pragma mark - private

- (NSString *)composeURLWithFunction:(NSString *)function andToken:(NSString *)token {
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@", BASE_URL, API_KEY, function];
    
    return url;
}

@end
