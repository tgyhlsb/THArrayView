//
//  THArrayView.m
//  RefurbMe
//
//  Created by Tanguy Hélesbeux on 19/02/2014.
//  Copyright (c) 2014 RefurbMe. All rights reserved.
//

#import "THArrayView.h"

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
        
    }
    return self;
}

- (void)reloadData
{
    [self updateUI];
}

- (void)didTapCell:(THArrayViewCell *)cell
{
    if ([self.delegate respondsToSelector:@selector(arrayView:didSelectCell:)]) {
        [self.delegate arrayView:self didSelectCell:cell];
    }
}

- (NSIndexPath *)indexPathForCell:(THArrayViewCell *)cell
{
    for (NSArray *rows in self.columns) {
        if ([rows containsObject:cell]) {
            NSInteger row = [rows indexOfObject:cell];
            NSInteger column = [self.columns indexOfObject:rows];
            return [NSIndexPath indexPathForRow:row inColumn:column];
        }
    }
    return nil;
}

- (THArrayViewCell *)cellForIndexPath:(NSIndexPath *)indexPath
{
    return [[self.columns objectAtIndex:indexPath.column] objectAtIndex:indexPath.row];
}

- (void)setDataSource:(id<THArrayViewDataSource>)dataSource
{
    _dataSource = dataSource;
    [self updateUI];
}

- (void)updateUI
{
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
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
            
            if ([self.dataSource respondsToSelector:@selector(arrayView:attributedStringForCellAtIndexPath:)]) {
                cellView.label.attributedText = [self.dataSource arrayView:self attributedStringForCellAtIndexPath:indexPath];
            } else if ([self.dataSource respondsToSelector:@selector(arrayView:stringForCellAtIndexPath:)]) {
                cellView.label.text = [self.dataSource arrayView:self stringForCellAtIndexPath:indexPath];
            }
            
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

- (void)setLayerToView:(VIEW_CLASS *)view atIndexPath:(NSIndexPath *)indexPath
{
    view.layer.borderColor = self.cellBorderColor;
    view.layer.borderWidth = self.cellBorderWidth;
    view.label.baselineAdjustment = self.cellBaselineAdjustment;
    view.label.lineBreakMode = self.cellLineBreakMode;
    
    if ([self.dataSource respondsToSelector:@selector(arrayView:backgroundColorForCellAtIndexPath:)]) {
        view.backgroundColor = [self.dataSource arrayView:self backgroundColorForCellAtIndexPath:indexPath];
    }
    
    if ([self.dataSource respondsToSelector:@selector(arrayView:fontForCellAtIndexPath:)]) {
        view.label.font = [self.dataSource arrayView:self fontForCellAtIndexPath:indexPath];
    }
    
    if ([self.dataSource respondsToSelector:@selector(arrayView:fontColorForCellAtIndexPath:)]) {
        view.label.textColor = [self.dataSource arrayView:self fontColorForCellAtIndexPath:indexPath];
    }
    
    if ([self.dataSource respondsToSelector:@selector(arrayView:textAlignmentForCellAtIndexPath:)]) {
        view.label.textAlignment = [self.dataSource arrayView:self textAlignmentForCellAtIndexPath:indexPath];
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
