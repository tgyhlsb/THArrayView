//
//  THArrayView.m
//  RefurbMe
//
//  Created by Tanguy Hélesbeux on 19/02/2014.
//  Copyright (c) 2014 RefurbMe. All rights reserved.
//

#import "THArrayView.h"
#import "THArrayViewCell.h"

#define VIEW_CLASS THArrayViewCell

@interface THArrayView()

@property (strong, nonatomic) NSMutableArray *columns;

@property (nonatomic) CGPoint actualOrigin;
@property (nonatomic) NSInteger numberOfRows;
@property (nonatomic) NSInteger numberOfColumns;

@end

@implementation THArrayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self updateUI];
    }
    return self;
}

- (void)setDataSource:(id<THArrayViewDataSource>)dataSource
{
    _dataSource = dataSource;
    [self updateUI];
}

- (void)updateUI
{
    self.actualOrigin = CGPointZero;
    self.numberOfRows = [self.dataSource numberOfRowsInArrayView:self];
    self.numberOfColumns = [self.dataSource numberOfColumnsInArrayView:self];
    self.columns = [[NSMutableArray alloc] initWithCapacity:self.numberOfColumns];
    
    NSIndexPath *indexPath = nil;
    VIEW_CLASS *cellView = nil;
    
    for (int columnIterator = 0; columnIterator < self.numberOfColumns; columnIterator++) {
        NSMutableArray *rows = [[NSMutableArray alloc] initWithCapacity:self.numberOfRows];
        [self.columns addObject:rows];
        for (int rowIterator = 0; rowIterator < self.numberOfRows; rowIterator++) {
            indexPath = [NSIndexPath indexPathForRow:rowIterator inColumn:columnIterator];
            
            cellView = (VIEW_CLASS *)[self newViewForIndexPath:indexPath];
            cellView.label.text = [self.dataSource arrayView:self stringForCellAtIndexPath:indexPath];
            
            [self setLayerToView:cellView atIndexPath:indexPath];
            
            [self addSubview:cellView];
            [rows addObject:cellView];
            
            // Add the height of a row
            CGFloat x = self.actualOrigin.x;
            CGFloat y = self.actualOrigin.y + cellView.frame.size.height - self.cellBorderWidth;
            self.actualOrigin = CGPointMake(x, y);
        }
        
        // Add the width of a column
        // Return at the upper row
        CGFloat x = self.actualOrigin.x + cellView.frame.size.width - self.cellBorderWidth;
        CGFloat y = 0.0;
        self.actualOrigin = CGPointMake(x, y);
    }
}

- (void)setLayerToView:(UIView *)view atIndexPath:(NSIndexPath *)indexPath
{
    view.layer.borderColor = self.cellBorderColor;
    view.layer.borderWidth = self.cellBorderWidth;
    
    if ([self.dataSource respondsToSelector:@selector(arrayView:backgroundColorForCellAtIndexPath:)]) {
        view.backgroundColor = [self.dataSource arrayView:self backgroundColorForCellAtIndexPath:indexPath];
    }
}

- (UIView *)viewForRow:(NSInteger)row column:(NSInteger)column
{
    return [[self.columns objectAtIndex:column] objectAtIndex:row];
}

- (UIView *)viewForIndexPath:(NSIndexPath *)indexPath
{
    return [self viewForRow:indexPath.row column:indexPath.column];
}

- (VIEW_CLASS *)newViewForIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = 0;
    if ([self.dataSource respondsToSelector:@selector(arrayView:widthForColumn:)]) {
        width = [self.dataSource arrayView:self widthForColumn:indexPath.column];
    } else {
        width = self.frame.size.width / self.numberOfColumns;
    }
    width = width + self.cellBorderWidth;
    
    CGFloat height = 0;
    if ([self.dataSource respondsToSelector:@selector(arrayView:heightForRow:)]) {
        height = [self.dataSource arrayView:self heightForRow:indexPath.row];
    } else {
        height = self.frame.size.height / self.numberOfRows;
    }
    height = height + self.cellBorderWidth;
    
    CGRect frame = CGRectMake(self.actualOrigin.x, self.actualOrigin.y, width, height);
    VIEW_CLASS *view = [[VIEW_CLASS alloc] initWithFrame:frame];
    
    if ([self.dataSource respondsToSelector:@selector(arrayView:marginForCellAtIndexPath:)]) {
        view.margin = [self.dataSource arrayView:self marginForCellAtIndexPath:indexPath];
    }
    
    return view;
}


@end
