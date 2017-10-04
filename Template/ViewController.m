//
//  ViewController.m
//  Template
//
//  Created by R on 06/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import "ViewController.h"
#import "RecipeModel.h"
#import "RecipeCell.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize barItem,navBar,lblTitle,bannerView;
@synthesize tblView,filteredTableData,searchBar,isFiltered;
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[AppDelegate initAppDelegate];
    [self initialize];
    [self defaultThemeSetUp];
   
    arrData= [RecipeModel allRecipes];
    //arrData=[DataManager getAllData:@""];
    
    if (arrData.count == 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:true];
        hud.label.text = @"Loading Recipes";
    }
    
    [RecipeModel loadRecipes];
    
    /*[DataManager getAllData:@"" withCompletion:^(NSMutableArray *data, NSError *error){
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (!error) {
                arrData = data;
                [tblView reloadData];
                [hud hideAnimated:true];
            }else{
                [hud hideAnimated:true];
                [[[UIAlertView alloc] initWithTitle:error.localizedDescription message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            }
        });
    }];*/
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recipesLoaded) name:@"RecipesLoaded" object:nil];
    
    if ([ADS_VISIBILITY isEqualToString:@"YES"]) {
        [Utility createAndLoadBanner:bannerView];
        if (iPhoneVersion==4 || iPhoneVersion==5) {
            tblView.frame=CGRectMake(tblView.frame.origin.x, tblView.frame.origin.y, tblView.frame.size.width, tblView.frame.size.height-50);
        }
        else{
            tblView.frame=CGRectMake(tblView.frame.origin.x, tblView.frame.origin.y, tblView.frame.size.width, tblView.frame.size.height-65);
        }
    }
    
}

- (void)recipesLoaded {
    arrData= [RecipeModel allRecipes];
    [tblView reloadData];
        
    [MBProgressHUD hideHUDForView:self.view animated:true];
}

-(void)initialize{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *myString = [prefs stringForKey:@"COLOR"];
    for (UIView *view in searchBar.subviews){
        if ([view isKindOfClass: [UITextField class]]) {
            UITextField *tf = (UITextField *)view;
            tf.delegate = (id)self;
            break;
        }
    }

    if (myString.length==0) {
        [prefs setObject:DEFAULT_COLOR forKey:@"COLOR"];
        appDelegate.strColor=DEFAULT_COLOR;
        [prefs synchronize];
    }
    else{
        appDelegate.strColor = [prefs stringForKey:@"COLOR"];
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
    
    //----------------Navigation Bar & Title-------------------
    self.navBar.backgroundColor=[Utility getColor:appDelegate.strColor];
    
    searchBar.delegate = (id)self;
    self.searchBar.barTintColor = [Utility getColor:appDelegate.strColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO];
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
    
    RecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.clipsToBounds = true;
    if (cell == nil)
        cell = [[RecipeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    RecipeModel *obj=[[RecipeModel alloc]init];

    if(isFiltered)
        obj = [filteredTableData objectAtIndex:indexPath.row];
    else
        obj = [arrData objectAtIndex:indexPath.row];
    
    cell.recipe = obj;
    
    UIImageView *imageRecipe=(UIImageView*) [cell.contentView viewWithTag:100];
    //imageRecipe.image=[UIImage imageNamed:obj.image];
    
    /*NSURL *url = [NSURL URLWithString:obj.image];
    NSData *data = [NSData dataWithContentsOfURL:url];*/
    imageRecipe.contentMode = UIViewContentModeScaleAspectFill;
    imageRecipe.image = [[UIImage alloc] initWithData:obj.image];
    
    UILabel *lblName =(UILabel*) [cell.contentView viewWithTag:101];
    lblName.text = obj.name;
    
    //UILabel *lblCategory =(UILabel*) [cell.contentView viewWithTag:102];
    //lblCategory.text = [obj.category uppercaseString];
    
    UILabel *lblTime =(UILabel*) [cell.contentView viewWithTag:103];
    lblTime.text = [NSString stringWithFormat:@"%@ Min",obj.time];
    
    UILabel *lblPerson =(UILabel*) [cell.contentView viewWithTag:104];
    lblPerson.text = [NSString stringWithFormat:@"%@ People",obj.person];
    
    UILabel *cntLabel =(UILabel*) [cell.contentView viewWithTag:105];
    cntLabel.font = [UIFont boldSystemFontOfSize:16];
    cntLabel.textColor = [UIColor redColor];
    
    if(isFiltered)
        cntLabel.text = [NSNumberFormatter localizedStringFromNumber:@(obj.foundCount) numberStyle:NSNumberFormatterDecimalStyle];
    else
        cntLabel.text = @"";
    
    return cell;
}
#pragma mark - Table view delegate

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
 
    //
    if(text.length == 0)
    {
        isFiltered = FALSE;
        [self.searchBar resignFirstResponder];
         [self.tblView reloadData];
    }
    else
    {
        isFiltered = true;
        filteredTableData = [[NSMutableArray alloc] init];
        NSArray *texts = [text componentsSeparatedByString:@","];
        
        for (RecipeModel *obj in arrData) {
            obj.foundCount = 0;
        }
        
        for (RecipeModel *obj in arrData) {
            for (NSString* str in texts)
            {
                //NSRange nameRange = [obj.name rangeOfString:str options:NSCaseInsensitiveSearch];
                NSRange ingRange = [obj.ingredients rangeOfString:str options:NSCaseInsensitiveSearch];
                /*if(nameRange.location != NSNotFound)
                {
                    if (nameRange.location==0) {
                        [filteredTableData addObject:obj];
                    }
                }else */if (ingRange.location != NSNotFound)
                {
                    if (![filteredTableData containsObject:obj]) {
                        [filteredTableData addObject:obj];
                    }
                    obj.foundCount++;
                    //NSLog(@"%ld -> %@ -> %@",(long)obj.foundCount,obj.name,str);
                }
                
            }
            /*-------- This loop is usefull search multiple field
             AND search inside the word*/
            /*for (Recipe* obj in arrData)
            {
                NSRange nameRange = [obj.category rangeOfString:str options:NSCaseInsensitiveSearch];
                NSRange descriptionRange = [obj.ingredient rangeOfString:str options:NSCaseInsensitiveSearch];
                if(nameRange.location != NSNotFound || descriptionRange.location != NSNotFound)
                {
                    if ([filteredTableData containsObject:obj]) {
                        
                    }
                    else {
//                        [filteredTableData addObject:obj];
                        NSLog(@"%@ -> %@",obj,str);
                        [filteredTableData insertObject:obj atIndex:0];
                    }
                    
                }
            }*/
        }
        [self.tblView reloadData];
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self showDetailsForIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    [self showDetailsForIndexPath:indexPath];
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
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

- (void)dealloc {
    [[NSNotificationCenter  defaultCenter] removeObserver:self];
}

@end
