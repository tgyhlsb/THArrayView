//
//  THArrayViewCell.h
//  RefurbMe
//
//  Created by Tanguy Hélesbeux on 19/02/2014.
//  Copyright (c) 2014 RefurbMe. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *THArrayViewCellTapNotification = @"THArrayViewCellTapNotification";
static NSString *THArrayViewInfoCellKey = @"THArrayViewInfoCellKey";

@interface THArrayViewCell : UIView

@property (strong, nonatomic) UILabel *label;
@property (nonatomic) UIEdgeInsets margin;

- (void)updateUI;

@end
