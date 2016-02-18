//
//  PageViewController.h
//  PageViewController
//
//  Created by fhkvsou on 16/2/18.
//  Copyright © 2016年 fhkvsou. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ScreenWidth self.view.bounds.size.width
#define ScreenHeigjt self.view.bounds.size.height
@interface PageViewController : UIViewController

- (id)initWithTitleArray:(NSArray *)titleArr andVcArray:(NSArray *)VcArray;

@end
