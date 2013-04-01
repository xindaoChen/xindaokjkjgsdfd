//
//  GrayPageControl.m
//  DevelopMent
//
//  Created by 容芳志 on 13-4-1.
//  Copyright (c) 2013年 xin wang. All rights reserved.
//

#import "GrayPageControl.h"

@implementation GrayPageControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        activeImage = [[UIImage imageNamed:@"active_page_image"] retain];
        inactiveImage = [[UIImage imageNamed:@"inactive_page_image"] retain];    }
    return self;
}

-(void) updateDots
{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        if (i == self.currentPage) dot.image = activeImage;
        else dot.image = inactiveImage;
    }
}

-(void) setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    [self updateDots];
}


@end
