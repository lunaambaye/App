//
//  AppDelegate.h
//  Recipe
//
//  Created by R on 06/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import "CheckConnection.h"

@implementation CheckConnection

+(BOOL) checkInternetConnection
{
//    return YES;

    Reachability* reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
        
    if(remoteHostStatus != NotReachable) {
        return YES;
    }
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Unable to connect to the internet. Please check your network and try again.", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    [alertView show];
    return NO;
}

@end
