//
//  AddViewController.m
//  Template
//
//  Created by R on 13/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController
@synthesize navBar,lblTitle,txtDetail,txtHeading,btnDone;
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate=[AppDelegate initAppDelegate];
    self.navBar.backgroundColor=[Utility getColor:appDelegate.strColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    [[self.txtDetail layer] setBorderColor:[[Utility getColor:@"c6c6c6"] CGColor]];
    [[self.txtDetail layer] setBorderWidth:0.5];
    [[self.txtDetail layer] setCornerRadius:10];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleKeyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(handleKeyboardWillHide:)
     name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [btnDone setBackgroundColor:[Utility getColor:appDelegate.strColor]];
}
-(void)dismissKeyboard {
    [self.view endEditing:YES];
}
- (void) handleKeyboardDidShow:(NSNotification *)paramNotification{
    
    NSValue *keyboardRectAsObject =
    [[paramNotification userInfo]
     objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    
    CGRect keyboardRect = CGRectZero;
    [keyboardRectAsObject getValue:&keyboardRect];
    
    
    txtDetail.contentInset =
    UIEdgeInsetsMake(0.0f,
                     0.0f,
                     keyboardRect.size.height-45,
                     0.0f);
}
- (void) handleKeyboardWillHide:(NSNotification *)paramNotification{
    
    txtDetail.contentInset = UIEdgeInsetsZero;
    
}
-(IBAction)btnDone:(id)sender{
    if (txtDetail.text.length!=0) {
        Note *obj=[[Note alloc]init];
        if (txtHeading.text.length==0) {
            obj.title=@"Untitled";
        }
        else{
            obj.title=txtHeading.text;
        }
        obj.detail=txtDetail.text;
        [DataManager insertNoteData:obj];
        txtHeading.text=@"";
        txtDetail.text=@"";
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [Utility showAlertWithTitleAndMessage:@"Invalid" message:@"Please insert some text."];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
