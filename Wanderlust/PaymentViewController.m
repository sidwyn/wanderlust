//
//  PaymentViewController.m
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/17/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import "PaymentViewController.h"

@interface PaymentViewController ()

@end

@implementation PaymentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0xbdc3c7);
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(closeController)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    self.title = @"Payment Information";
    
    UILabel *peopleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 200, 50)];
    peopleLabel.textAlignment = NSTextAlignmentLeft;
    peopleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    peopleLabel.textColor = UIColorFromRGB(0x2c3e50);
    peopleLabel.numberOfLines = 0;
    peopleLabel.text = @"Credit Card Details";
    [self.view addSubview:peopleLabel];
    
    self.paymentView = [[PKView alloc] initWithFrame:CGRectMake(20, 120, 280, 55)];
    self.paymentView.delegate = self;
    [self.view addSubview:self.paymentView];
    
    doneButton = [KHFlatButton buttonWithFrame:CGRectMake(0+20, 190, 280, 50) withTitle:@"DONE" backgroundColor:[UIColor lightGrayColor]];
    [doneButton addTarget:self action:@selector(closeController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeController {
    NSLog(@"Closing payments");
    if (self.delegate) {
        [self.delegate closePaymentController];
    }
}
- (void) paymentView:(PKView*)paymentView withCard:(PKCard *)card isValid:(BOOL)valid
{
    NSLog(@"Card number: %@", card.number);
    NSLog(@"Card expiry: %lu/%lu", (unsigned long)card.expMonth, (unsigned long)card.expYear);
    NSLog(@"Card cvc: %@", card.cvc);
    NSLog(@"Address zip: %@", card.addressZip);
    
    [UIView transitionWithView:doneButton
                      duration:0.75
                       options:UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        doneButton.backgroundColor = UIColorFromRGB(0x3cb7a3);
                    }
                    completion:nil];
    
    // self.navigationItem.rightBarButtonItem.enabled = valid;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
