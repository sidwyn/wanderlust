//
//  BackgroundButton.m
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/10/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import "BackgroundButton.h"

@implementation BackgroundButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.backgroundColor = [UIColor cyanColor];
        self.titleLabel.textColor = [UIColor blackColor];
    }
    else {
        self.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor whiteColor];
    }
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
