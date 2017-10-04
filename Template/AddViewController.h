//
//  AddViewController.h
//  Template
//
//  Created by R on 13/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Note.h"
#import "Static.h"
#import "Utility.h"
@interface AddViewController : UIViewController{
    AppDelegate *appDelegate;
}
@property(nonatomic,retain)IBOutlet UIView *navBar;
@property(nonatomic,retain)IBOutlet UILabel *lblTitle;
@property(nonatomic,retain)IBOutlet UITextField *txtHeading;
@property(nonatomic,retain)IBOutlet UITextView *txtDetail;
@property(nonatomic,retain)IBOutlet UIButton *btnDone;
-(IBAction)btnDone:(id)sender;
@end
