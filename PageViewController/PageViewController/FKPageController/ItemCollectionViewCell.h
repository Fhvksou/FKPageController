//
//  ItemCollectionViewCell.h
//  PageViewController
//
//  Created by fhkvsou on 17/8/16.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemData.h"

@interface ItemCollectionViewCell : UICollectionViewCell

- (void)updateText:(ItemData *)data;

- (void)updataSelet:(BOOL)select;

@end
