//
//  BGMViewController.h
//  Client
//
//  Created by Daniel Devesa Derksen-Staats on 26/10/12.
//  Copyright (c) 2012 bogamari. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LKXAApi.h"

@interface BGMViewController : UIViewController <LKXAApiDelegate>

@property (strong, nonatomic)LKXAApi *api;
- (IBAction)payButtonPressed:(id)sender;

@end
