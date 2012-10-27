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
    
   [self loadSectionModel];
    //self.sections = [[NSMutableArray alloc] initWithObjects:burguers, nil];
    self.products = [[self.sections objectAtIndex:1] productArray];
    self.ticket = [[NSMutableArray alloc] init];
    
    [self.sectionsTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
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
    else if (tableView == self.ticketTable) {
        numRows = [self.ticket count];
    }
    
    return numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell;
    
    // Configure the cell...
    
    if (tableView == self.sectionsTable) {
        BGMSectionsCell *sectionCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        SectionModel *currentSection = [self.sections objectAtIndex:indexPath.row];
        
        [sectionCell.title setText:currentSection.name];
        [sectionCell.imageView setImage:currentSection.image];
        
        cell = sectionCell;
    }
    else if (tableView == self.ticketTable) {
        BGMTicketsCell *ticketCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        ProductModel *currentSection = [self.ticket objectAtIndex:indexPath.row];
        
        [ticketCell.name setText:currentSection.name];
        [ticketCell.image setImage:currentSection.image];
        [ticketCell.image.layer setBorderWidth:2.0];
        [ticketCell.image.layer setBorderColor:(__bridge CGColorRef)([UIColor grayColor])];
         NSString *priceString = [NSString stringWithFormat:@"%.2f€", currentSection.precio];
        [ticketCell.price setText:priceString];
        
        cell = ticketCell;
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
    
    SectionModel *currentSection = [self.sections objectAtIndex:indexPath.row];
    
    self.products = currentSection.productArray;
    
    [self.productosCollection reloadData];
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int height = 0;
    
    if (tableView == self.sectionsTable) {
        height = 45;
    }
    else if(tableView == self.ticketTable)
    {
        height = 53;
    }
    
    return height;
}


// Funciones del GridView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int numItems = 0;
    
    if (collectionView == self.productosCollection) {
        NSIndexPath* selectedSectionIndx = [self.sectionsTable indexPathForSelectedRow];
        SectionModel* selectedSection = (SectionModel*) [self.sections objectAtIndex:selectedSectionIndx.row];
        numItems = [selectedSection.productArray count];
    }
   
    
    return numItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BGMCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    
    if ([self.products count] > 0) {
        ProductModel *currentProduct = [self.products objectAtIndex:indexPath.row];
        
        [cell.title setText:currentProduct.name];
        [cell.picture setImage:currentProduct.image];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if ([self.products count] > 0)
    {
        ProductModel *currentProduct = [self.products objectAtIndex:indexPath.row];
        [self.ticket addObject:currentProduct]; // añadir a compra
        
        [self.ticketTable reloadData];
        
        self.totalTicket += currentProduct.precio;
        
        [self.totalPrice setText:[NSString stringWithFormat:@"%.2f", self.totalTicket]];
        
        self.totalProducts.text = [NSString stringWithFormat:@"%d", [self.totalProducts.text intValue] + 1];
    }
    
}


// Funciones de carga a saco, con pico, pala y sobre piedra dura
-(void)loadSectionModel
{
    self.sections = [[NSMutableArray alloc] init];
    
    //--- Section ----//
    SectionModel* section = [[SectionModel alloc] init];
    section.name = @"Aceite";
    //s2.image = ;
    
    // Productos de la sección
    section.productArray = [[NSMutableArray alloc] init];
    
    ProductModel* product = [[ProductModel alloc] init];
    product.name = @"Burguer 1";
    //product.image = ;
    [section.productArray addObject:product];
    
    [self.sections addObject:section];
    
    //--- Section ----//
    section = [[SectionModel alloc] init];
    section.name = @"Fruta y verdura";
    //s2.image = ;
    
    // Productos de la sección
    section.productArray = [[NSMutableArray alloc] init];
    
    product = [ProductModel alloc];
    product.name = @"Bananas";
    product.image = [UIImage imageNamed:@"bananas.jpg"];
    product.precio = 5;
    [section.productArray addObject:product];
    
    product = [ProductModel alloc];
    product.name = @"Calabacín";
    product.image = [UIImage imageNamed:@"calabacin.jpg"];
    product.precio = 2;
    [section.productArray addObject:product];
    
    product = [ProductModel alloc];
    product.name = @"Champiñón";
    product.image = [UIImage imageNamed:@"champinyon.jpg"];
    product.precio = 1.5;
    [section.productArray addObject:product];
    
    product = [ProductModel alloc];
    product.name = @"Chirimoya";
    product.image = [UIImage imageNamed:@"chirimoya.jpg"];
    product.precio = 3.45;
    [section.productArray addObject:product];
    
    product = [ProductModel alloc];
    product.name = @"Clementinas";
    product.image = [UIImage imageNamed:@"clementinas.jpg"];
    product.precio = 5.55;
    [section.productArray addObject:product];
    
    product = [ProductModel alloc];
    product.name = @"Coco";
    product.image = [UIImage imageNamed:@"coco.jpg"];
    product.precio = 2.34;
    [section.productArray addObject:product];
    
    product = [ProductModel alloc];
    product.name = @"Endivias";
    product.image = [UIImage imageNamed:@"endivia.jpg"];
    product.precio = 4.25;
    [section.productArray addObject:product];
    
    product = [ProductModel alloc];
    product.name = @"Granada";
    product.image = [UIImage imageNamed:@"granada.jpg"];
    product.precio = 4.35;
    [section.productArray addObject:product];
    
    product = [ProductModel alloc];
    product.name = @"Higos";
    product.image = [UIImage imageNamed:@"higos.jpg"];
    product.precio = 2.15;
    [section.productArray addObject:product];
    
    product = [ProductModel alloc];
    product.name = @"Judía verde";
    product.image = [UIImage imageNamed:@"judia.jpg"];
    product.precio = 2.5;
    [section.productArray addObject:product];
    
    product = [ProductModel alloc];
    product.name = @"Lechuga IceWert";
    product.image = [UIImage imageNamed:@"lechuga.jpg"];
    product.precio = 4.5;
    [section.productArray addObject:product];
    
    product = [ProductModel alloc];
    product.name = @"Manzanas";
    product.image = [UIImage imageNamed:@"manzana.jpg"];
    product.precio = 3.45;
    [section.productArray addObject:product];
    
    product = [ProductModel alloc];
    product.name = @"Melocotón rojo";
    product.image = [UIImage imageNamed:@"melocoton.jpg"];
    product.precio = 3.45;
    [section.productArray addObject:product];
    
    product = [ProductModel alloc];
    product.name = @"Melón Galia";
    product.image = [UIImage imageNamed:@"melon.jpg"];
    product.precio = 2.50;
    [section.productArray addObject:product];
    
    product = [ProductModel alloc];
    product.name = @"Patata blanca";
    product.image = [UIImage imageNamed:@"patata.jpg"];
    product.precio = 1.5;
    [section.productArray addObject:product];
    
    product = [ProductModel alloc];
    product.name = @"Pimiento rojo";
    product.image = [UIImage imageNamed:@"pimiento.jpg"];
    product.precio = 3.0;
    [section.productArray addObject:product];
    
    [self.sections addObject:section];
    
    //--- Section ----//
    section = [[SectionModel alloc] init];
    section.name = @"Arroz";
    //s2.image = ;
    
    [self.sections addObject:section];

    section = [[SectionModel alloc] init];
    section.name = @"Bollería";
    //s2.image = ;
    
    [self.sections addObject:section];
    
    section = [[SectionModel alloc] init];
    section.name = @"Conservas";
    //s2.image = ;
    
    [self.sections addObject:section];
    
    section = [[SectionModel alloc] init];
    section.name = @"Desayunos";
    //s2.image = ;
    
    [self.sections addObject:section];
    
    section = [[SectionModel alloc] init];
    section.name = @"Dietética";
    //s2.image = ;
    
    [self.sections addObject:section];
    
    section = [[SectionModel alloc] init];
    section.name = @"Dulces";
    //s2.image = ;
    
    [self.sections addObject:section];
    
    section = [[SectionModel alloc] init];
    section.name = @"Ecológico";
    //s2.image = ;
    
    [self.sections addObject:section];
    
    section = [[SectionModel alloc] init];
    section.name = @"Especias";
    //s2.image = ;
    
    [self.sections addObject:section];
    
    section = [[SectionModel alloc] init];
    section.name = @"Galletas";
    //s2.image = ;
    
    [self.sections addObject:section];
    
    section = [[SectionModel alloc] init];
    section.name = @"Legumbres";
    //s2.image = ;
    
    [self.sections addObject:section];
    
    section = [[SectionModel alloc] init];
    section.name = @"Pan";
    //s2.image = ;
    
    [self.sections addObject:section];
    
    section = [[SectionModel alloc] init];
    section.name = @"Pasta";
    //s2.image = ;
    
    [self.sections addObject:section];
    
    section = [[SectionModel alloc] init];
    section.name = @"Salsas";
    //s2.image = ;
    
    [self.sections addObject:section];
    
    section = [[SectionModel alloc] init];
    section.name = @"Prou";
    //s2.image = ;
    
    [self.sections addObject:section];
    
        
}


@end
