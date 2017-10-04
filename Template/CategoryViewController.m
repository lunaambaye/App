//
//  CategoryViewController.m
//  Template
//
//  Created by R on 12/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController
@synthesize barItem,navBar,lblTitle,tblView,bannerView;
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[AppDelegate initAppDelegate];
    navBar.backgroundColor=[Utility getColor:appDelegate.strColor];
    arrData=[[NSMutableArray alloc]init];
    //arrData=[DataManager getAllCategories];
    [self defaultThemeSetUp];
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
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    RecipeModel *obj=[[RecipeModel alloc]init];
    obj=[arrData objectAtIndex:indexPath.row];
    
    UILabel *lblHeading =(UILabel*) [cell.contentView viewWithTag:101];
    
    //lblHeading.text = obj.category;
    lblHeading.textColor=[Utility getColor:appDelegate.strColor];
    UIView *line =(UIView *) [cell.contentView viewWithTag:102];
    line.frame=CGRectMake(line.frame.origin.x, line.frame.origin.y, line.frame.size.width, 0.5);
    line.backgroundColor=[Utility getColor:appDelegate.strColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RecipeModel *obj=[[RecipeModel alloc]init];
    obj=[arrData objectAtIndex:indexPath.row];
    
    RecipeListViewController *detailVC =[self.storyboard instantiateViewControllerWithIdentifier:@"RecipeListViewController"];
    //detailVC.strCategory=obj.category;
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
