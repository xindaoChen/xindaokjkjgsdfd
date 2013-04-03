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
        imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 6, 90, 48)];
        imageview.backgroundColor = [UIColor clearColor];
        imageview.layer.cornerRadius = 4;
        imageview.layer.masksToBounds = YES;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(113, 6, 180, 21)];
        
        label.font = [UIFont fontWithName:@"Helvetica" size:15.0];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:17];

       
        labeltwo = [[UILabel alloc] initWithFrame:CGRectMake(113, 24, 180, 30)];
        labeltwo.backgroundColor = [UIColor clearColor];
        labeltwo.numberOfLines = 2;
        labeltwo.font = [UIFont systemFontOfSize:12];
        labeltwo.textColor = [UIColor grayColor];
        [self  addSubview:imageview];
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

-(void)dealloc
{
    [label release];label = nil;
    [labeltwo release];labeltwo = nil;
    [imageview release];imageview = nil;
    [super dealloc];
}

@end
