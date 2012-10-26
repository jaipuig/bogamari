//
//  BGMViewController.h
//  Commerce
//
//  Created by Daniel Devesa Derksen-Staats on 26/10/12.
//  Copyright (c) 2012 bogamari. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZBarSDK.h"

@interface BGMViewController : UIViewController <UIImagePickerControllerDelegate,ZBarReaderDelegate>{
    
    IBOutlet UITextView *resultTextView;
    
    @private
        NSString* capturedQRInfo; // dnd se guarda la info del qr code cuando se encuentra
}
- (IBAction)ScanQRButtonTouch:(id)sender;

@end
