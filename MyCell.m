//
//  MyCell.m
//  DevelopMent
//
//  Created by xin wang on 3/23/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell
@synthesize imageview,label,labeltwo;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        imageview = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 85, 51)];
        imageview.backgroundColor = [UIColor clearColor];
        imageview.layer.cornerRadius = 4;
        label = [[UILabel alloc] initWithFrame:CGRectMake(113, 6, 180, 27)];
        
        label.font = [UIFont fontWithName:@"Helvetica" size:18.0];
        label.backgroundColor = [UIColor clearColor];
     //   label.font = [UIFont boldSystemFontOfSize:17];

        UIImageView *borderView = [[UIImageView alloc]initWithFrame:CGRectMake(10,10, 93, 59)];
        borderView.image = [UIImage imageNamed:@"border"];
        [borderView addSubview:imageview];
        
        labeltwo = [[UILabel alloc] initWithFrame:CGRectMake(113,28, 180, 44)];
        labeltwo.backgroundColor = [UIColor clearColor];
        labeltwo.numberOfLines = 2;
        labeltwo.font = [UIFont systemFontOfSize:13];
        labeltwo.textColor = [UIColor grayColor];
        [self  addSubview:borderView];
        [self  addSubview:label];
        [self addSubview:labeltwo];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
