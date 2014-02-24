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

@property (weak, nonatomic) THArrayViewCell *selectedCell;

@end

@implementation THViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frame = CGRectMake(0, 0, 280, 400);
    THArrayView *arrayView = [[THArrayView alloc] initWithFrame:frame];
    arrayView.center = self.view.center;
    [self.view addSubview:arrayView];
    
    arrayView.cellBorderColor = [[UIColor blackColor] CGColor];
    arrayView.cellBorderWidth = 1.0;
    
    arrayView.delegate = self;
    arrayView.dataSource = self;
}

- (void)setSelectedCell:(THArrayViewCell *)selectedCell
{
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
        return [NSString stringWithFormat:@"%ld", (long)indexPath.column];
    } else if (!indexPath.column) {
        return [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    } else {
        return [NSString stringWithFormat:@"%d", arc4random() % 74];
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
    if (!column) {
        return 40;
    } else {
        return 60;
    }
}

- (NSTextAlignment)arrayView:(THArrayView *)arrayView textAlignmentForCellAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.row) {
        return NSTextAlignmentCenter;
    } else if (!indexPath.column) {
        return NSTextAlignmentLeft;
    } else {
        return NSTextAlignmentRight;
    }
}

- (UIEdgeInsets)arrayView:(THArrayView *)arrayView marginForCellAtIndexPath:(NSIndexPath *)indexPath
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark - THArrayViewDelegate

- (void)arrayView:(THArrayView *)arrayView didSelectCell:(THArrayViewCell *)cell
{
    self.selectedCell = cell;
}

@end
