//
//  GFDemoChartView.m
//  Pods
//
//  Created by sdk－app11 on 17/1/18.
//
//

#import "GFDemoChartView.h"
#import "GFDemoItemView.h"
#import "GFDemoResourceHelper.h"
#import "UIView+LayoutMethods.h"
#import "GFLogger.h"

@interface GFDemoChartView ()

@property (nonatomic ,strong) NSMutableArray *itemsArray;
@property (nonatomic ,strong) NSMutableArray *rowSeparatorsArray;
@property (nonatomic ,strong) NSMutableArray *columnSeparatorsArray;

@end

@implementation GFDemoChartView

#pragma mark - life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.itemsArray = [NSMutableArray arrayWithCapacity:5];
        self.rowSeparatorsArray = [NSMutableArray arrayWithCapacity:5];
        self.columnSeparatorsArray = [NSMutableArray arrayWithCapacity:5];
    }
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setupSubViewsFrame];
    
    long rowCount = [self rowCountWithItemsCount:_itemsArray.count];
    CGFloat itemW = self.width / [self demoViewPerRowItemCount];
    CGFloat itemH = itemW * 1.1;
    UIColor *lineColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8];
    for (int i = 0; i < (rowCount + 1); i++) {
        UIView *rowSeparator = [[UIView alloc] init];
        rowSeparator.backgroundColor = lineColor;
        CGFloat w = self.width;
        CGFloat h = 1;
        CGFloat x = 0;
        CGFloat y = i * itemH;
        rowSeparator.frame = CGRectMake(x, y, w, h);
        [self addSubview:rowSeparator];
        [_rowSeparatorsArray addObject:rowSeparator];
    }
    
    for (int i = 0; i < ([self demoViewPerRowItemCount] + 1); i++) {
        UIView *columnSeparator = [[UIView alloc] init];
        CGFloat w = 1;
        CGFloat h = MAX(self.contentSize.height, self.height);
        CGFloat x = i * itemW;
        CGFloat y = 0;
        columnSeparator.frame = CGRectMake(x, y, w, h);
        columnSeparator.backgroundColor = lineColor;
        [self addSubview:columnSeparator];
        [_columnSeparatorsArray addObject:columnSeparator];
    }
    
}

#pragma mark - public method
-(void)addItemWithItemImageType:(GFDemoItemImageType)imageType btnContext:(NSString *)btnContext clickBlock:(GFDemoViewItemClickBlock)clickBlock{
    UIImage *itemImage = [GFDemoResourceHelper loadImageWithItemImageType:imageType];
    [self addItemWithIconImage:itemImage btnContext:btnContext clickBlock:clickBlock];
}

-(void)addItemWithIconImage:(UIImage *)iconImage btnContext:(NSString *)btnContext clickBlock:(GFDemoViewItemClickBlock)clickBlock{
    [_itemsArray addObject:[GFDemoItemView itemWithIconImage:iconImage btnContext:btnContext clickBlock:^(GFDemoItemView *view){
        NSLog(@"click item %@",view.btnContext);
        clickBlock();
    }]];
}

#pragma mark - private method

- (NSInteger)rowCountWithItemsCount:(NSInteger)count
{
    long rowCount = (count + [self demoViewPerRowItemCount] - 1) / [self demoViewPerRowItemCount];
    rowCount = (rowCount < 5) ? 5 : ++rowCount;
    return rowCount;
}

- (void)setupSubViewsFrame
{
    CGFloat itemW = self.width / [self demoViewPerRowItemCount];
    CGFloat itemH = itemW * 1.1;
    [_itemsArray enumerateObjectsUsingBlock:^(UIView *item, NSUInteger idx, BOOL *stop) {
        long rowIndex = idx / [self demoViewPerRowItemCount];
        long columnIndex = idx % [self demoViewPerRowItemCount];
        
        CGFloat x = itemW * columnIndex;
        CGFloat y = 0;
        if (idx < [self demoViewPerRowItemCount] * [self demoViewTopSectionRowCount]) {
            y = itemH * rowIndex;
        } else {
            y = itemH * (rowIndex + 1);
        }
        item.frame = CGRectMake(x, y, itemW, itemH);
        if (idx == (_itemsArray.count - 1)) {
            self.contentSize = CGSizeMake(0, item.height + item.y);
        }
        [self addSubview:item];
    }];
}


-(int)demoViewPerRowItemCount{
    return [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait ? 4 : 6;
}

-(int)demoViewTopSectionRowCount{
    return [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait ? 5 : 4;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self setFrame:self.bounds];
    
}

#pragma mark - rotation Notifies

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    NSLog(@"didRotateFromInterfaceOrientation %ld",(long)fromInterfaceOrientation);
    
}

#pragma mark - getters and setters
-(void)setAddRotateItem:(BOOL)addRotateItem{
    _addRotateItem = addRotateItem;
    if (addRotateItem) {
        [self addItemWithItemImageType:GFDemoItemImageTypeSwitchAccount btnContext:@"切换方向" clickBlock:^{
            if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
                SEL selector = NSSelectorFromString(@"setOrientation:");
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
                [invocation setSelector:selector];
                [invocation setTarget:[UIDevice currentDevice]];
                UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
                
                int val = interfaceOrientation == UIInterfaceOrientationPortrait ? UIInterfaceOrientationLandscapeRight : UIInterfaceOrientationPortrait;
                [invocation setArgument:&val atIndex:2];
                [invocation invoke];
            }
            
        }];
        [self setNeedsLayout];
    }
    
}

-(void)setAddLoggerItem:(BOOL)addLoggerItem{
    _addLoggerItem = addLoggerItem;
    if (addLoggerItem) {
        [self addItemWithItemImageType:GFDemoItemImageTypeDebug btnContext:@"日志" clickBlock:^{
            [GFLogger showLogPanel];
        }];
    }
}

@end
