//
//  HeaderView.h
//  下拉放大图片
//
//  Created by 舒通 on 2018/5/8.
//  Copyright © 2018年 舒通. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView

/**
 重新布局图片视图

 @param offset offset description
 */
- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset;
@end
