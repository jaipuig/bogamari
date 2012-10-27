//
//  BGMViewController.m
//  Commerce
//
//  Created by Daniel Devesa Derksen-Staats on 26/10/12.
//  Copyright (c) 2012 bogamari. All rights reserved.
//

#import "BGMViewController.h"

//
//#ifndef ZXQR
//#define ZXQR 1
//#endif
//
//#if ZXQR
//#import "QRCodeReader.h"
//#endif
//
//#ifndef ZXAZ
//#define ZXAZ 0
//#endif
//
//#if ZXAZ
//#import "AztecReader.h"
//#endif

//using namespace zxing;

@interface BGMViewController ()

@end

@implementation BGMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ScanQRButtonTouch:(id)sender
{
    
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    
    reader.readerView.torchMode = 0;
    
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    reader.modalPresentationStyle = UIModalPresentationPageSheet;
    
    // present and release the controller
    //[self presentModalViewController: reader animated: YES];
    [self presentViewController:reader animated:YES completion:nil];
}



- (void) imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    //NSLog(@"the image picker is calling successfully %@",info);
    // ADD: get the decode results
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    NSString *hiddenData = nil;
    
    for(symbol in results)
        hiddenData = [NSString stringWithString:symbol.data];
    
    
    // cerrar ventana
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if(hiddenData != nil)
    {
        NSLog(@"QR decodificado!!! %@",hiddenData);
        
        
    }
    
}


@end
