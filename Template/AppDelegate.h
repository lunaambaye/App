//
//  AppDelegate.h
//  Recipe
//
//  Created by R on 06/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "Static.h"
#import "DataManager.h"
#define ShowProgressView [(AppDelegate*)[[UIApplication sharedApplication]delegate] showProgressView];
#define HideProgressView [(AppDelegate*)[[UIApplication sharedApplication]delegate] hideProgressView];
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIView *lightBoxView;
    UIView *progressView;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString* strColor;
-(void)showProgressView;
-(void)hideProgressView;
+(AppDelegate*)initAppDelegate;

@end

