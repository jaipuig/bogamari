//
//  BGMCardSelectionViewController.h
//  Client
//
//  Created by Daniel Devesa Derksen-Staats on 27/10/12.
//  Copyright (c) 2012 bogamari. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QREncoder/QREncoder.h>
#import <QuartzCore/QuartzCore.h>

#import "LKXAApi.h"

@interface BGMCardSelectionViewController : UIViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *card1;
@property CGPoint card1InitialPosition;
@property (weak, nonatomic) IBOutlet UIView *pinView;
@property (weak, nonatomic) IBOutlet UITextField *pinField;
@property (weak, nonatomic) IBOutlet UIView *qrView;
@property (weak, nonatomic) IBOutlet UIImageView *qrImage;
@property (strong, nonatomic)LKXAApi *api;
@property (strong, nonatomic)NSString *token;

- (IBAction)showQRCode:(id)sender;

@end
