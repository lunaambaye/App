//
//  ViewController.h
//  Template
//
//  Created by R on 06/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Static : NSObject

//Text to share with user
#define SHARE_TEXT @"App Share text detail"

//Link of the sharing app
#define SHARE_APP_LINK @"https://itunes.apple.com/us/app/"

//More application
#define MORE_APP_LINK @"itmss://itunes.apple.com/us/developer/"

//Apple ID
#define APPID @"xxxxxxxxxxx"

//Text of about us
//Text of about us
#define ABOUT_US @"Greetings! Thank you for downloading FoodEase! We are the next step in food recipe apps. FoodEase is  not another application that lists hundreds of standard recipes! Instead, we let you  enter the names of ingredients – and in turn, the we display the possible dishes that can be made with them. Here are FoodEase Inc, we want to save you money while at the same time reducing food wastage.  \
If you have any questions, concerens, or requests please go\ to FOODEASEINC.com to contact us.\
"

//Text of Term & Condition
#define TERM_CONDITION @ "TERMS AND CONDITIONS \
----\
\
\OVERVIEW \
\
\
We reserve the right to refuse service to anyone for any reason at any time. \
You understand that your content (not including credit card information), may be transferred unencrypted and involve (a) transmissions over various networks; \
and (b) changes to conform and adapt to technical requirements of connecting networks or devices. \
You agree not to reproduce, duplicate, copy, sell, resell or exploit any portion of the Service, use of the Service, or access to the Service or any contact on the IOS application through which the service is provided, without express written permission by us.\
The headings used in this agreement are included for convenience only and will not limit or otherwise affect these Terms.\
\
\
SECTION 1 - CHANGES TO TERMS OF SERVICE\
\
You can review the most current version of the Terms of Service at any time at this page.\
\
We reserve the right, at our sole discretion, to update, change or replace any part of these Terms of Service by posting updates and changes to our IOS application. \
It is your responsibility to check our IOS application periodically for changes. Your continued use of or access to our IOS application or the Service following the posting of any changes to these Terms of Service constitutes acceptance of those changes.\
\
\
SECTION 2 - CONTACT INFORMATION\
\
Questions about the Terms of Service should be sent to us at FoodEaseInc@gmail.com."

//Text of Disclaimer
#define DISCLAIMER @"This mobile app is intended for informational purposes only."
// CHANGE Default Color
#define DEFAULT_COLOR @"E97E71"

//ADMOB VISIBILITY & ADMOB ID
#define ADS_VISIBILITY @"YES"
#define AdmobBannerAdsID  @"ca-app-pub-------/-------"
#define AdmobFullScreenAdsID @"ca-app-pub-------/-------"

#define iPhoneVersion ([[UIScreen mainScreen] bounds].size.height == 568 ? 5 : ([[UIScreen mainScreen] bounds].size.height == 480 ? 4 : ([[UIScreen mainScreen] bounds].size.height == 667 ? 6 : ([[UIScreen mainScreen] bounds].size.height == 736 ? 61 : 999))))

#define FONT @"Gill Sans"
#define LIGHT_FONT @"GillSans-Light"
#define SEMIBOLD_FONT @"GillSans-SemiBold"
#define BOLD_FONT @"GillSans-Bold"
@end
