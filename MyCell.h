//
//  MyCell.h
//  DevelopMent
//
//  Created by xin wang on 3/23/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
@interface MyCell : UITableViewCell
{
    UIImageView *imageview;
    UILabel *label;
    UILabel *labeltwo;
}
@property(nonatomic,strong) UIImageView *imageview;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong) UILabel *labeltwo;
@end
