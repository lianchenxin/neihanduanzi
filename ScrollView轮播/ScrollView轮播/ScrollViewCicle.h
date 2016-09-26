//
//  ScrollViewCicle.h
//  ScrollView轮播
//
//  Created by ma c on 15/9/10.
//  Copyright (c) 2015年 huhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollViewCicle : UIView

- (void)ciclePicture :(NSArray*)imageArray andFrame:(CGRect)frame andCurrentImage:(NSInteger)currentImageIndex;

@end
