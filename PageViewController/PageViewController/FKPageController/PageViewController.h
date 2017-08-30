//
//  PageViewController.h
//  PageViewController
//
//  Created by fhkvsou on 16/2/18.
//  Copyright © 2016年 fhkvsou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemData.h"

@interface PageViewController : UIViewController

@property (nonatomic ,assign) float numberOfVisiableItems;

@property (nonatomic ,strong) UIColor * colorOfSignView;

- (instancetype)initWithItems:(NSArray <ItemData *> *)items;

@end
