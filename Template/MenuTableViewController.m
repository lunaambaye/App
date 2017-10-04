#import "MenuTableViewController.h"
#import "SWRevealViewController.h"
@interface MenuTableViewController ()

@end

@implementation MenuTableViewController
@synthesize tblView,navBar;
-(void)viewWillAppear:(BOOL)animated{
    navBar.backgroundColor=[Utility getColor:appDelegate.strColor];
    [tblView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[AppDelegate initAppDelegate];
    navBar.backgroundColor=[Utility getColor:appDelegate.strColor];
    self.view.backgroundColor=[UIColor whiteColor];
    arrMenu=@[@"All Recipes",
              @"Favorites",
              @"Add Note",
              @"Shopping List",
              @"Setting",
              @"Rate App",
              @"Share App",
              @"About Us"];
    arrImages=@[@"recipe.png",
                @"fevorite.png",
                @"note.png",
                @"shoping_list.png",
                @"setting.png",
                @"rate.png",
                @"share.png",
                @"info.png"];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrMenu count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UILabel *lblTitle =(UILabel*) [cell.contentView viewWithTag:101];
    lblTitle.textColor=[Utility getColor:appDelegate.strColor];
    lblTitle.text = [arrMenu objectAtIndex:indexPath.row];
    lblTitle.font = [UIFont fontWithName:FONT size:17];
    
    UIImageView *img =(UIImageView*) [cell.contentView viewWithTag:102];
    img.image=[UIImage imageNamed:[arrImages objectAtIndex:indexPath.row]];
    /*img.image = [img.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img setTintColor:[Utility getColor:appDelegate.strColor]];*/
    
    UIView *line =(UIView*) [cell.contentView viewWithTag:103];
    line.backgroundColor=[Utility getColor:appDelegate.strColor];
    line.frame=CGRectMake(line.frame.origin.x, line.frame.origin.y, line.frame.size.width, 0.5);
    NSLog(@"\nx= %f",line.frame.origin.x);
    NSLog(@"\ny= %f",line.frame.origin.y);
    NSLog(@"\nwidth= %f",line.frame.size.width);
    NSLog(@"\nheight= %f",line.frame.size.height);
    return cell;
}
#pragma mark - Navigation
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
    NSString *strItem=[NSString stringWithFormat:@"%@",[arrMenu objectAtIndex:indexPath.row]];
    if ([strItem isEqualToString:@"All Recipes"]==TRUE) {
        ViewController *objViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        [navController setViewControllers: @[objViewController] animated: NO ];
    }
    else if ([strItem isEqualToString:@"Categories"]==TRUE) {
        CategoryViewController *objViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"CategoryViewController"];
        [navController setViewControllers: @[objViewController] animated: NO ];
    }
    else if ([strItem isEqualToString:@"Favorites"]==TRUE){
        FavouriteViewController *objViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"FavouriteViewController"];
        [navController setViewControllers: @[objViewController] animated: NO ];
    }
    else if([strItem isEqualToString:@"Add Note"]==TRUE)
    {
        AddNoteViewController *objViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"AddNoteViewController"];
            [navController setViewControllers: @[objViewController] animated: NO ];
    }
    else if([strItem isEqualToString:@"Shopping List"]==TRUE)
    {
        ShoppingListViewController *objViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"ShoppingListViewController"];
        [navController setViewControllers: @[objViewController] animated: NO ];
    }
    else if([strItem isEqualToString:@"Setting"]==TRUE)
    {
        SettingViewController *objViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
        [navController setViewControllers: @[objViewController] animated: NO ];
    }
    else if([strItem isEqualToString:@"Rate App"]==TRUE)
    {
        [Appirater setDelegate:self];
        [Appirater setAppId:APPID];
        [Appirater setDaysUntilPrompt:1];
        [Appirater setUsesUntilPrompt:10];
        [Appirater setSignificantEventsUntilPrompt:-1];
        [Appirater setTimeBeforeReminding:2];
        [Appirater appLaunched:YES];
        [Appirater setDebug:YES];
    }
    else if([strItem isEqualToString:@"Share App"]==TRUE)
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Share" message:nil delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"Facebook",@"WhatsApp",@"Twitter", nil];
        [alert show];
    }
    else if([strItem isEqualToString:@"More App"]==TRUE)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:MORE_APP_LINK]];
    }
    else if([strItem isEqualToString:@"About Us"]==TRUE)
    {
        AboutUsViewController *objViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
        [navController setViewControllers: @[objViewController] animated: NO ];
    }
    [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        if (buttonIndex==1)
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 114, 114)];
            imageView.backgroundColor=[UIColor clearColor];
            UIImage *image = [UIImage imageNamed:@"Icon-152"];
            [imageView setImage:image];
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                mySLcomposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                [mySLcomposerSheet setInitialText: SHARE_TEXT];
                [mySLcomposerSheet addURL:[NSURL URLWithString:SHARE_APP_LINK]];
                [mySLcomposerSheet addImage: imageView.image];
                [self presentViewController:mySLcomposerSheet animated:true completion:nil];
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                                    message: @"Please go to Settings and add your Facebook account to this device!"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                [alertView show];
            }
            [mySLcomposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
                NSString *output;
                switch (result) {
                    case SLComposeViewControllerResultCancelled:
                        output = @"Sharing Cancelled!";
                        break;
                    case SLComposeViewControllerResultDone:
                        output = @"Your Post is on Facebook!";
                        break;
                        
                    default: break;
                }
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook"
                                                                message:output
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
            }];
            
        }
        else if(buttonIndex==2)
        {
            NSString * msg = [[@"Application%20" stringByAppendingString:@"%@%20Dictionary"]stringByAppendingString:SHARE_APP_LINK];
            msg = [msg stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
            msg = [msg stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
            msg = [msg stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
            msg = [msg stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
            msg = [msg stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
            msg = [msg stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
            
            NSString * urlWhats = [NSString stringWithFormat:@"whatsapp://send?text=%@",msg];
            NSURL * whatsappURL = [NSURL URLWithString:urlWhats];
            if ([[UIApplication sharedApplication] canOpenURL: whatsappURL])
            {
                [[UIApplication sharedApplication] openURL: whatsappURL];
            }
            else
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"WhatsApp not installed." message:@"Your device has no WhatsApp installed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
        }
        else if(buttonIndex==3)
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 114, 114)];
                        imageView.backgroundColor=[UIColor clearColor];
            UIImage *image = [UIImage imageNamed:@"Icon-152"];
            [imageView setImage:image];
            
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
                mySLcomposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                [mySLcomposerSheet setInitialText: SHARE_TEXT];
                [mySLcomposerSheet addURL:[NSURL URLWithString:SHARE_APP_LINK]];
                [mySLcomposerSheet addImage: imageView.image];
                [self presentViewController:mySLcomposerSheet animated:true completion:nil];
                
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                                    message: @"Please go to Settings and add your Twitter account to this device!"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                [alertView show];
            }
            [mySLcomposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
                NSString *output;
                switch (result) {
                    case SLComposeViewControllerResultCancelled:
                        output = @"Sharing Cancelled!";
                        break;
                    case SLComposeViewControllerResultDone:
                        output = @"Your Post is on Twitter!";
                        break;
                        
                    default: break;
                }
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter"
                                                                message:output
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }];
            
        }
    
}
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
