//
//  DiscussViewController.h
//  DevelopMent
//
//  Created by xin wang on 3/22/13.
//  Copyright (c) 2013 xin wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscussViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITextView*   textview;
    UITableView *tabeview;
}
@end
