//
//  THViewController.m
//  THArrayViewDemo
//
//  Created by Tanguy Hélesbeux on 24/02/2014.
//  Copyright (c) 2014 Tanguy Hélesbeux. All rights reserved.
//

#import "THViewController.h"
#import "THArrayView.h"
//#import "NSIndexPath+THArrayView.h"

#define TITLES_BACKGROUND_COLOR [UIColor grayColor]
#define CONTENT_BACKGROUND_COLOR [UIColor lightGrayColor]

@interface THViewController () <THArrayViewDataSource, THArrayViewDelegate>

@property (weak, nonatomic) IBOutlet THArrayView *arrayView;
@property (weak, nonatomic) THArrayViewCell *selectedCell;

@end

@implementation THViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.arrayView.cellBorderColor = [[UIColor blackColor] CGColor];
    self.arrayView.cellBorderWidth = 1.0;
    
    [self.arrayView reloadData]; // Need to be called after you set THArrayView general attributes
    
}

- (void)setSelectedCell:(THArrayViewCell *)selectedCell
{
    // Change the color of old and new selected cells
    _selectedCell.backgroundColor = [UIColor redColor];
    _selectedCell = selectedCell;
    _selectedCell.backgroundColor = [UIColor yellowColor];
}


#pragma mark - THArrayViewDataSource

- (NSInteger)numberOfColumnsInArrayView:(THArrayView *)arrayView
{
    return 5;
}

- (NSInteger)numberOfRowsInArrayView:(THArrayView *)arrayView
{
    return 11;
}

- (NSString *)arrayView:(THArrayView *)arrayView stringForCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.row && !indexPath.column) {
        return @"";
    } else if (!indexPath.row) {
        return [NSString stringWithFormat:@"%ld", (long)indexPath.column]; // Upper titles
    } else if (!indexPath.column) {
        return [NSString stringWithFormat:@"%ld", (long)indexPath.row]; // Left titles
    } else {
        return [NSString stringWithFormat:@"%d", arc4random() % 74]; // content
    }
}

- (UIColor *)arrayView:(THArrayView *)arrayView backgroundColorForCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.row || !indexPath.column) {
        return TITLES_BACKGROUND_COLOR;
    } else {
        return CONTENT_BACKGROUND_COLOR;
    }
}

- (CGFloat)arrayView:(THArrayView *)arrayView widthForColumn:(NSInteger)column
{
    // by default all columns would have been 280/5 = 56px width
    if (!column) {
        return 40; // Size of the first column
    } else {
        return 60; // Size of the others
    }
}

- (NSTextAlignment)arrayView:(THArrayView *)arrayView textAlignmentForCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.row) {
        return NSTextAlignmentCenter; // Upper titles alignment
    } else if (!indexPath.column) {
        return NSTextAlignmentLeft; // Left titles alignment
    } else {
        return NSTextAlignmentRight; // Content alignment
    }
}

- (UIEdgeInsets)arrayView:(THArrayView *)arrayView marginForCellAtIndexPath:(NSIndexPath *)indexPath
{
    return UIEdgeInsetsMake(5, 5, 5, 5); // I hate when content hit borders
}

#pragma mark - THArrayViewDelegate

- (void)arrayView:(THArrayView *)arrayView didSelectCell:(THArrayViewCell *)cell
{
    self.selectedCell = cell;
}

@end
