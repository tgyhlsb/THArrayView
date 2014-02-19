//
//  THArrayView.h
//  RefurbMe
//
//  Created by Tanguy Hélesbeux on 19/02/2014.
//  Copyright (c) 2014 RefurbMe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSIndexPath+THArrayView.h"

@protocol THArrayViewDataSource;
@protocol THArrayViewDelegate;

@interface THArrayView : UIView

@property (weak, nonatomic) id<THArrayViewDataSource> dataSource;
@property (weak, nonatomic) id<THArrayViewDelegate> delegate;

@property (nonatomic) CGColorRef cellBorderColor;
@property (nonatomic) CGFloat cellBorderWidth;
@property (nonatomic) UIBaselineAdjustment cellBaselineAdjustment;
@property (nonatomic) NSLineBreakMode cellLineBreakMode;

@end

@protocol THArrayViewDataSource <NSObject>

- (NSInteger)numberOfRowsInArrayView:(THArrayView *)arrayView;
- (NSInteger)numberOfColumnsInArrayView:(THArrayView *)arrayView;
- (NSString *)arrayView:(THArrayView *)arrayView stringForCellAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (CGFloat)arrayView:(THArrayView *)arrayView widthForColumn:(NSInteger)column;
- (CGFloat)arrayView:(THArrayView *)arrayView heightForRow:(NSInteger)row;
- (UIColor *)arrayView:(THArrayView *)arrayView backgroundColorForCellAtIndexPath:(NSIndexPath *)indexPath;
- (UIEdgeInsets)arrayView:(THArrayView *)arrayView marginForCellAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol THArrayViewDelegate <NSObject>



@end