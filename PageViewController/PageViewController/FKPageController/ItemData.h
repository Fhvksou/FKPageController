//
//  PageItem.h
//  PageViewController
//
//  Created by fhkvsou on 17/8/15.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ItemData : NSObject

@property (nonatomic ,strong) UIViewController * controller;

@property (nonatomic ,copy) NSString * title;

@property (nonatomic ,strong) UIColor * normalColor;

@property (nonatomic ,strong) UIColor * selectColor;

@property (nonatomic ,strong) UIColor * normalBackgroundColor;

@property (nonatomic ,strong) UIColor * selectBackgroundColor;

@end
