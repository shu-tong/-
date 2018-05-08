//
//  HeaderView.m
//  下拉放大图片
//
//  Created by 舒通 on 2018/5/8.
//  Copyright © 2018年 舒通. All rights reserved.
//

#define kDefaultHeaderFrame CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)


#import "HeaderView.h"
#import "UIImage+ImageEffects.h"

@interface HeaderView ()
@property (nonatomic, strong) UIImageView *imageView;//图片视图
@property (nonatomic, strong) UIScrollView *imageScrollView;//底部滚动视图
@property (nonatomic, strong) UIImageView *bluredImageView;//蒙板视图
@end

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark  < public method > -- shutong
- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset
{
    if (offset.y > 0) {
        NSLog(@"--- %f",1 / kDefaultHeaderFrame.size.height * offset.y * 2);
        self.bluredImageView.alpha = 1 / kDefaultHeaderFrame.size.height * offset.y * 2;
        self.clipsToBounds = YES;
    } else {
        CGFloat delta = 0.0f;
        CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        delta = fabs(MIN(0.0f, offset.y));
        rect.origin.y -= delta;
        rect.size.height += delta;
        self.imageScrollView.frame = rect;
        self.imageView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);//重新设置高度之后 相对布局就不需要了
        self.clipsToBounds = NO;
    }
    [self layoutIfNeeded];
}

#pragma mark  < private method > -- shutong
// 获取当前页面并生成图片
- (UIImage *)screenShotOfView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(kDefaultHeaderFrame.size, YES, 0.0);
    [self drawViewHierarchyInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)refreshBlurViewForNewImage
{
    UIImage *screenShot = [self screenShotOfView:self];
    screenShot = [screenShot applyBlurWithRadius:5 tintColor:[UIColor colorWithWhite:0.6 alpha:0.2] saturationDeltaFactor:1.0 maskImage:nil];
    self.bluredImageView.image = screenShot;
}

#pragma mark  < create UI > -- shutong
- (void)createUI
{
    self.backgroundColor = [UIColor redColor];
    self.imageScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:self.imageScrollView];
    
    self.imageView = [[UIImageView alloc]initWithFrame:self.imageScrollView.bounds];
//    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;//必须要有相对布局
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;//必须是这个模式
    self.imageView.image = [UIImage imageNamed:@"FriendsBackground"];
    [self.imageScrollView addSubview:self.imageView];
    
    self.bluredImageView = [[UIImageView alloc] initWithFrame:self.imageView.bounds];
//    self.bluredImageView.autoresizingMask = self.imageView.autoresizingMask;
    self.bluredImageView.alpha = 0.0f;
    [self.imageScrollView addSubview:self.bluredImageView];
//获取到当前视图的内容并生成图片
    [self refreshBlurViewForNewImage];
}


@end
