//
//  SettingViewController.m
//  Template
//
//  Created by R on 14/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController
@synthesize barItem,navBar,lblTitle,lblTheme,line;
@synthesize btnColor1,btnColor2,btnColor3,btnColor4,btnColor5,btnColor6,btnColor7,btnColor8,btnColor9,btnColor10,btnColor11,btnColor12,bannerView;
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[AppDelegate initAppDelegate];
    navBar.backgroundColor=[Utility getColor:appDelegate.strColor];
    [self defaultThemeSetUp];
    if ([ADS_VISIBILITY isEqualToString:@"YES"]) {
        [Utility createAndLoadBanner:bannerView];
    }
}
-(void)defaultThemeSetUp{
    // ----Set Up NavigationBar & Menu Button-----------------
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    UIImage *image = [[UIImage imageNamed:@"menu.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    barItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self.revealViewController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = barItem;
    [barItem setBackgroundVerticalPositionAdjustment:2.0f forBarMetrics:UIBarMetricsDefault];
    barItem.imageInsets = UIEdgeInsetsMake(0,-5, 0, 0);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    //-------------------Menu End-----------------------------
    lblTheme.textColor=[Utility getColor:appDelegate.strColor];
    line.backgroundColor=[Utility getColor:appDelegate.strColor];
    line.frame=CGRectMake(0, line.frame.origin.y, self.view.frame.size.width, 0.5);
    
    [self setBoarderForButton:btnColor1];
    btnColor1.backgroundColor=[Utility getColor:@"c39404"];
    btnColor1.titleLabel.text=@"c39404";
    [self setBoarderForButton:btnColor2];
    btnColor2.backgroundColor=[Utility getColor:@"DE5145"];
    btnColor2.titleLabel.text=@"DE5145";
    [self setBoarderForButton:btnColor3];
    btnColor3.backgroundColor=[Utility getColor:@"0db846"];
    btnColor3.titleLabel.text=@"0db846";
    [self setBoarderForButton:btnColor4];
    btnColor4.backgroundColor=[Utility getColor:@"2b0979"];
    btnColor4.titleLabel.text=@"2b0979";
    [self setBoarderForButton:btnColor5];
    btnColor5.backgroundColor=[Utility getColor:@"780979"];
    btnColor5.titleLabel.text=@"780979";
    [self setBoarderForButton:btnColor6];
    btnColor6.backgroundColor=[Utility getColor:@"795b09"];
    btnColor6.titleLabel.text=@"795b09";
    [self setBoarderForButton:btnColor7];
    btnColor7.backgroundColor=[Utility getColor:@"096d79"];
    btnColor7.titleLabel.text=@"096d79";
    [self setBoarderForButton:btnColor8];
    btnColor8.backgroundColor=[Utility getColor:@"4E93C6"];
    btnColor8.titleLabel.text=@"4E93C6";
    [self setBoarderForButton:btnColor9];
    btnColor9.backgroundColor=[Utility getColor:@"9fa0a0"];
    btnColor9.titleLabel.text=@"9fa0a0";
    [self setBoarderForButton:btnColor10];
    btnColor10.backgroundColor=[Utility getColor:@"85a105"];
    btnColor10.titleLabel.text=@"85a105";
    [self setBoarderForButton:btnColor11];
    btnColor11.backgroundColor=[Utility getColor:@"4a494a"];
    btnColor11.titleLabel.text=@"4a494a";
    [self setBoarderForButton:btnColor12];
    btnColor12.backgroundColor=[Utility getColor:@"b80573"];
    btnColor12.titleLabel.text=@"b80573";
}
-(void)setBoarderForButton:(UIButton *)btn{
    btn.layer.borderColor=[[UIColor whiteColor] CGColor];
    btn.layer.borderWidth=2;
    btn.layer.cornerRadius = 27;
    btn.clipsToBounds = YES;
}
- (IBAction)btnColor:(id)sender{
    UIButton *btn=sender;
    appDelegate.strColor=btn.titleLabel.text;
    navBar.backgroundColor=[Utility getColor:appDelegate.strColor];
    line.backgroundColor=[Utility getColor:appDelegate.strColor];
    lblTheme.textColor=[Utility getColor:appDelegate.strColor];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:appDelegate.strColor forKey:@"COLOR"];
    [prefs synchronize];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
