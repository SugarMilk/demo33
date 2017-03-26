
#import "GFLabelHelper.h"

@implementation GFLabelHelper

+(UILabel *)labelWithText:(NSString *)labelText fontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor{
    UILabel *label=[[UILabel alloc] init];
    label.textColor = fontColor;
    label.text = labelText;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.backgroundColor =[UIColor clearColor];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.textAlignment = NSTextAlignmentLeft;
    [label sizeToFit];
    CGSize size = CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [labelText sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    [label setWidth:labelsize.width];
    [label setHeight:labelsize.height];
    
    return label;
}

+(UILabel *)mulitLineLabelWithSize:(CGSize)size
                          labelText:(NSString *)labelText
                           fontSize:(CGFloat)fontSize
                          fontColor:(UIColor *)fontColor{
    UILabel *label= [[UILabel alloc] init];
    label.text = labelText;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = fontColor;
    label.numberOfLines = 0;
    label.backgroundColor =[UIColor clearColor];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.textAlignment = NSTextAlignmentLeft;
    CGSize labelSize = [labelText sizeWithFont:[UIFont systemFontOfSize:fontSize]
                     constrainedToSize:size
                         lineBreakMode:NSLineBreakByWordWrapping];
    [label setWidth:labelSize.width];
    [label setHeight:labelSize.height];
    
    return label;
}

@end
