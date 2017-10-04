//
//  MenuTableViewController.h
//  Dictionary
//
//  Created by Redixbit on 12/12/15.
//  Copyright (c) 2015 Redixbit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "ViewController.h"
#import "CategoryViewController.h"
#import "FavouriteViewController.h"
#import "AddNoteViewController.h"
#import "ShoppingListViewController.h"
#import "SettingViewController.h"
#import "AboutUsViewController.h"
#import "Static.h"
#import "Utility.h"
#import "Appirater.h"
#import "AppDelegate.h"

@interface MenuTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,AppiraterDelegate>
{
    NSArray *arrMenu;
    NSArray *arrImages;
    SLComposeViewController *mySLcomposerSheet;
    AppDelegate *appDelegate;
}
@property(nonatomic,retain)IBOutlet UITableView *tblView;
@property(nonatomic,retain)IBOutlet UIView *navBar;
@end
