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
    SectionModel *burguers = [[SectionModel alloc] init];
    burguers.name = @"Burguers";
    
    self.sections = [[NSMutableArray alloc] initWithObjects:burguers, nil];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int numRows = 0;
    
    if (tableView == self.sectionsTable) {
        numRows = [self.sections count];
    }
    
    return numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    BGMSectionsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (tableView == self.sectionsTable) {
        SectionModel *currentSection = [self.sections objectAtIndex:indexPath.row];
        
        [cell.title setText:currentSection.name];
        [cell.imageView setImage:currentSection.image];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


@end
