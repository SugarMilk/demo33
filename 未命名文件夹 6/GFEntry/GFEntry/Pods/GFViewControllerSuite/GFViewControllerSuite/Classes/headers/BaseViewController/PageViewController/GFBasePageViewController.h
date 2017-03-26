

#import <UIKit/UIKit.h>
#import "GFViewControllerProtocol.h"

@interface GFBasePageViewController : UIViewController


@property (nonatomic ,weak) id<GFViewControllerInterceptor> interceptor;
@property (nonatomic ,weak) id<GFViewControllerBackActionDelegate> backDelegate;

@property (nonatomic ,strong) UINavigationItem *navigationItem;

@property (nonatomic ,assign) BOOL isPresented;
//标题
@property (nonatomic ,strong) NSString *titleStr;
//contentView
@property (nonatomic ,strong) UIView   *contentView;

@end
