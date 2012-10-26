//
//  BGMViewController.h
//  Commerce
//
//  Created by Daniel Devesa Derksen-Staats on 26/10/12.
//  Copyright (c) 2012 bogamari. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXingWidgetController.h"
#import "ZBarSDK.h"

@interface BGMViewController : UIViewController <UIImagePickerControllerDelegate,ZBarReaderDelegate>{
    
    IBOutlet UITextView *resultTextView;
}
- (IBAction)ScanQRButtonTouch:(id)sender;

@end
