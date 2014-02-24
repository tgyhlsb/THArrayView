//
//  THArrayView.h
//  RefurbMe
//
//  Created by Tanguy Hélesbeux on 19/02/2014.
//  Copyright (c) 2014 RefurbMe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSIndexPath+THArrayView.h"
#import "THArrayViewCell.h"

@protocol THArrayViewDataSource;
@protocol THArrayViewDelegate;

@interface THArrayView : UIView

@property (weak, nonatomic) id<THArrayViewDataSource> dataSource;
@property (weak, nonatomic) id<THArrayViewDelegate> delegate;

@property (nonatomic) CGColorRef cellBorderColor;
@property (nonatomic) CGFloat cellBorderWidth;
@property (nonatomic) UIBaselineAdjustment cellBaselineAdjustment;
@property (nonatomic) NSLineBreakMode cellLineBreakMode;

- (void)reloadData;

- (THArrayViewCell *)cellForIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPathForCell:(THArrayViewCell *)cell;

- (void)didTapCell:(THArrayViewCell *)cell;

@end

@protocol THArrayViewDataSource <NSObject>

- (NSInteger)numberOfRowsInArrayView:(THArrayView *)arrayView;
- (NSInteger)numberOfColumnsInArrayView:(THArrayView *)arrayView;


@optional

- (CGFloat)arrayView:(THArrayView *)arrayView widthForColumn:(NSInteger)column;
- (CGFloat)arrayView:(THArrayView *)arrayView heightForRow:(NSInteger)row;
- (UIColor *)arrayView:(THArrayView *)arrayView backgroundColorForCellAtIndexPath:(NSIndexPath *)indexPath;
- (UIEdgeInsets)arrayView:(THArrayView *)arrayView marginForCellAtIndexPath:(NSIndexPath *)indexPath;
- (UIFont *)arrayView:(THArrayView *)arrayView fontForCellAtIndexPath:(NSIndexPath *)indexPath;
- (UIColor *)arrayView:(THArrayView *)arrayView fontColorForCellAtIndexPath:(NSIndexPath *)indexPath;
- (NSTextAlignment)arrayView:(THArrayView *)arrayView textAlignmentForCellAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)arrayView:(THArrayView *)arrayView stringForCellAtIndexPath:(NSIndexPath *)indexPath;
- (NSAttributedString *)arrayView:(THArrayView *)arrayView attributedStringForCellAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol THArrayViewDelegate <NSObject>

@optional

- (void)arrayView:(THArrayView *)arrayView didSelectCell:(THArrayViewCell *)cell;

@end