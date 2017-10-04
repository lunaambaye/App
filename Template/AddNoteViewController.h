//
//  AddNoteViewController.h
//  Template
//
//  Created by R on 13/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AddViewController.h"
#import "NoteDetailViewController.h"
#import "Static.h"
#import "Utility.h"
#import "Note.h"
@interface AddNoteViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    AppDelegate *appDelegate;
    NSMutableArray *arrData;
}
@property(nonatomic,retain)IBOutlet UIBarButtonItem *barItem;
@property(nonatomic,retain)IBOutlet UIView *navBar;
@property(nonatomic,retain)IBOutlet UILabel *lblTitle;
@property(nonatomic,retain)IBOutlet UITableView *tblView;
- (IBAction)btnAddNote:(id)sender;
- (IBAction)btnClean:(id)sender;
@end
