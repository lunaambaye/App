//
//  ShoppingListViewController.m
//  Template
//
//  Created by R on 14/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import "ShoppingListViewController.h"

@interface ShoppingListViewController ()

@end

@implementation ShoppingListViewController
@synthesize barItem,navBar,lblTitle,tblView;
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[AppDelegate initAppDelegate];
    navBar.backgroundColor=[Utility getColor:appDelegate.strColor];
    arrData=[[NSMutableArray alloc]init];
    arrData=[DataManager getAllShoppingList];
    [self defaultThemeSetUp];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger numOfSections = 0;
    if ([arrData count]>0)
    {
        numOfSections=1;
    }
    else
    {
        UILabel *noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tblView.bounds.size.width, tblView.bounds.size.height)];
        noDataLabel.text             = @"No data available";
        noDataLabel.textColor        = [UIColor grayColor];
        noDataLabel.textAlignment    = NSTextAlignmentCenter;
        tblView.backgroundView = noDataLabel;
        tblView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return numOfSections;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Item *obj=[[Item alloc]init];
    obj=[arrData objectAtIndex:indexPath.row];
    
    UIImageView *img=(UIImageView*) [cell.contentView viewWithTag:99];
    if (([obj.is_mark isEqual:@"y"]==false) || obj.is_mark==nil) {
        img.image=[UIImage imageNamed:@"shoping_list.png"];
    }
    else{
        img.image=[UIImage imageNamed:@"check.png"];
        img.image = [img.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [img setTintColor:[Utility getColor:appDelegate.strColor]];
    }
    UILabel *lblItem =(UILabel*) [cell.contentView viewWithTag:101];
    
    lblItem.text = obj.item;
    lblItem.textColor=[Utility getColor:appDelegate.strColor];
    
    UILabel *lblMeasure =(UILabel*) [cell.contentView viewWithTag:102];
    
    lblMeasure.text = obj.measure;
    
    UIView *line =(UIView *) [cell.contentView viewWithTag:103];
    line.frame=CGRectMake(line.frame.origin.x, line.frame.origin.y, line.frame.size.width, 0.5);
    line.backgroundColor=[Utility getColor:appDelegate.strColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Item *obj=[[Item alloc]init];
    obj=[arrData objectAtIndex:indexPath.row];
    UIAlertView *alert=nil;
    if (([obj.is_mark isEqual:@"y"]==true) || obj.is_mark==nil) {
        alert = [[UIAlertView alloc] initWithTitle:obj.item message:[NSString stringWithFormat:@"Measure: %@",obj.measure] delegate:self cancelButtonTitle:@"Mark as Unpurchased" otherButtonTitles:@"Cancel", nil];
    }
    else{
        alert = [[UIAlertView alloc] initWithTitle:obj.item message:[NSString stringWithFormat:@"Measure: %@",obj.measure] delegate:self cancelButtonTitle:@"Mark as Purchased" otherButtonTitles:@"Cancel", nil];
        
    }
    alert.tag=obj.ID;
    [alert show];
}
- (IBAction)btnAddItem:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add Item" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done", nil];
    [alert setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    [[alert textFieldAtIndex:1] setSecureTextEntry:NO];
    [[alert textFieldAtIndex:0] setPlaceholder:@"Enter Item Name"];
    [[alert textFieldAtIndex:1] setPlaceholder:@"Enter Measure"];
    alert.tag=10;
    [alert show];
}

- (IBAction)btnClean:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Do you want to clear shopping list?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    alert.tag=9;
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==9) {
        if (buttonIndex == 0){
            [DataManager deleteAllShoppingList];
            [arrData removeAllObjects];
            arrData=[DataManager getAllShoppingList];
            [UIView transitionWithView:tblView
                              duration:0.5f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^(void) {
                                [tblView reloadData];
                            } completion:NULL];
        }
    }
    else if(alertView.tag==10){
        if ([alertView textFieldAtIndex:0].text.length==0 || [alertView textFieldAtIndex:1].text.length==0) {
            [Utility showAlertWithTitleAndMessage:@"Invalid Input" message:@"Please try again."];
        }
        else{
            Item *obj=[[Item alloc]init];
            obj.item=[alertView textFieldAtIndex:0].text;
            obj.measure=[alertView textFieldAtIndex:1].text;
            [DataManager insertShoppingList:obj];
            [arrData removeAllObjects];
            [tblView setBackgroundView:nil];
            arrData=[DataManager getAllShoppingList];
            [UIView transitionWithView:tblView
                              duration:0.5f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^(void) {
                                [tblView reloadData];
                            } completion:NULL];
        }
    }
    else{
        if (buttonIndex == 0){
            Item *obj=[[Item alloc]init];
            obj=[DataManager checkIsPurchased:alertView.tag];
            if ([obj.is_mark isEqual:@"y"]) {
                obj.is_mark=@"";
                [DataManager updateMarkAsPurchased:obj];
            }
            else{
                obj.is_mark=@"y";
                [DataManager updateMarkAsPurchased:obj];
            }
            [arrData removeAllObjects];
             arrData=[DataManager getAllShoppingList];
            [UIView transitionWithView:tblView
                              duration:0.5f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^(void) {
                                [tblView reloadData];
                            } completion:NULL];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
