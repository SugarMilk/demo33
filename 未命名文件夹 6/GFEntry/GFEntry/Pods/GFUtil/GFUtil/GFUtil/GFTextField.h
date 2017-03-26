//
//  GFTextField.h
//  UITextFieldDemo
//
//  Created by 黄健 on 2017/3/19.
//  Copyright © 2017年 黄健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFTextField : UITextField

@property (nonatomic, assign) UIEdgeInsets placeholderInsets;
@property (nonatomic, assign) UIEdgeInsets textInsets;
@property (nonatomic, retain) UIColor * cursorColor;
@property (nonatomic, retain) UIColor * placeholderColor;
@property (nonatomic, assign) CGFloat placeholderFontSize;

@end

typedef NS_ENUM(NSUInteger, GFTextFieldStatusType) {
    GFTextFieldStatusTypeDidBeginEditing,
    GFTextFieldStatusTypeTextDidChange,
    GFTextFieldStatusTypeDidEndEditing = 0,
};

typedef NS_ENUM(NSUInteger, GFTextFieldButtonType) {
    GFTextFieldButtonTypeLeft,
    GFTextFieldButtonTypeRight,
};

typedef void(^GFTextFieldButtonActionBlock)(UIButton * button);
typedef void(^GFTextFieldStatusBlock)(GFTextField * textField, GFTextFieldStatusType textFieldStatusType);
typedef BOOL(^GFTextFieldShouldChangeBlock)(GFTextField * textField, NSRange range, NSString * string);

@interface GFTextFieldView : UIView

@property (nonatomic, readonly, strong) GFTextField * textField;
@property (nonatomic, readonly, strong) UIButton * leftButton;
@property (nonatomic, readonly, strong) UIButton * rightButton;
@property (nonatomic, assign) BOOL shouldBeEdited;

- (void)addWithButtonType:(GFTextFieldButtonType)type width:(CGFloat)width;

- (void)handleRightButtonAction:(GFTextFieldButtonActionBlock)buttonActionBlock;

- (void)handleTextFieldStatusBlock:(GFTextFieldStatusBlock)statusBlock
                 shouldChangeBlock:(GFTextFieldShouldChangeBlock)shouldChangBlock;

@end

@interface GFTextFieldValidator : NSObject



@end




