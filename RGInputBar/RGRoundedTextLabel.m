//
//  RGRoundedTextLabel.m
//  RGInputBar
//
//  Created by Songming on 2019/3/24.
//

#import "RGRoundedTextLabel.h"

@interface RGRoundedTextLabel ()
@property (nonatomic, strong) CATextLayer *textLayer;
@end

@implementation RGRoundedTextLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    CATextLayer *textLayer = [[CATextLayer alloc] init];
    textLayer.contentsScale = UIScreen.mainScreen.scale;
    [self.layer addSublayer:textLayer];
    self.textLayer = textLayer;

    self.font = [UIFont systemFontOfSize:14];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat radius = self.bounds.size.height/2;
    self.layer.cornerRadius = radius;

    CGFloat margin = (self.bounds.size.height - self.font.lineHeight)/2;
    self.textLayer.frame = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(margin, radius, margin, radius));
}

- (void)setText:(NSString *)text {
    _text = text;
    self.textLayer.string = text;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.textLayer.foregroundColor = textColor.CGColor;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.textLayer.font = CGFontCreateWithFontName((CFStringRef)font.fontName);
    self.textLayer.fontSize = font.pointSize;
}

@end
