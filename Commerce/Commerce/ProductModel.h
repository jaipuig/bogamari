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
    float _precio;
}

@property (nonatomic) NSString* name;
@property (nonatomic) UIImage*  image;
@property (nonatomic) float precio;



@end
