//
//  BGMViewController.m
//  Client
//
//  Created by Daniel Devesa Derksen-Staats on 26/10/12.
//  Copyright (c) 2012 bogamari. All rights reserved.
//
#import "BGMViewController.h"
#import <QREncoder/QREncoder.h>
#import <QuartzCore/QuartzCore.h>

static const CGFloat kPadding = 10;


@interface BGMViewController ()

@end

@implementation BGMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.api = [[LKXAApi alloc] init];
    self.api.delegate = self;
    
    //Register example
    /*
    NSMutableDictionary *address = [[NSMutableDictionary alloc] init];
    [address setObject:@"street" forKey:@"Bogamarí St."];
    [address setObject:@"number" forKey:@"6"];
    [address setObject:@"city" forKey:@"Xàbia"];
    [address setObject:@"postalCode" forKey:@"03730"];
    [address setObject:@"country" forKey:@"Spain"];
    
    [self.api registerUserWithUserName:@"dadederk" password:@"dadederk" name:@"Dani" lastName:@"Devesa" andAddress:address];
    */
    
    //Login example
    
    [self.api loginWithUser:@"dadederk" andPassword:@"dadederk"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LKXAApiDelegate

- (void)requestSucceededWithResponse:(NSDictionary *)response forType:(int)type {
    
    if (type == kApiRegister) {
        NSLog(@"kApiRegister: %@", response);
    }
    else if (type == kApiLogin) {
        
    }
    
}

- (void)requestFailedWithError:(NSError *)error forType:(int)type {
    
    NSLog(@"Error: %@", error.description);
    
}

- (IBAction)payButtonPressed:(id)sender {
    self.view.backgroundColor = [UIColor whiteColor];
    
	UIImage* image = [QREncoder encode:@"http://www.desfici.com"];
    
	UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    CGFloat qrSize = self.view.bounds.size.width - kPadding * 2;
	imageView.frame = CGRectMake(kPadding, (self.view.bounds.size.height - qrSize) / 2,
                                 qrSize, qrSize);
	[imageView layer].magnificationFilter = kCAFilterNearest;
    
	[self.view addSubview:imageView];

}
@end
