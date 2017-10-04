//
//  ViewController.h
//  Template
//
//  Created by R on 06/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import "Utility.h"

@implementation Utility
#pragma mark copy Database
+ (NSString *) getDBPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSLog(@"Local Database Path is %@",documentsDir);
    return [documentsDir stringByAppendingPathComponent:@"Database"];
}
+ (void) copyDatabaseIfNeeded {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *dbPath = [self getDBPath];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    if(!success) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Database"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        if (!success)
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}
#pragma mark Check iPhone or iPad
+(BOOL)checkOriantationIsIPhone{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return TRUE;
    }
    else {
        return FALSE;
    }
}
+(BOOL)checkOriantationIsIPad
{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        return TRUE;
    }
    else {
        return FALSE;
    }
}
#pragma mark alert
+(void)showAlertWithMessage :(NSString*)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show];
}
+(void)showAlertWithTitleAndMessage :(NSString*)title message:(NSString*)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show];
}
+(BOOL) isNumber:(NSString *)str
{
    NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithRange:NSMakeRange('0',10)] invertedSet];
    NSString *trimmed = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    BOOL isNumeric = trimmed.length > 0 && [trimmed rangeOfCharacterFromSet:nonNumberSet].location == NSNotFound;
    return isNumeric;
}
+(BOOL) isValidEmaidId:(NSString *)str
{
    NSString *email = str;
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:email];
}
+(NSInteger)randomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max
{
    return min + arc4random_uniform(max - min + 1);
}
+ (UIColor *) getColor: (NSString *) hexColor
{
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}
+(NSMutableArray *)generateRandomUniqueNumberInRange :(int)rangeLow rangeHigh:(int)rangeHigh Capacity :(int)capacity {
    NSMutableArray *unqArray=[[NSMutableArray alloc] initWithCapacity:capacity];
    int randNum = arc4random() % (rangeHigh-rangeLow+1) + rangeLow;
    int counter=0;
    while (counter<rangeHigh-rangeLow) {
        if (![unqArray containsObject:[NSNumber numberWithInt:randNum]]) {
            [unqArray addObject:[NSNumber numberWithInt:randNum]];
            counter++;
        }else{
            randNum = arc4random() % (rangeHigh-rangeLow+1) + rangeLow;
        }
        if (counter==capacity) {
            break;
        }
    }
    return unqArray;
}
+(void)createAndLoadBanner:(GADBannerView*)bannerView{
    bannerView.hidden=NO;
    bannerView.adUnitID = AdmobBannerAdsID;
    bannerView.rootViewController = (id)self;
    GADRequest *request = [GADRequest request];
#ifdef __i386__
    request.testDevices = @[ kGADSimulatorID ];
    NSLog(@"Running in the simulator");
#else
    request.testDevices = @[@"2077ef9a63d2b398840261c8221a0c9a"];
#endif
    [bannerView loadRequest:request];
}
@end
