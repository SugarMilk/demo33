

#import <UIKit/UIKit.h>
#import "GFViewControllerProtocol.h"

@interface GFBasePopViewController : UIViewController

@property (nonatomic ,weak) id<GFViewControllerInterceptor> interceptor;
@property (nonatomic ,weak) id<GFViewControllerBackActionDelegate> backDelegate;

@property (nonatomic ,assign) BOOL isPresented;

//contentView
@property (nonatomic ,strong) UIView   *contentView;

//是否需要Logo
-(BOOL)needLogo;

//是否需要返回按钮
-(BOOL)needBackBtn;

@end
