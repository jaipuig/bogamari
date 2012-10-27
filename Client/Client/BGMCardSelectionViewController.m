//
//  BGMCardSelectionViewController.m
//  Client
//
//  Created by Daniel Devesa Derksen-Staats on 27/10/12.
//  Copyright (c) 2012 bogamari. All rights reserved.
//

#import "BGMCardSelectionViewController.h"

@interface BGMCardSelectionViewController ()

@end

@implementation BGMCardSelectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.api = [[LKXAApi alloc] init];
    self.api.delegate = self;
    
    //Login example
    
    [self.api loginWithUser:@"dadederk" andPassword:@"dadederk"];
}

- (void)viewDidAppear:(BOOL)animated {
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveCard:)];
    //pan.delegate = self;
    
    [pan setMinimumNumberOfTouches:1];
    [pan setMaximumNumberOfTouches:1];
    
    self.card1InitialPosition = self.card1.center;
    [self.card1 addGestureRecognizer:pan];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moveCard:(id)sender {
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender locationInView:self.view];
    
    NSLog(@"%f x %f", translatedPoint.x, translatedPoint.y);
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        if (translatedPoint.y < self.card1InitialPosition.y) {
            [UIView beginAnimations:@"moveCard" context:nil];
            [UIView setAnimationDuration:0.5];
            CGPoint newPos = self.card1InitialPosition;
            newPos.y = translatedPoint.y;
            self.card1.center = newPos;
            [UIView commitAnimations];
        }
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        if (translatedPoint.y < self.card1InitialPosition.y) {
            CGPoint newPos = self.card1InitialPosition;
            newPos.y = translatedPoint.y;
            self.card1.center = newPos;
        }
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
    
        [self.card1 bringSubviewToFront:self.view];
        
        [UIView beginAnimations:@"moveCard" context:nil];
        [UIView setAnimationDuration:0.5];
        CGPoint newPos = self.card1InitialPosition;
        newPos.y = self.card1InitialPosition.y - self.card1.frame.size.height;
        self.card1.center = newPos;
        [UIView commitAnimations];
        
        [UIView beginAnimations:@"showPinView" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelay:0.5];
        self.pinView.alpha = 1.0;
        [UIView commitAnimations];
    }
}

- (IBAction)showQRCode:(id)sender {

    [self.pinField resignFirstResponder];
    self.pinView.alpha = 0.0;
    
    [UIView beginAnimations:@"showQRView" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:0.5];
    self.qrView.alpha = 1.0;
    [UIView commitAnimations];

    UIImage* image = [QREncoder encode:self.token];

	[self.qrImage layer].magnificationFilter = kCAFilterNearest;
    
    [self.qrImage setImage:image];
}

#pragma mark - LKXAApiDelegate

- (void)requestSucceededWithResponse:(NSDictionary *)response forType:(int)type {
    
    if (type == kApiLogin) {
        self.token = [response objectForKey:@"token"];
    }
    
}

@end
