//
//  AboutUsViewController.h
//  Template
//
//  Created by R on 14/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Static.h"
#import "Utility.h"
@interface AboutUsViewController : UIViewController{
    AppDelegate *appDelegate;
}
@property(nonatomic,retain)UIBarButtonItem *barItem;
@property(nonatomic,retain)IBOutlet UIView *navBar;
@property(nonatomic,retain)IBOutlet UILabel *lblTitle;
@property(nonatomic,retain)IBOutlet UITextView *txtDetail;
@property(nonatomic,retain)IBOutlet UISegmentedControl *segment;
-(IBAction)segmentValueChange:(id)sender;
@end
