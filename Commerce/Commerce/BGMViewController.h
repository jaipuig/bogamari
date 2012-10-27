//
//  BGMViewController.h
//  Commerce
//
//  Created by Daniel Devesa Derksen-Staats on 26/10/12.
//  Copyright (c) 2012 bogamari. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SectionModel.h"
#import "ProductModel.h"
#import "BGMSectionsCell.h"

#import "ZBarSDK.h"

@interface BGMViewController : UIViewController <UIImagePickerControllerDelegate,ZBarReaderDelegate, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>{
    
    IBOutlet UITextView *resultTextView;
}

@property (strong, nonatomic) NSMutableArray *sections;
@property (weak, nonatomic) IBOutlet UITableView *sectionsTable;
@property (weak, nonatomic) IBOutlet UITableView *ticketTable;
@property (weak, nonatomic) IBOutlet UICollectionView *productosCollection;

- (IBAction)ScanQRButtonTouch:(id)sender;



@end
