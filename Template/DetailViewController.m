//
//  DetailViewController.m
//  Template
//
//  Created by R on 06/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import "DetailViewController.h"
@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize navBar,lblTitle,objRecipe,imgPeople,imgTime,imgRecipeImage,txtDetail,lblPeople,lblTime,btnFevorite,btnIngredients,line,interstitial;
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[AppDelegate initAppDelegate];
    [self defaultThemeSetUp];
    if ([ADS_VISIBILITY isEqualToString:@"YES"]) {
        [self createAndLoadInterstitial];
    }
}
-(void)defaultThemeSetUp{
    //----------------Navigation Bar & Title-------------------
    self.view.backgroundColor=[UIColor whiteColor];
    self.navBar.backgroundColor=[Utility getColor:appDelegate.strColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    if (![objRecipe.favorite boolValue]){
        [btnFevorite setImage:[UIImage imageNamed:@"unfev.png"]
                      forState:UIControlStateNormal];
    }
    else{
        [btnFevorite setImage:[UIImage imageNamed:@"fev.png"]
                      forState:UIControlStateNormal];
    }
    //if ([objRecipe.video isEqual:@""] || objRecipe.video==nil){
    //}
    lblTitle.text=objRecipe.name;
    //imgRecipeImage.image = [UIImage imageNamed:objRecipe.image];
    
    /*NSURL *url = [NSURL URLWithString:objRecipe.image];
    NSData *data = [NSData dataWithContentsOfURL:url];*/
    imgRecipeImage.contentMode = UIViewContentModeScaleAspectFill;
    imgRecipeImage.image = [[UIImage alloc] initWithData:objRecipe.image];
    imgRecipeImage.clipsToBounds = true;
    
    [imgRecipeImage setAlpha:0.0];
    [UIView animateWithDuration:0.8 animations:^{
        [imgRecipeImage setAlpha:1.0];
    }];
    
    imgTime.image=[UIImage imageNamed:@"time.png"];
    imgTime.image = [imgTime.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [imgTime setTintColor:[Utility getColor:appDelegate.strColor]];
    
    imgPeople.image=[UIImage imageNamed:@"person.png"];
    imgPeople.image = [imgPeople.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [imgPeople setTintColor:[Utility getColor:appDelegate.strColor]];
    
    lblTime.text=[NSString stringWithFormat:@"%@ Minutes",objRecipe.time];
    lblPeople.text=[NSString stringWithFormat:@"%@ People",objRecipe.person];
    
//    htmlString = [NSString stringWithFormat:@"<!doctype html>    <html><head><meta charset='utf-8'><title></title></head><body>  <font size=4.9em face='Gill Sans' color='#2c2c27'>%@</font></body></html>",objRecipe.detail];
//    attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//    
//    [UIView animateWithDuration:1.0
//                     animations:^{
//                         txtDetail.alpha = 0.0f;
//                         txtDetail.attributedText = attributedString;
//                         txtDetail.alpha = 1.0f;
//                     }];
    [btnIngredients setTitle:@"STEPS" forState:UIControlStateNormal];
    htmlString = [NSString stringWithFormat:@"<!doctype html>    <html><head><meta charset='utf-8'><title></title></head><body>  <font size=4.9em face='Gill Sans' color='#2c2c27'>%@</font></body></html>",objRecipe.ingredients];
    attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [UIView animateWithDuration:1.0
                     animations:^{
                         txtDetail.alpha = 0.0f;
                         txtDetail.text = objRecipe.ingredients;
                         txtDetail.alpha = 1.0f;
                     }];
    isIngredientVisible=true;
   
    [btnIngredients setTitleColor:[Utility getColor:appDelegate.strColor] forState:UIControlStateNormal];
    
    
    line.frame=CGRectMake(0,self.line.frame.origin.y, self.line.frame.size.width, 0.5);
    self.line.backgroundColor=[Utility getColor:appDelegate.strColor];
}

-(IBAction)btnFevourite:(id)sender{
    if (![objRecipe.favorite boolValue]){
        [btnFevorite setImage:[UIImage imageNamed:@"fev.png"]
                      forState:UIControlStateNormal];
        objRecipe.favorite=@(YES);
        //[DataManager updateFevoriteData:objRecipe];
    }
    else{
        [btnFevorite setImage:[UIImage imageNamed:@"unfev.png"]
                      forState:UIControlStateNormal];
        objRecipe.favorite=@(NO);
        //[DataManager updateFevoriteData:objRecipe];
    }
}
- (IBAction)btnVideoTapped:(id)sender {
    /*VideoViewController *objViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VideoViewController"];
    objViewController.strURL=objRecipe.video;
    objViewController.strRecipe=objRecipe.name;
    [self.navigationController pushViewController:objViewController animated:true];*/
}

-(IBAction)btnIndredients:(id)sender{
    if (isIngredientVisible!=true) {
        [btnIngredients setTitle:@"STEPS" forState:UIControlStateNormal];
        htmlString = [NSString stringWithFormat:@"<!doctype html>    <html><head><meta charset='utf-8'><title></title></head><body>  <font size=4.9em face='Gill Sans' color='#2c2c27'>%@</font></body></html>",objRecipe.ingredients];
        attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        [UIView animateWithDuration:1.0
                         animations:^{
                             txtDetail.alpha = 0.0f;
                             txtDetail.text = objRecipe.ingredients;
                             txtDetail.alpha = 1.0f;
                         }];
        isIngredientVisible=true;
    }
    else{
         [btnIngredients setTitle:@"INGREDIENTS" forState:UIControlStateNormal];
            htmlString = [NSString stringWithFormat:@"<!doctype html>    <html><head><meta charset='utf-8'><title></title></head><body>  <font size=4.9em face='Gill Sans' color='#2c2c27'>%@</font></body></html>",objRecipe.detail];
            attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
            [UIView animateWithDuration:1.0
                             animations:^{
                                 txtDetail.alpha = 0.0f;
                                 txtDetail.text = objRecipe.detail;
                                 txtDetail.alpha = 1.0f;
                             }];
         isIngredientVisible=false;
    }
}
-(IBAction)btnMail:(id)sender{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    
    picker.mailComposeDelegate = self;
    
    [picker setSubject:objRecipe.name];
    
    NSData *imageData = UIImagePNGRepresentation(imgRecipeImage.image);
    [picker addAttachmentData:imageData mimeType:@"image/png" fileName:[NSString stringWithFormat:@"Recipe for %@",objRecipe.name]];
    NSString *strContent=[NSString stringWithFormat:@"<h3>Ingredients:</h3>%@<h3>Stpes:</h3>%@",objRecipe.ingredients,objRecipe.detail];
    [picker setMessageBody:strContent isHTML:YES];
    
    [self presentViewController:picker animated:YES completion:NULL];
}
-(IBAction)btnVideo:(id)sender{
    /*VideoViewController *objViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"VideoViewController"];
    objViewController.strURL=objRecipe.video;
    objViewController.strRecipe=objRecipe.name;
    [self.navigationController pushViewController:objViewController animated:true];*/
}
#pragma mark GADInterstitialDelegate implementation
- (void)createAndLoadInterstitial {
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:AdmobFullScreenAdsID];
    self.interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
#ifdef __i386__
    request.testDevices = @[ kGADSimulatorID ];
    NSLog(@"Running in the simulator");
#else
    request.testDevices = @[@"2077ef9a63d2b398840261c8221a0c9a"];
#endif
    [self.interstitial loadRequest:request];
}
- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitialDidFailToReceiveAdWithError: %@", [error localizedDescription]);
}
- (void)interstitialDidReceiveAd:(DFPInterstitial *)ad
{
    [self.interstitial presentFromRootViewController:self];
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:self];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
