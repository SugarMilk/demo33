//
//  GFDemoResourceHelper.m
//  Pods
//
//  Created by sdk－app11 on 17/1/18.
//
//

#import "GFDemoResourceHelper.h"

@implementation GFDemoResourceHelper

+(UIImage *)loadImageWithItemImageType:(GFDemoItemImageType)itemImageType{
    NSString *themeBundle = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"DemoResources.bundle"];
    NSString *imageFileName = nil;
    switch (itemImageType) {
        case    GFDemoItemImageTypeChangeDollar:
            imageFileName = @"changedollar.png";
            break;
        case    GFDemoItemImageTypeCheckLogin:
            imageFileName = @"check_login.png";
            break;
        case    GFDemoItemImageTypeDebug:
            imageFileName = @"debug.png";
            break;
        case    GFDemoItemImageTypeForum:
            imageFileName = @"forum.png";
            break;
        case    GFDemoItemImageTypeGameReccomand:
            imageFileName = @"game_reccomand.png";
            break;
        case    GFDemoItemImageTypeLoginIn:
            imageFileName = @"loginin.png";
            break;
        case    GFDemoItemImageTypeLoginOut:
            imageFileName = @"loginout.png";
            break;
        case    GFDemoItemImageTypePayment:
            imageFileName = @"payment.png";
            break;
        case    GFDemoItemImageTypeSearch:
            imageFileName = @"search.png";
            break;
        case    GFDemoItemImageTypeSwitchAccount:
            imageFileName = @"switch_account.png";
            break;
        case    GFDemoItemImageTypeUpdate:
            imageFileName = @"update.png";
            break;
        case    GFDemoItemImageTypeUserSign:
            imageFileName = @"user_sign.png";
            break;
        case    GFDemoItemImageTypeUserSpace:
            imageFileName = @"user_space.png";
            break;
        case    GFDemoItemImageTypeVoiceSign:
            imageFileName = @"voice_sign.png";
            break;
        case    GFDemoItemImageTypeWhoami:
            imageFileName = @"whoami.png";
            break;
        default:
            break;
    }
    
    NSString *imagePath = [themeBundle stringByAppendingPathComponent:imageFileName];
    UIImage *loadImage = [UIImage imageWithContentsOfFile:imagePath];
    return loadImage;
}

@end
