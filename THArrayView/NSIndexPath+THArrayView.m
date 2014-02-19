//
//  NSIndexPath+THArrayView.m
//  RefurbMe
//
//  Created by Tanguy Hélesbeux on 19/02/2014.
//  Copyright (c) 2014 RefurbMe. All rights reserved.
//

#import "NSIndexPath+THArrayView.h"

@implementation NSIndexPath (THArrayView)

+ (NSIndexPath *)indexPathForRow:(NSInteger)row inColumn:(NSInteger)column
{
    return [NSIndexPath indexPathForRow:row inSection:column];
}

- (NSInteger)column
{
    return self.section;
}

@end
