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


/**
 * registerUserWithUserName
 *
 * Method to create a new Client
 */
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

/**
 * loginWithUser
 *
 * Method to obtain a token from a Client or a Commerce
 */
- (void)loginWithUser:(NSString *)user andPassword:(NSString *)password {
    
    
    //Metodo 1
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue setName:@"Perform request"];
    [queue addOperationWithBlock:^{
        
        NSString *function = @"access/login/";
        NSString *parameters = [NSString stringWithFormat:@"?user=%@&password=%@", user, password];
        NSString *functionWithParameters = [NSString stringWithFormat:@"%@%@", function, parameters];
        
        //NSURL *finalURL = [NSURL URLWithString:[self composeURLWithFunction:functionWithParameters andToken:@""]];
        NSURL *finalURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:%@@finappsapi.bdigital.org/api/2012/%@/%@", user, password, API_KEY, functionWithParameters]];
        
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
            NSLog(@"Token: %@", [jsonData objectForKey:@"token"]);
            
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
    
    /*
    //Metodo 2
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
     */
}

/**
 * clientPaymentWithIdCard
 *
 * Returns  an identifier to pay using a specific contracted card (”value” is the money to pay)
 */
- (void)clientPaymentWithIdCard:(NSString *)idCard code:(NSString *)code forValue:(double) value withToken:(NSString *) token{

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue setName:@"Perform request"];
    [queue addOperationWithBlock:^{
        
        NSString *function = @"payment/";
        NSString *parameters = [NSString stringWithFormat:@"?idCard=%@&code=%@&value=%f", idCard, code, value];
        NSString *functionWithParameters = [NSString stringWithFormat:@"%@%@", function, parameters];
        
        //NSURL *finalURL = [NSURL URLWithString:[self composeURLWithFunction:functionWithParameters andToken:@""]];
        NSURL *finalURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://finappsapi.bdigital.org/api/2012/%@%@/%@", API_KEY, token, functionWithParameters]];
        
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
                [self.delegate requestFailedWithError:requestError forType:kApiPayment];
            }];
        }
        else {
            NSError *error;
            
            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            NSLog(@"jsonData: %@", jsonData);
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (!error) {
                    [self.delegate requestSucceededWithResponse:jsonData forType:kApiPayment];
                }
                else {
                    [self.delegate requestFailedWithError:error forType:kApiPayment];
                }
            }];
        }
    }];

}

#pragma mark Metodes per revisar el seu correcte funcionament

/**
 * clientCardsListWithToken
 *
 * Lists the client’s cards
 */
- (void)clientCardsListWithToken:(NSString *)token{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue setName:@"List cards of client request"];
    [queue addOperationWithBlock:^{
        
        NSString *function = @"operations/card/list";
    
        NSURL *finalURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://finappsapi.bdigital.org/api/2012/%@%@/%@", API_KEY, token, function]];
        
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
                [self.delegate requestFailedWithError:requestError forType:kApiCardsList];
            }];
        }
        else {
            NSError *error;
            
            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            NSLog(@"jsonData: %@", jsonData);
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if (!error) {
                    [self.delegate requestSucceededWithResponse:jsonData forType:kApiCardsList];
                }
                else {
                    [self.delegate requestFailedWithError:error forType:kApiCardsList];
                }
            }];
        }
    }];

}


/**
 * registerNewCardWithId
 *
 * Creates a new card linked to an specific account
 */
- (void)registerNewCardWithId:(NSString *)idString number:(NSString *)number holder:(NSString *)holder linkAccount:(NSString *)linkAccount deprecateDate:(NSDate *)deprecateDate securityCode:(NSString *)securityCode mode:(NSString *)mode issuer:(NSString *)issuer creditOptions:(NSDictionary *)creditOptions{
   
    NSString *function = @"operations/card/@me";
    
    NSURL *url = [NSURL URLWithString:[self composeURLWithFunction:@"" andToken:nil]];
    
    NSLog(@"BaseURL: %@", url);
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:number forKey:@"number"];
    [parameters setObject:holder forKey:@"holder"];
    [parameters setObject:linkAccount forKey:@"linkAccount"];
    [parameters setObject:deprecateDate forKey:@"deprecateDate"];
    [parameters setObject:securityCode forKey:@"securityCode"];
    [parameters setObject:mode forKey:@"mode"];
    [parameters setObject:issuer forKey:@"issuer"];
    //[parameters setObject:creditOptions forKey:@"creditOptions"];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:function parameters:parameters];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSLog(@"JSON: %@", JSON);
        
        NSError *errorSerializing;
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:JSON options:kNilOptions error:&errorSerializing];
        
        if (errorSerializing) {
            NSLog(@"Error serializing JSON!");
        }
        else {
            [self.delegate requestSucceededWithResponse:jsonData forType:kApiNewCard];
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        //NSLog(@"Error: %@", error.description);
        
        [self.delegate requestFailedWithError:error forType:kApiNewCard];
        
    }];
    
    [operation start];
}


/**
 * registerCommerceWithUserName
 *
 * Method to create a new Commerce
 */

//El parámetro location de la API es (double, double)----> Modificarlo!
//También contiene NSDictionary anidados!!!
- (void)registerCommerceWithUserName:(NSString *)userName password:(NSString *)password firstname:(NSString *)firstname lastName:(NSString *)lastName addressHolder:(NSDictionary *)addressHolder publicName:(NSString *)publicName addressCommerce:(NSDictionary *)addressCommerce location:(NSString *) location{
   
    NSString *function = @"access/commerce";
    
    NSURL *url = [NSURL URLWithString:[self composeURLWithFunction:@"" andToken:nil]];
    
    NSLog(@"BaseURL: %@", url);
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:userName forKey:@"userName"];
    [parameters setObject:password forKey:@"password"];
    [parameters setObject:firstname forKey:@"firstname"];
    [parameters setObject:lastName forKey:@"lastName"];
    //[parameters setObject:addressHolder forKey:@"addressHolder"];
    [parameters setObject:publicName forKey:@"publicName"];
    //[parameters setObject:AddressCommerce forKey:@"AddressCommerce"];
    [parameters setObject:location forKey:@"location"];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:function parameters:parameters];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSLog(@"JSON: %@", JSON);
        
        NSError *errorSerializing;
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:JSON options:kNilOptions error:&errorSerializing];
        
        if (errorSerializing) {
            NSLog(@"Error serializing JSON!");
        }
        else {
            [self.delegate requestSucceededWithResponse:jsonData forType:kApiNewCommerce];
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        //NSLog(@"Error: %@", error.description);
        
        [self.delegate requestFailedWithError:error forType:kApiNewCommerce];
        
    }];
    
    [operation start];

}

/**
 * getClientProfileWithId
 *
 * Returns the client profile information
 */
- (void)getClientProfileWithId:(NSString *)idClient holder:(NSDictionary *)holder accounts:(NSString *)accounts cards:(NSString *)cards{
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    
//    [queue setName:@"Get Client Profile request"];
//    [queue addOperationWithBlock:^{
//        
//        NSString *function = @"operations/";
//        NSString *parameters = [NSString stringWithFormat:@"?idCard=%@&code=%@&value=%f", idCard, code, value];
//        NSString *functionWithParameters = [NSString stringWithFormat:@"%@%@", function, parameters];
//        
//        //NSURL *finalURL = [NSURL URLWithString:[self composeURLWithFunction:functionWithParameters andToken:@""]];
//        NSURL *finalURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://finappsapi.bdigital.org/api/2012/%@%@/%@", API_KEY, token, functionWithParameters]];
//        
//        NSLog(@"finalURL: %@", finalURL);
//        
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:finalURL
//                                                               cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
//                                                           timeoutInterval:10];
//        [request setHTTPMethod: @"GET"];
//        
//        NSError *requestError;
//        NSURLResponse *urlResponse = nil;
//        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
//        
//        if (requestError) {
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                [self.delegate requestFailedWithError:requestError forType:kApiPayment];
//            }];
//        }
//        else {
//            NSError *error;
//            
//            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//            
//            NSLog(@"jsonData: %@", jsonData);
//            
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                if (!error) {
//                    [self.delegate requestSucceededWithResponse:jsonData forType:kApiPayment];
//                }
//                else {
//                    [self.delegate requestFailedWithError:error forType:kApiPayment];
//                }
//            }];
//        }
//    }];
}

#pragma mark - private

/**
 * composeURLWithFunction
 *
 */
- (NSString *)composeURLWithFunction:(NSString *)function andToken:(NSString *)token {
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@", BASE_URL, API_KEY, function];
    
    return url;
}

@end
