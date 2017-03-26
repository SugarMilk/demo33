
#import "GFBasePopViewController.h"
#import "GFViewControllerMediator.h"

static CGFloat kPopViewEdge = 350.0f;
static CGFloat kPopViewCornerRadius = 3.0f;
static CGFloat kPopViewInnerMargin = 20.0f;

static CGFloat kLogoTopMargin =12.0f;
static CGFloat kBtnTopMargin =5.0f;
static CGFloat kBtnLeftMargin =5.0f;

static CGFloat kLeftMargin =10.0f;

static CGFloat kLogo_Width =104.0f;
static CGFloat kLogo_Height =46.0f;

@interface GFBasePopViewController ()
@property (nonatomic ,readwrite,strong) UIImageView *logoImageView;

@property (nonatomic ,readwrite,strong) UIButton    *backBtn;

//拦截游戏点击用,键盘收回，代替单击手势
@property (nonatomic ,strong)           UIButton    *hideKeyboardBtn;

@end

@implementation GFBasePopViewController

- (void)viewDidLoad {
    self.view.backgroundColor=[self colorInGlobalForKey:@"popViewBackGroundColor"];
    self.view.layer.cornerRadius=kPopViewCornerRadius*ratio;
    [self.view addSubview:self.contentView];
    CGFloat popViewEdge = MIN(self.view.width*ratio, self.view.height*ratio);
    popViewEdge = popViewEdge *ratio;
    popViewEdge = kPopViewEdge *ratio;
    popViewEdge = MIN(popViewEdge*ratio, popViewEdge*ratio);
    [self.view setFrame:CGRectMake(0, 0, popViewEdge-kPopViewInnerMargin*2, popViewEdge-kPopViewInnerMargin*2)];
    if([self needLogo]){
        [self.view addSubview:self.logoImageView];
    }
    if([self needBackBtn]){
        [self.view addSubview:self.backBtn];
    }
    
    _isPresented=NO;
    [super viewDidLoad];
}

- (void)viewWillLayoutSubviews{
    
    [_logoImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kLogo_Width*ratio);
        make.height.mas_equalTo(kLogo_Height*ratio);
        make.top.mas_equalTo(kLogoTopMargin*ratio);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        
    }];
    
    [_backBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kNormalBtn_Margin*ratio);
        make.height.mas_equalTo(kNormalBtn_Margin*ratio);
        make.top.mas_equalTo(kBtnTopMargin*ratio);
        make.left.mas_equalTo(kBtnLeftMargin*ratio);
    }];
    
    [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(self.view.mas_height);
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    
    [_hideKeyboardBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(self.view.mas_height);
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
    }];
    
    [super viewWillLayoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated{
    _isPresented=YES;
}


#pragma mark - method for interceptor

-(void)beforeCloseController:(UIViewController *)controller{
    if (self.interceptor && [self.interceptor respondsToSelector:@selector(beforeCloseController:)]) {
        [self.interceptor beforeCloseController:controller];
    }
}

-(void)afterCloseController:(UIViewController *)controller{
    if (self.interceptor && [self.interceptor respondsToSelector:@selector(afterCloseController:)]) {
        [self.interceptor afterCloseController:controller];
    }
}

-(BOOL)shouldCloseController:(UIViewController *)controller{
    if (self.interceptor && [self.interceptor respondsToSelector:@selector(shouldCloseController:)]) {
        return [self.interceptor shouldCloseController:controller];
    } else {
        return YES;
    }
}

#pragma mark - event response
-(void)backBtnAction{
    [self beforeCloseController:self];
    if([self shouldCloseController:self]){
        if(self.backDelegate && [self.backDelegate respondsToSelector:@selector(takeBackAction:)]){
            [self.backDelegate takeBackAction:self];
        }        
    }
    [self afterCloseController:self];
}

-(void)hideKeyBoard{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
#pragma mark - super method
-(BOOL)needLogo{
    return YES;
}

-(BOOL)needBackBtn{
    return YES;
}

#pragma mark - getters and setters
-(UIImageView *)logoImageView{
    if(!_logoImageView){
        _logoImageView=[[UIImageView alloc] init];
//        _logoImageView.image= [self imageInGlobalForKey:@"logoImage"];
        _logoImageView.image = [UIImage imageNamed:@"logo"];
        _logoImageView.contentMode = UIViewContentModeCenter;
    }
    return _logoImageView;
}

-(UIButton *)backBtn{
    if(!_backBtn){
        _backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        
//        [_backBtn setImage:[self imageInGlobalForKey:@"backBtn"] forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backBtn.imageView setContentMode:UIViewContentModeCenter];
        [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchDown];
    }
    return _backBtn;
}

-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        [_contentView addSubview:self.hideKeyboardBtn];
    }
    return _contentView;
}

-(UIButton *)hideKeyboardBtn{
    if (!_hideKeyboardBtn) {
        _hideKeyboardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hideKeyboardBtn addTarget:self action:@selector(hideKeyBoard) forControlEvents:UIControlEventTouchDown];
    }
    return _hideKeyboardBtn;
}
@end
