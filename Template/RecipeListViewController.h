//
//  RecipeListViewController.h
//  Template
//
//  Created by R on 12/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Static.h"
#import "Utility.h"
#import "DetailViewController.h"
#import "Recipe.h"
#import "AppDelegate.h"
@interface RecipeListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSArray *arrData;
    AppDelegate *appDelegate;
}
@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;
@property(nonatomic,retain)NSString *strCategory;
@property(nonatomic,retain)IBOutlet UIView *navBar;
@property(nonatomic,retain)IBOutlet UILabel *lblTitle;
@property(nonatomic,retain)IBOutlet UITableView *tblView;
@property (strong, nonatomic) NSMutableArray* filteredTableData;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, assign) bool isFiltered;
-(void) showDetailsForIndexPath:(NSIndexPath*)indexPath;
@end
