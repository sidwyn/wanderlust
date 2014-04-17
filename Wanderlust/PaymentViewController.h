//
//  PaymentViewController.h
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/17/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKView.h"

@protocol PaymentViewControllerDelegate;

@interface PaymentViewController : UIViewController <PKViewDelegate> {
    KHFlatButton *doneButton;
}

@property PKView* paymentView;
@property (nonatomic, assign) id <PaymentViewControllerDelegate> delegate;


@end


@protocol PaymentViewControllerDelegate
@required
- (void)closePaymentController:(BOOL)withPayment;
@end