//
//  NoteDetailViewController.m
//  Template
//
//  Created by R on 13/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import "NoteDetailViewController.h"

@interface NoteDetailViewController ()

@end

@implementation NoteDetailViewController
@synthesize objNote,navBar,lblTitle,txtDetail;
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
    
    lblTitle.text=objNote.title;
    txtDetail.text=objNote.detail;
    
}
-(IBAction)btnDelete:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Do you want to delete note?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        [DataManager deleteNoteFromID:objNote.ID];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
