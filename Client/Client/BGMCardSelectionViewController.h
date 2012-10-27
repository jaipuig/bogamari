//
//  BGMCardSelectionViewController.h
//  Client
//
//  Created by Daniel Devesa Derksen-Staats on 27/10/12.
//  Copyright (c) 2012 bogamari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGMCardSelectionViewController : UIViewController <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *card1;
@property CGPoint card1InitialPosition;

@end
