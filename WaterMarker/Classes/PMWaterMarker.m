//
//  PMWaterMarker.m
//  WaterMarker
//
//  Created by iPaperman on 2021/1/25.
//

#import "PMWaterMarker.h"

@implementation PMWaterMarker

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dx = 100;
        self.dy = 80;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    NSString * const text = self.text;
    if (!text || text.length == 0) {
        [super drawRect:rect];
        return;
    }
    CGFloat const dx = self.dx;
    CGFloat const dy = self.dy;
    
    NSMutableDictionary *textAttributes = [[NSMutableDictionary alloc] init];
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle alloc] init];
    textStyle.alignment = NSTextAlignmentCenter;
    [textAttributes setValue:textStyle forKey:NSParagraphStyleAttributeName];
    [textAttributes setValue:[UIFont systemFontOfSize:20.0] forKey:NSFontAttributeName];
    [textAttributes setValue:[UIColor colorWithWhite:0 alpha:0.2] forKey:NSForegroundColorAttributeName];

    CGRect textRect = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil];
    /**
     利用平铺原理

            ┼─[  ]─┼─[  ]─┼─[  ]─┼
            ⎴      ⎴      ⎴      ⎴
            ⎵      ⎵      ⎵      ⎵
            ┼─[  ]─┼─[  ]─┼─[  ]─┼
            ⎴      ⎴      ⎴      ⎴
            ⎵      ⎵      ⎵      ⎵
            ┼─[  ]─┼─[  ]─┼─[  ]─┼
            ⎴      ⎴      ⎴      ⎴
            ⎵      ⎵      ⎵      ⎵
            ┼─[  ]─┼─[  ]─┼─[  ]─┼
     */
    CGSize const drawSize = CGSizeMake(textRect.size.width+dx, textRect.size.height*2+dy*2);
    CGFloat const halfTextHeight = textRect.size.height/2;
    CGFloat const halfTextWidth = textRect.size.width/2;
    UIGraphicsBeginImageContextWithOptions(drawSize, NO, UIScreen.mainScreen.scale);
    //1
    [text drawInRect:(CGRect){drawSize.width/2-halfTextWidth, -halfTextHeight, textRect.size} withAttributes:textAttributes];
    //2
    [text drawInRect:(CGRect){-halfTextWidth, halfTextHeight+dy, textRect.size} withAttributes:textAttributes];
    //3
    [text drawInRect:(CGRect){halfTextWidth+dx, halfTextHeight+dy, textRect.size} withAttributes:textAttributes];
    //4
    [text drawInRect:(CGRect){drawSize.width/2-halfTextWidth, halfTextHeight*3+dy*2, textRect.size} withAttributes:textAttributes];
    UIImage *textImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    // 翻转坐标系
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, drawSize.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    // 旋转角度
    CGContextRotateCTM(context, M_PI_4/2);
    CGContextDrawTiledImage(context, (CGRect){CGPointZero, drawSize}, textImage.CGImage);
}

@end
