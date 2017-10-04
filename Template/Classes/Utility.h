//
//  ViewController.h
//  Template
//
//  Created by R on 06/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Static.h"
#import "CheckConnection.h"
#import "GoogleMobileAdsHelper.h"
@interface Utility : NSObject

+ (NSString *) getDBPath;
+ (void) copyDatabaseIfNeeded;

+(BOOL)checkOriantationIsIPhone;
+(BOOL)checkOriantationIsIPad;

+(void)showAlertWithMessage :(NSString*)message;
+(void)showAlertWithTitleAndMessage :(NSString*)title message:(NSString*)message;
+ (NSInteger)randomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max;
+ (UIColor *) getColor: (NSString *) hexColor;
+(BOOL) isValidEmaidId:(NSString *)str;
+(BOOL) isNumber:(NSString *)str;

+(NSMutableArray *)generateRandomUniqueNumberInRange :(int)rangeLow rangeHigh:(int)rangeHigh Capacity :(int)capacity;
+(void)createAndLoadBanner:(GADBannerView*)bannerView;
@end
