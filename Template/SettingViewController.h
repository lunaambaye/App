//
//  SettingViewController.h
//  Template
//
//  Created by R on 14/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Static.h"
#import "Utility.h"
@interface SettingViewController : UIViewController{
    AppDelegate *appDelegate;
}
@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;
@property(nonatomic,retain)UIBarButtonItem *barItem;
@property(nonatomic,retain)IBOutlet UIView *navBar;
@property(nonatomic,retain)IBOutlet UIView *line;
@property(nonatomic,retain)IBOutlet UILabel *lblTitle;
@property(nonatomic,retain)IBOutlet UILabel *lblTheme;
@property(nonatomic,retain)IBOutlet UIButton *btnColor1;
@property(nonatomic,retain)IBOutlet UIButton *btnColor2;
@property(nonatomic,retain)IBOutlet UIButton *btnColor3;
@property(nonatomic,retain)IBOutlet UIButton *btnColor4;
@property(nonatomic,retain)IBOutlet UIButton *btnColor5;
@property(nonatomic,retain)IBOutlet UIButton *btnColor6;
@property(nonatomic,retain)IBOutlet UIButton *btnColor7;
@property(nonatomic,retain)IBOutlet UIButton *btnColor8;
@property(nonatomic,retain)IBOutlet UIButton *btnColor9;
@property(nonatomic,retain)IBOutlet UIButton *btnColor10;
@property(nonatomic,retain)IBOutlet UIButton *btnColor11;
@property(nonatomic,retain)IBOutlet UIButton *btnColor12;
- (IBAction)btnColor:(id)sender;
@end
