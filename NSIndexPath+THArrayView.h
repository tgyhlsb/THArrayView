//
//  NSIndexPath+THArrayView.h
//  RefurbMe
//
//  Created by Tanguy Hélesbeux on 19/02/2014.
//  Copyright (c) 2014 RefurbMe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSIndexPath (THArrayView)

+ (NSIndexPath *)indexPathForRow:(NSInteger)row inColumn:(NSInteger)column;
- (NSInteger)column;


@end
