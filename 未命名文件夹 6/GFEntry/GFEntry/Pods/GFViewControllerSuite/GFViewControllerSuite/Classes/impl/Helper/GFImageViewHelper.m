
#import "GFImageViewHelper.h"
#import "UIImageView+WebCache.h"
#import "GFTheme.h"

@implementation GFImageViewHelper

+(UIImageView *)imageViewWithUrl:(NSString *)urlString{
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    return imageView;
}

+(UIImageView *)imageViewWithSexStr:(NSString *)sexStr{
    UIImageView *imageView = [[UIImageView alloc] init];
    if ([sexStr isEqualToString:@"0"]) {
        imageView.image=[GFImageViewHelper imageInGlobalForKey:@"headFemale"];
    }
    else{
        imageView.image=[GFImageViewHelper imageInGlobalForKey:@"headMale"];
    }
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    return imageView;
}

@end
