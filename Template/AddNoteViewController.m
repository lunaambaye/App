//
//  AddNoteViewController.m
//  Template
//
//  Created by R on 13/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import "AddNoteViewController.h"

@interface AddNoteViewController ()

@end

@implementation AddNoteViewController
@synthesize barItem,navBar,lblTitle,tblView;
-(void)viewWillAppear:(BOOL)animated{
    [tblView setBackgroundView:nil];
    arrData=[DataManager getAllNote];
    [UIView transitionWithView:tblView
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^(void) {
                        [tblView reloadData];
                    } completion:NULL];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[AppDelegate initAppDelegate];
    navBar.backgroundColor=[Utility getColor:appDelegate.strColor];
    arrData=[[NSMutableArray alloc]init];
    arrData=[DataManager getAllNote];
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
    
    Note *obj=[[Note alloc]init];
    obj=[arrData objectAtIndex:indexPath.row];
    
    UILabel *lblHeading =(UILabel*) [cell.contentView viewWithTag:101];
    
    lblHeading.text = obj.title;
    lblHeading.textColor=[Utility getColor:appDelegate.strColor];
    UIView *line =(UIView *) [cell.contentView viewWithTag:102];
    line.frame=CGRectMake(line.frame.origin.x, line.frame.origin.y, line.frame.size.width, 0.5);
    line.backgroundColor=[Utility getColor:appDelegate.strColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Note *obj=[[Note alloc]init];
    obj=[arrData objectAtIndex:indexPath.row];
    
    NoteDetailViewController *detailVC =[self.storyboard instantiateViewControllerWithIdentifier:@"NoteDetailViewController"];
    detailVC.objNote=obj;
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (IBAction)btnAddNote:(id)sender{
    AddViewController *detailVC =[self.storyboard instantiateViewControllerWithIdentifier:@"AddViewController"];
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (IBAction)btnClean:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Do you want to clear note list?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        [DataManager deleteAllNote];
        arrData=[DataManager getAllNote];
        [tblView reloadData];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
