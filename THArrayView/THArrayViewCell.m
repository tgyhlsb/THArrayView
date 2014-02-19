//
//  THArrayViewCell.m
//  RefurbMe
//
//  Created by Tanguy Hélesbeux on 19/02/2014.
//  Copyright (c) 2014 RefurbMe. All rights reserved.
//

#import "THArrayViewCell.h"
#import "THArrayView.h"

@interface THArrayViewCell()


@end

@implementation THArrayViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self updateUI];
        self.clipsToBounds = YES;
        self.label.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        
        [self setUpTapGesture];
    }
    return self;
}

- (void)setUpTapGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    
    [self addGestureRecognizer:tapGesture];
}

- (void)tapHandler
{
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
    [userInfo setObject:self forKey:THArrayViewInfoCellKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:THArrayViewCellTapNotification object:self userInfo:userInfo];
    
    [((THArrayView *)self.superview) didTapCell:self];
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
