
#import "GFBasePageViewController.h"
#import "GFLabelHelper.h"

static CGFloat kBar_Height = 54.0f;
static CGFloat kBackBtn_Width =18.0f;
static CGFloat kBackBtn_Height =30.0f;

@interface GFBasePageViewController ()

@property (nonatomic ,strong) UINavigationBar  *navigationBar;
@property (nonatomic ,strong) UIBarButtonItem  *backBarBtn;

@property (nonatomic ,strong)      UIButton    *hideKeyboardBtn;

@end

@implementation GFBasePageViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    self.view.bounds = [UIApplication sharedApplication].keyWindow.rootViewController.view.bounds;
    self.view.backgroundColor=[self colorInGlobalForKey:@"pageBackGroundColor"];
    [self.view addSubview:self.navigationBar];
    [self.view addSubview:self.contentView];
    _isPresented = NO;
    [super viewDidLoad];
}

-(void)viewWillLayoutSubviews{
    [_navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(kBar_Height);
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top);
    }];
    
    [_hideKeyboardBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.contentView.mas_width);
        make.height.mas_equalTo(self.contentView.mas_height);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.contentView.mas_left);
    }];
    
    [super viewWillLayoutSubviews];
}

-(void)viewDidAppear:(BOOL)animated{
    _isPresented = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
        if(self.backDelegate && [self.backDelegate respondsToSelector:@selector(controllerBackAction:)]){
            [self.backDelegate takeBackAction:self];
        }
    }
    [self afterCloseController:self];
}

-(void)hideKeyBoard{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}


#pragma mark - getters and setters

-(UINavigationBar *)navigationBar{
    if(!_navigationBar){
        _navigationBar=[[UINavigationBar alloc] init];
        UIColor *navigationBarColor = [self colorInGlobalForKey:@"barBackGroundColor"];
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
        {
            _navigationBar.tintColor = navigationBarColor;
        } else
        {
            _navigationBar.barTintColor = navigationBarColor;
        }
        [_navigationBar pushNavigationItem:self.navigationItem animated:NO];
    }
    
    return _navigationBar;
}

-(UINavigationItem *)navigationItem{
    if(!_navigationItem){
        _navigationItem=[[UINavigationItem alloc] init];
        [_navigationItem setLeftBarButtonItem:self.backBarBtn];
        
    }
    return _navigationItem;
}

-(UIBarButtonItem *)backBarBtn{
    if(!_backBarBtn){
        UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setWidth:kBackBtn_Width];
        [backBtn setHeight:kBackBtn_Height];
        [backBtn setImage:[self imageInGlobalForKey:@"page_back"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _backBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
    return _backBarBtn;
}

-(UIView *)contentView{
    if(!_contentView){
//        _contentView=[[UIView alloc] initWithFrame:CGRectMake(kMarginZero, kBar_Height, [BJVCMediator defaultMediator].rootViewController.view.bounds.size.width,  [BJVCMediator defaultMediator].rootViewController.view.bounds.size.height-kBar_Height)];
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

-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = [titleStr copy];
    [self.navigationItem setTitleView:[GFLabelHelper labelWithText:titleStr fontSize:FONT_SIZE_20 fontColor:[self colorInGlobalForKey:@"barTitleColor"]]];
}

@end
