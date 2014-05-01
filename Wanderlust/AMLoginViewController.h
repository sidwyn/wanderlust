//
//  AMLoginViewController.h
//  LoginVideo
//
//  Created by AMarliac on 2014-04-02.
//  Copyright (c) 2014 AMarliac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <GPUImage/GPUImage.h>
#import "BlurView.h"
#import "MyTripsTableViewController.h"


@interface AMLoginViewController : UIViewController<UIGestureRecognizerDelegate, RNFrostedSidebarDelegate, MyTripsTableViewControllerDelegate, UITextFieldDelegate> {
    RNFrostedSidebar *callout;

}

@property (strong, nonatomic) BlurView *usernameView;
@property (strong, nonatomic) BlurView *passwordView;
@property (strong, nonatomic) UIView *sendButtonView;

@end
