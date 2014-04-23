//
//  BookTripViewController.h
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/17/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentViewController.h"

@interface BookTripViewController : UIViewController <PaymentViewControllerDelegate> {
    KHFlatButton *paymentButton;
    KHFlatButton *finalBookTripButton;
    UIImageView *checkmarkImage;
}
@property (nonatomic, strong) NSString *destination;

@end
