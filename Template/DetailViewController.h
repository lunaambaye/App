//
//  DetailViewController.h
//  Template
//
//  Created by R on 06/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Recipe.h"
#import "AppDelegate.h"
#import "Static.h"
#import "Utility.h"
#import "RecipeModel.h"
@interface DetailViewController : UIViewController<MFMailComposeViewControllerDelegate,GADInterstitialDelegate>{
    AppDelegate *appDelegate;
    NSString *htmlString;
    NSAttributedString *attributedString;
    BOOL isIngredientVisible;
}
@property(nonatomic, strong) GADInterstitial *interstitial;
@property(nonatomic,retain)RecipeModel *objRecipe;
@property(nonatomic,retain)IBOutlet UIView *navBar;
@property(nonatomic,retain)IBOutlet UIView *line;
@property(nonatomic,retain)IBOutlet UILabel *lblTitle;
@property(nonatomic,retain)IBOutlet UIImageView *imgTime;
@property(nonatomic,retain)IBOutlet UILabel *lblTime;
@property(nonatomic,retain)IBOutlet UIImageView *imgPeople;
@property(nonatomic,retain)IBOutlet UILabel *lblPeople;
@property(nonatomic,retain)IBOutlet UIImageView *imgRecipeImage;
@property(nonatomic,retain)IBOutlet UITextView *txtDetail;
@property(nonatomic,retain)IBOutlet UIButton *btnFevorite;
@property(nonatomic,retain)IBOutlet UIButton *btnIngredients;
-(IBAction)btnIndredients:(id)sender;
-(IBAction)btnVideo:(id)sender;
-(IBAction)btnFevourite:(id)sender;
-(IBAction)btnMail:(id)sender;
@end
