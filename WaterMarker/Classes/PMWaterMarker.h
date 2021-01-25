//
//  PMWaterMarker.h
//  WaterMarker
//
//  Created by iPaperman on 2021/1/25.
//

#import <UIKit/UIKit.h>

@interface PMWaterMarker : UIView

/// 水印文字
@property (copy, nonatomic) NSString *text;
/// x 轴间距, default is 100
@property (assign, nonatomic) CGFloat dx;
/// y 轴间距, default is 80
@property (assign, nonatomic) CGFloat dy;

@end
