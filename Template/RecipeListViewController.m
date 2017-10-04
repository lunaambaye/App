//
//  RecipeListViewController.m
//  Template
//
//  Created by R on 12/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import "RecipeListViewController.h"

@interface RecipeListViewController ()
@end
@implementation RecipeListViewController
@synthesize navBar,lblTitle;
@synthesize tblView,filteredTableData,searchBar,isFiltered,strCategory,bannerView;
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[AppDelegate initAppDelegate];
    [self defaultThemeSetUp];
    arrData=[[NSMutableArray alloc]init];
    arrData=[RecipeModel allRecipes];
    if ([ADS_VISIBILITY isEqualToString:@"YES"]) {
        [Utility createAndLoadBanner:bannerView];
        if (iPhoneVersion==4 || iPhoneVersion==5) {
            tblView.frame=CGRectMake(tblView.frame.origin.x, tblView.frame.origin.y, tblView.frame.size.width, tblView.frame.size.height-50);
        }
        else if (iPhoneVersion==6) {
            tblView.frame=CGRectMake(tblView.frame.origin.x, tblView.frame.origin.y, tblView.frame.size.width, tblView.frame.size.height-65);
        }
    }
}
-(void)defaultThemeSetUp{
    //----------------Navigation Bar & Title-------------------
    self.navBar.backgroundColor=[Utility getColor:appDelegate.strColor];
    lblTitle.text=strCategory;
    searchBar.delegate = (id)self;
    self.searchBar.barTintColor = [Utility getColor:appDelegate.strColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO];
    self.navBar.backgroundColor=[Utility getColor:appDelegate.strColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
}
- (void) dismissKeyboard
{
    [self.searchBar resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}
- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [super viewDidUnload];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowCount;
    if(self.isFiltered)
        rowCount = filteredTableData.count;
    else
        rowCount = arrData.count;
    
    return rowCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    RecipeModel *obj=[[RecipeModel alloc]init];
    if(isFiltered)
        obj = [filteredTableData objectAtIndex:indexPath.row];
    else
        obj = [arrData objectAtIndex:indexPath.row];
    
    UIImageView *imageRecipe=(UIImageView*) [cell.contentView viewWithTag:100];
    imageRecipe.image=[UIImage imageWithData:obj.image];
    
    UILabel *lblName =(UILabel*) [cell.contentView viewWithTag:101];
    lblName.text = obj.name;
    
    /*UILabel *lblCategory =(UILabel*) [cell.contentView viewWithTag:102];
    lblCategory.text = [obj.category uppercaseString];*/
    
    UILabel *lblTime =(UILabel*) [cell.contentView viewWithTag:103];
    lblTime.text = [NSString stringWithFormat:@"%@ Min",obj.time];
    
    UILabel *lblPerson =(UILabel*) [cell.contentView viewWithTag:104];
    lblPerson.text = [NSString stringWithFormat:@"%@ People",obj.person];
    return cell;
}
#pragma mark - Table view delegate

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if(text.length == 0)
    {
        isFiltered = FALSE;
        [searchBar resignFirstResponder];
         [self.tblView reloadData];
    }
    else
    {
        isFiltered = true;
        filteredTableData = [[NSMutableArray alloc] init];
        NSArray *texts = [text componentsSeparatedByString:@","];
         for (NSString* str in texts) {
        for (RecipeModel *obj in arrData)
        {
            NSRange nameRange = [obj.name rangeOfString:str options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound)
            {
                if (nameRange.location==0) {
                    [filteredTableData addObject:obj];
                }
            }
        }
        /*-------- This loop is usefull search multiple field
         AND search inside the word*/
        
        /*for (RecipeModel* obj in arrData)
        {
            NSRange nameRange = [obj.category rangeOfString:str options:NSCaseInsensitiveSearch];
            NSRange descriptionRange = [obj.ingredients rangeOfString:str options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound || descriptionRange.location != NSNotFound)
            {
                if ([filteredTableData containsObject:obj]) {
                    
                }
                else {
                   [filteredTableData addObject:obj];
                }

                
            }
        }*/
    }
    
    [self.tblView reloadData];
}
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self showDetailsForIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    [self showDetailsForIndexPath:indexPath];
}

-(void) showDetailsForIndexPath:(NSIndexPath*)indexPath
{
    [self.searchBar resignFirstResponder];
    DetailViewController *objDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    RecipeModel* obj;
    
    if(isFiltered)
    {
        obj = [filteredTableData objectAtIndex:indexPath.row];
    }
    else
    {
        obj = [arrData objectAtIndex:indexPath.row];
    }
    objDetailViewController.objRecipe = obj;
    [self.navigationController pushViewController:objDetailViewController animated:true];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
