//
//  THArrayViewCell.m
//  RefurbMe
//
//  Created by Tanguy Hélesbeux on 19/02/2014.
//  Copyright (c) 2014 RefurbMe. All rights reserved.
//

#import "THArrayViewCell.h"

@interface THArrayViewCell()


@end

@implementation THArrayViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self updateUI];
    }
    return self;
}

@synthesize label = _label;

- (void)setLabel:(UILabel *)label
{
    _label = label;
    [self updateUI];
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:self.frame];
        [self addSubview:_label];
    }
    return _label;
}

- (void)setMargin:(UIEdgeInsets)margin
{
    _margin = margin;
    [self updateUI];
}

- (void)updateUI
{
    CGFloat x = self.margin.left;
    CGFloat y = self.margin.top;
    CGFloat width = self.frame.size.width - x - self.margin.right;
    CGFloat height = self.frame.size.height - y - self.margin.bottom;
    self.label.frame = CGRectMake(x, y, width, height);
}

@end
