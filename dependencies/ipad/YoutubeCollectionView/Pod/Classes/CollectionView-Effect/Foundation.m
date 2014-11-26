//
//  Foundation.m
//  Layers
//
//  Created by djzhang on 11/25/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "Foundation.h"


@implementation NSAttributedString (custom)

+ (NSAttributedString *)attributedStringForTitleText:(NSString *)text {

   NSDictionary * titleAttributes =
    @{ NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Heavy" size:30],
     NSForegroundColorAttributeName : [UIColor whiteColor],
     NSShadowAttributeName : [NSShadow titleTextShadow],
     NSParagraphStyleAttributeName : [NSParagraphStyle justifiedParagraphStyle]
    };

   return [[NSAttributedString alloc] initWithString:text attributes:titleAttributes];
}


+ (NSAttributedString *)attributedStringForDescriptionText:(NSString *)text {

   NSDictionary * titleAttributes =
    @{ NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Medium" size:16],
     NSForegroundColorAttributeName : [UIColor whiteColor],
     NSBackgroundColorAttributeName : [UIColor clearColor],
     NSShadowAttributeName : [NSShadow descriptionTextShadow],
     NSParagraphStyleAttributeName : [NSParagraphStyle justifiedParagraphStyle]
    };

   return [[NSAttributedString alloc] initWithString:text attributes:titleAttributes];
}

@end


@implementation NSParagraphStyle (custom)
+ (NSParagraphStyle *)justifiedParagraphStyle {
   NSMutableParagraphStyle * style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
   [style setAlignment:NSTextAlignmentJustified];

   return style;
}

@end


@implementation NSShadow (custom)

+ (NSShadow *)titleTextShadow {
   NSShadow * shadow = [[NSShadow alloc] init];
   shadow.shadowColor = [UIColor colorWithHue:0
                                   saturation:0
                                   brightness:0
                                        alpha:0.3];
   shadow.shadowOffset = CGSizeMake(0, 2);
   shadow.shadowBlurRadius = 3.0;

   return shadow;
}


+ (NSShadow *)descriptionTextShadow {
   NSShadow * shadow = [[NSShadow alloc] init];
   shadow.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.3];
   shadow.shadowOffset = CGSizeMake(0, 1);
   shadow.shadowBlurRadius = 3.0;

   return shadow;
}

@end

