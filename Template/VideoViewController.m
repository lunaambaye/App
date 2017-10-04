//
//  VideoViewController.m
//  Template
//
//  Created by R on 12/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()

@end

@implementation VideoViewController
@synthesize lblTitle,playerView,strURL,strRecipe;
- (void)viewDidLoad {
    [super viewDidLoad];
    ShowProgressView;
    appDelegate=[AppDelegate initAppDelegate];
    self.navBar.backgroundColor=[Utility getColor:appDelegate.strColor];
    lblTitle.text=strRecipe;
    self.playerView.delegate = self;
    
    NSDictionary *playerVars = @{
                                 @"playsinline" : @1,
                                 };
    [self.playerView loadWithVideoId:[self extractYoutubeIdFromLink:strURL] playerVars:playerVars];
}
- (NSString *)extractYoutubeIdFromLink:(NSString *)link {
    
    NSString *regexString = @"((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)";
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:nil];
    
    NSArray *array = [regExp matchesInString:link options:0 range:NSMakeRange(0,link.length)];
    if (array.count > 0) {
        NSTextCheckingResult *result = array.firstObject;
        return [link substringWithRange:result.range];
    }
    return nil;
}
- (void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state {
    switch (state) {
        case kYTPlayerStatePlaying:
            NSLog(@"Started playback");
            break;
        case kYTPlayerStatePaused:
            NSLog(@"Paused playback");
            break;
        default:
            break;
    }
}
- (void)playerViewDidBecomeReady:(YTPlayerView *)playerView{
    HideProgressView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
