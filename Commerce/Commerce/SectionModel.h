//
//  SectionModel.h
//  Commerce
//
//  Created by Josep on 27/10/12.
//  Copyright (c) 2012 bogamari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionModel : NSObject{
    NSString* _name;
    UIImage*  _image;
    NSArray*  _productArray;
    
}

@property (nonatomic) NSString* name;
@property (nonatomic) UIImage*  image;
@property (nonatomic) NSArray*  productArray;



@end
