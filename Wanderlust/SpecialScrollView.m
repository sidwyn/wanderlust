//
//  SpecialScrollView.m
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/24/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import "SpecialScrollView.h"

@implementation SpecialScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delaysContentTouches = NO;
    }
    self.delaysContentTouches = NO;

    
    return self;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ([view isKindOfClass:UIButton.class]) {
        return YES;
    }
    
    return [super touchesShouldCancelInContentView:view];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
