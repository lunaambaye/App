//
//  FavouriteViewController.h
//  Template
//
//  Created by R on 12/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "FavouriteViewController.h"
#import "DetailViewController.h"
#import "Static.h"
#import "Utility.h"
@interface FavouriteViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    AppDelegate *appDelegate;
    NSArray *arrData;
}
@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;
@property(nonatomic,retain)IBOutlet UIBarButtonItem *barItem;
@property(nonatomic,retain)IBOutlet UIView *navBar;
@property(nonatomic,retain)IBOutlet UILabel *lblTitle;
@property(nonatomic,retain)IBOutlet UITableView *tblView;

@end
