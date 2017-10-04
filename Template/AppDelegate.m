//
//  AppDelegate.m
//  Template
//
//  Created by R on 06/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize strColor;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (iPhoneVersion == 4)
    {
        SWRevealViewController *viewController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"story_main"];
        self.window.rootViewController=viewController;
    }
    else if (iPhoneVersion == 5)
    {
        SWRevealViewController *viewController=[[UIStoryboard storyboardWithName:@"iPhone_5" bundle:nil] instantiateViewControllerWithIdentifier:@"story_main"];
        self.window.rootViewController=viewController;
    }
    else if (iPhoneVersion == 6)
    {
        SWRevealViewController *viewController=[[UIStoryboard storyboardWithName:@"iPhone_6" bundle:nil] instantiateViewControllerWithIdentifier:@"story_main"];
        self.window.rootViewController=viewController;
    }
    else if (iPhoneVersion == 61)
    {
        SWRevealViewController *viewController=[[UIStoryboard storyboardWithName:@"iPhone_6Plus" bundle:nil] instantiateViewControllerWithIdentifier:@"story_main"];
        self.window.rootViewController=viewController;
    }
    else
    {
        SWRevealViewController *viewController=[[UIStoryboard storyboardWithName:@"iPad" bundle:nil] instantiateViewControllerWithIdentifier:@"story_main"];
        self.window.rootViewController=viewController;
    }
    
    /*SWRevealViewController *viewController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"story_main"];
    self.window.rootViewController=viewController;*/
    strColor=@"E97E71";
    DataManager *obj=[[DataManager alloc]init];
    [obj openDatabase];
    return YES;
}
+(AppDelegate*)initAppDelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication]delegate];
}
-(void)showProgressView{
    CGRect frame;
    if (!lightBoxView) {
        lightBoxView = [[UIView alloc ]init];
        [lightBoxView setFrame:CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height)];
        frame = CGRectMake( (self.window.frame.size.width/2)-50 ,(self.window.frame.size.height/2)-55 , 100, 110);
        [lightBoxView setAlpha:0.4];
        [lightBoxView setBackgroundColor:[UIColor blackColor]];
        progressView=[[UIView alloc]initWithFrame:frame];
        [progressView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
        [progressView setUserInteractionEnabled:FALSE];
        [progressView.layer setBorderColor:[UIColor clearColor].CGColor];
        [progressView.layer setCornerRadius:10];
        UILabel *lblLoading=[[UILabel alloc]initWithFrame:CGRectMake(10, 75, 100, 30)];
        [lblLoading setText:@"Loading..."];
        [lblLoading setBackgroundColor:[UIColor clearColor]];
        [lblLoading setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
        [lblLoading setTextColor:[UIColor whiteColor]];
        [progressView addSubview:lblLoading];
        UIActivityIndicatorView *activityIndicatorView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [progressView addSubview:activityIndicatorView];
        [activityIndicatorView setCenter:CGPointMake(50,50)];
        [activityIndicatorView startAnimating];
        [progressView setFrame:frame];
        [self.window.rootViewController.view setUserInteractionEnabled:TRUE];
    }
    [self.window addSubview:lightBoxView];
    [self.window addSubview:progressView];
}
-(void)hideProgressView
{
    [progressView removeFromSuperview];
    [lightBoxView removeFromSuperview];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
