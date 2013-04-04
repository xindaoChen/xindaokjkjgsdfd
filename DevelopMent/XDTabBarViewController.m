//
//  XDTabBarViewController.m
//  DevelopMent
//
//  Created by 容芳志 on 13-4-3.
//  Copyright (c) 2013年 xin wang. All rights reserved.
//

#import "XDTabBarViewController.h"
#import "XDHeader.h"

@interface XDTabBarViewController ()

@end

@implementation XDTabBarViewController

@synthesize settingsButton, infoButton, aboutUsButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tabBar setHidden:YES];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self addCustomElements];
}

-(void)addCustomElements
{
    // Background
//    UIImageView* bgView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabBarBackground.png"]] autorelease];
//    bgView.frame = CGRectMake(0, 420, 320, 60);
//    [self.view addSubview:bgView];
    // Initialise our two images
    UIImage *btnImage = [UIImage imageNamed:@"homepage_normal_tab"];
    UIImage *btnImageSelected = [UIImage imageNamed:@"homepage_select_tab"];
    float height = 431;
    if (iPhone5) {
        height = 519;
    }
    
    self.settingsButton = [UIButton buttonWithType:UIButtonTypeCustom]; //Setup the button
    settingsButton.frame = CGRectMake(0, height, 106.67, 49); // Set the frame (size and position) of the button)
    [settingsButton setBackgroundImage:btnImage forState:UIControlStateNormal]; // Set the image for the normal state of the button
    [settingsButton setBackgroundImage:btnImageSelected forState:UIControlStateHighlighted]; // Set the image for the selected state of the button
    [settingsButton setBackgroundImage:btnImageSelected forState:UIControlStateSelected]; // Set the image for the selected state of the button
    [settingsButton setBackgroundImage:btnImageSelected forState:UIControlStateDisabled];
    [settingsButton setImage:btnImageSelected forState:UIControlStateHighlighted|UIControlStateSelected];
    [settingsButton setTag:0]; // Assign the button a “tag” so when our “click” event is called we know which button was pressed.
    [settingsButton setSelected:true]; // Set this button as selected (we will select the others to false as we only want Tab 1 to be selected initially

//   
//    UIBarButtonItem * item1 = [self.toolbarItems objectAtIndex:0];
//    [item1 setCustomView:settingsButton];
    
    // Now we repeat the process for the other buttons
    btnImage = [UIImage imageNamed:@"class_normal_tab"];
    btnImageSelected = [UIImage imageNamed:@"class_select_tab"];
    self.infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    infoButton.frame = CGRectMake(106.7, height, 106.67, 49);
    [infoButton setBackgroundImage:btnImage forState:UIControlStateNormal];
    [infoButton setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
    [infoButton setBackgroundImage:btnImageSelected forState:UIControlStateHighlighted];
    [infoButton setImage:btnImageSelected forState:UIControlStateHighlighted|UIControlStateSelected];
    
    [infoButton setTag:1];
    
    btnImage = [UIImage imageNamed:@"about_normal_tab"];
    btnImageSelected = [UIImage imageNamed:@"about_select_tab"];
    self.aboutUsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aboutUsButton.frame = CGRectMake(213.4, height, 106.67, 49);
    [aboutUsButton setBackgroundImage:btnImage forState:UIControlStateNormal];
    [aboutUsButton setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
    [aboutUsButton setBackgroundImage:btnImageSelected forState:UIControlStateHighlighted];
    [aboutUsButton setImage:btnImageSelected forState:UIControlStateHighlighted|UIControlStateSelected];
    
    [aboutUsButton setTag:2];
    
    // Add my new buttons to the view
    [self.view addSubview:settingsButton];
    [self.view addSubview:infoButton];
    [self.view addSubview:aboutUsButton];
    
    // Setup event handlers so that the buttonClicked method will respond to the touch up inside event.
    [settingsButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [infoButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [aboutUsButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setHideCustomButton:(BOOL) isHide
{
    [settingsButton setHidden:isHide];
    [infoButton setHidden:isHide];
    [aboutUsButton setHidden:isHide];
}

- (void)buttonClicked:(id)sender
{
    int tagNum = [sender tag];

    [self selectTab:tagNum];
}
- (void)selectTab:(int)tabID
{
    switch(tabID)
    {
        case 0:
            [settingsButton setSelected:true];
            [infoButton setSelected:false];
            [aboutUsButton setSelected:false];
            break;
        case 1:
            [settingsButton setSelected:false];
            [infoButton setSelected:true];
            [aboutUsButton setSelected:false];
            break;
        case 2:
            [settingsButton setSelected:false];
            [infoButton setSelected:false];
            [aboutUsButton setSelected:true];
            break;
    }
    self.selectedIndex = tabID;
}

- (void)dealloc {
    [settingsButton release];
    [infoButton release];
    [aboutUsButton release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
