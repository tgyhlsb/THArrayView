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


// Setting datasource or delegate will automatically call [THArrayView reloadData]
@property (weak, nonatomic) IBOutlet id<THArrayViewDataSource> dataSource;
@property (weak, nonatomic) IBOutlet id<THArrayViewDelegate> delegate;


// These attributes will apply to the entire arrayView
// You have to call [THArrayView reloadData] after changing same to commit changes
@property (nonatomic) CGColorRef cellBorderColor;
@property (nonatomic) CGFloat cellBorderWidth;
@property (nonatomic) UIBaselineAdjustment cellBaselineAdjustment;
@property (nonatomic) NSLineBreakMode cellLineBreakMode;


// Call when you want to reload your view
// Same effect than [UITableView reloadData]
- (void)reloadData;

// Returns the indexPath for the given cell
- (THArrayViewCell *)cellForIndexPath:(NSIndexPath *)indexPath;

// Returns the cell for the given indexPath
- (NSIndexPath *)indexPathForCell:(THArrayViewCell *)cell;


// Used by cell to easily notify they are touched
- (void)didTapCell:(THArrayViewCell *)cell;

@end

@protocol THArrayViewDataSource <NSObject>


- (NSInteger)numberOfRowsInArrayView:(THArrayView *)arrayView;
- (NSInteger)numberOfColumnsInArrayView:(THArrayView *)arrayView;


@optional

// -------- These methods are optional but you have to implement at least one of them. They are used to fill the cell of your arrayView
//          If you implement both, only the attributedString signature will be used
//
// Content as NSString
- (NSString *)arrayView:(THArrayView *)arrayView stringForCellAtIndexPath:(NSIndexPath *)indexPath;
// Content as NSAttributedString
- (NSAttributedString *)arrayView:(THArrayView *)arrayView attributedStringForCellAtIndexPath:(NSIndexPath *)indexPath;

// -------- All these are about appearance and how each cell will look based on its indexPath
//
// By default, all columns have the same width
- (CGFloat)arrayView:(THArrayView *)arrayView widthForColumn:(NSInteger)column;
// By default, all rows have the same height
- (CGFloat)arrayView:(THArrayView *)arrayView heightForRow:(NSInteger)row;
// Use this method to set an inset in your cells, by default the content of the cells will be stuck on the left border
- (UIEdgeInsets)arrayView:(THArrayView *)arrayView marginForCellAtIndexPath:(NSIndexPath *)indexPath;
// Explicit methods
- (UIColor *)arrayView:(THArrayView *)arrayView backgroundColorForCellAtIndexPath:(NSIndexPath *)indexPath;
- (UIFont *)arrayView:(THArrayView *)arrayView fontForCellAtIndexPath:(NSIndexPath *)indexPath;
- (UIColor *)arrayView:(THArrayView *)arrayView fontColorForCellAtIndexPath:(NSIndexPath *)indexPath;
- (NSTextAlignment)arrayView:(THArrayView *)arrayView textAlignmentForCellAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol THArrayViewDelegate <NSObject>

@optional


// Called by the arrayView when a cell is selected
- (void)arrayView:(THArrayView *)arrayView didSelectCell:(THArrayViewCell *)cell;

@end