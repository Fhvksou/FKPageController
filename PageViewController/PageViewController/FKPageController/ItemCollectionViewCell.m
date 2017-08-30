//
//  ItemCollectionViewCell.m
//  PageViewController
//
//  Created by fhkvsou on 17/8/16.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "ItemCollectionViewCell.h"

@interface ItemCollectionViewCell ()

@property (nonatomic ,strong) UILabel * text;
@property (nonatomic ,strong) ItemData * data;

@end

@implementation ItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createViews];
    }
    return self;
}

- (void)createViews{
    _text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    _text.font = [UIFont systemFontOfSize:15];
    _text.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_text];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _text.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
}

- (void)updateText:(ItemData *)data{
    _data = data;
    _text.text = data.title;
}

- (void)updataSelet:(BOOL)select{
    if (select) {
        _text.textColor = _data.selectColor;
        _text.backgroundColor = _data.selectBackgroundColor;
    }else{
        _text.textColor = _data.normalColor;
        _text.backgroundColor = _data.normalBackgroundColor;
    }
}

@end
