#import <UIKit/UIKit.h>
#import "YTPlayerView.h"
#import "Utility.h"
#import "Static.h"
#import "AppDelegate.h"
@interface VideoViewController : UIViewController<YTPlayerViewDelegate>{
    AppDelegate *appDelegate;
}
@property(nonatomic,retain)IBOutlet UIView *navBar;
@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;
@property(nonatomic,retain)NSString *strURL;
@property(nonatomic,retain)NSString *strRecipe;
@property(nonatomic,retain)IBOutlet UILabel *lblTitle;

@end
