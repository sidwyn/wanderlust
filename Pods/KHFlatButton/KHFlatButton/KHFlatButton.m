//
//  KHFlatButton.m
//
//  Created by Kyle Horn on 10/7/13.
//  Copyright (c) 2013 Kyle Horn. All rights reserved.
//

#import "KHFlatButton.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat const kDefaultCornerRadius = 3.0;
static CGFloat const kMinimumFontSize = 14.0;
static CGFloat const kHighlightDelta = 0.2;

@interface KHFlatButton()
@property (strong, nonatomic) UIColor *buttonColor;
@end

@implementation KHFlatButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self makeFlat:self withBackgroundColor:self.backgroundColor];
    self.layer.cornerRadius = kDefaultCornerRadius;
}

- (id)initWithFrame:(CGRect)frame withBackgroundColor:(UIColor*)backgroundColor
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeFlat:self withBackgroundColor:backgroundColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title backgroundColor:(UIColor*)backgroundColor cornerRadius:(CGFloat)radius;
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeFlat:self withBackgroundColor:backgroundColor];
        if (radius) {
            self.layer.cornerRadius = radius;
        }
        [self setTitle:title forState:UIControlStateNormal];
    }
    return self;
}

+ (KHFlatButton *)buttonWithFrame:(CGRect)frame withTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)radius
{
    KHFlatButton *btn = [[KHFlatButton alloc] initWithFrame:frame
                                                  withTitle:title
                                            backgroundColor:backgroundColor
                                               cornerRadius:radius];
    return btn;    
}

+ (KHFlatButton *)buttonWithFrame:(CGRect)frame withTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor
{
    KHFlatButton *btn = [[KHFlatButton alloc] initWithFrame:frame
                                                  withTitle:title
                                            backgroundColor:backgroundColor
                                               cornerRadius:kDefaultCornerRadius];
    return btn;
}

- (void)makeFlat:(KHFlatButton *)button withBackgroundColor:(UIColor*)backgroundColor
{
    self.buttonColor = backgroundColor;
    
    CGFloat fontSize = floorf(CGRectGetHeight(self.bounds) / 2.5);
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self setBackgroundColor:backgroundColor];
    [self addTarget:self action:@selector(wasPressed) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(endedPress) forControlEvents:UIControlEventTouchDragExit];
    [self addTarget:self action:@selector(endedPress) forControlEvents:UIControlEventTouchUpInside];
}

- (void)wasPressed
{
    CGFloat red, grn, blu, white, alpha = 0.0;
    [self.buttonColor getRed:&red green:&grn blue:&blu alpha:&alpha];
    [self.buttonColor getWhite:&white alpha:&alpha];
    self.backgroundColor = [UIColor colorWithRed:red - kHighlightDelta
                                           green:grn - kHighlightDelta
                                            blue:blu - kHighlightDelta
                                           alpha:alpha];
}

- (void)endedPress
{
    self.backgroundColor = self.buttonColor;
}


@end
