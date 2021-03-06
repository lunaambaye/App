//
//  NoteDetailViewController.h
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
@interface NoteDetailViewController : UIViewController{
    AppDelegate *appDelegate;
}
@property(nonatomic,retain)IBOutlet UIView *navBar;
@property(nonatomic,retain)IBOutlet UILabel *lblTitle;
@property(nonatomic,retain)IBOutlet UITextView *txtDetail;
@property(nonatomic,retain)Note *objNote;
@end
