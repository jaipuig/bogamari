//
//  ProductModel.h
//  Commerce
//
//  Created by Josep on 27/10/12.
//  Copyright (c) 2012 bogamari. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject{
    NSString* _name;
    UIImage*  _image;
}

@property (nonatomic) NSString* name;
@property (nonatomic) UIImage*  image;


@end
