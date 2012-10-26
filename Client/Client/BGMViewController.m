//
//  BGMViewController.m
//  Client
//
//  Created by Daniel Devesa Derksen-Staats on 26/10/12.
//  Copyright (c) 2012 bogamari. All rights reserved.
//

#import "BGMViewController.h"

@interface BGMViewController ()

@end

@implementation BGMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.api = [[LKXAApi alloc] init];
    
    NSMutableDictionary *address = [[NSMutableDictionary alloc] init];
    [address setObject:@"street" forKey:@"Bogamarí St."];
    [address setObject:@"number" forKey:@"6"];
    [address setObject:@"city" forKey:@"Xàbia"];
    [address setObject:@"postalCode" forKey:@"03730"];
    [address setObject:@"country" forKey:@"Spain"];
    
    [self.api registerUserWithUserName:@"dadederk" password:@"dadederk" name:@"Dani" lastName:@"Devesa" andAddress:address];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
