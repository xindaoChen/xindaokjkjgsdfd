//
//  calssCell.m
//  DevelopMent
//
//  Created by xindaoapp on 13-4-3.
//  Copyright (c) 2013年 xin wang. All rights reserved.
//

#import "calssCell.h"

@implementation calssCell
@synthesize label;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        label = [[UILabel alloc] initWithFrame:CGRectMake(30, 9, 250, 22)];
        //label.text =[NSString stringWithFormat:@"%@",[[listarray  objectAtIndex:  indexPath.section] objectForKey:@"classname"]];
        label.font = [UIFont fontWithName:@"Helvetica" size:15.0];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
