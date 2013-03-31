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
        imageview = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 100, 60)];
        imageview.backgroundColor = [UIColor clearColor];
        imageview.layer.cornerRadius = 4;
        imageview.layer.masksToBounds = YES;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(110, 6, 190, 28)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:17];

       
        labeltwo = [[UILabel alloc] initWithFrame:CGRectMake(110, 33, 190, 35)];
        labeltwo.backgroundColor = [UIColor clearColor];
        labeltwo.numberOfLines = 2;
        labeltwo.font = [UIFont systemFontOfSize:13];
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
