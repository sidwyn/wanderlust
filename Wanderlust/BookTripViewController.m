//
//  BookTripViewController.m
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/17/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import "BookTripViewController.h"

@interface BookTripViewController ()

@end

@implementation BookTripViewController

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
    
    CGRect currentFrame = self.view.bounds;
    
    UILabel *s1welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 300, 40)];
    s1welcomeLabel.textAlignment = NSTextAlignmentLeft;
    s1welcomeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    s1welcomeLabel.textColor = UIColorFromRGB(0x2c3e50);
    s1welcomeLabel.text = @"Trip Confirmation";
    [self.view addSubview:s1welcomeLabel];
    
    UIImageView *calendarImage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 130, 60, 60)];
    calendarImage.image = [UIImage imageNamed:@"calendar"];
    [self.view addSubview:calendarImage];
    
    UILabel *calendarLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, 80, 50)];
    calendarLabel.textAlignment = NSTextAlignmentCenter;
    calendarLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    calendarLabel.textColor = UIColorFromRGB(0x2c3e50);
    calendarLabel.numberOfLines = 0;
    calendarLabel.text = @"April 16 - 27";
    [self.view addSubview:calendarLabel];
    
    UIImageView *placemarkImage = [[UIImageView alloc] initWithFrame:CGRectMake(100+30, 130, 60, 60)];
    placemarkImage.image = [UIImage imageNamed:@"placemark"];
    [self.view addSubview:placemarkImage];
    
    UILabel *placemarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 180, 80, 50)];
    placemarkLabel.textAlignment = NSTextAlignmentCenter;
    placemarkLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    placemarkLabel.textColor = UIColorFromRGB(0x2c3e50);
    placemarkLabel.numberOfLines = 0;
    placemarkLabel.text = @"Yosemite, CA";
    [self.view addSubview:placemarkLabel];
    
    UIImageView *peopleImage = [[UIImageView alloc] initWithFrame:CGRectMake(200+30, 130, 60, 60)];
    peopleImage.image = [UIImage imageNamed:@"man"];
    [self.view addSubview:peopleImage];
    
    UILabel *peopleLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 180, 80, 50)];
    peopleLabel.textAlignment = NSTextAlignmentCenter;
    peopleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    peopleLabel.textColor = UIColorFromRGB(0x2c3e50);
    peopleLabel.numberOfLines = 0;
    peopleLabel.text = @"2 Persons";
    [self.view addSubview:peopleLabel];
    
    KHFlatButton *paymentButton = [KHFlatButton buttonWithFrame:CGRectMake(0+20, 250, 280, 50) withTitle:@"ENTER PAYMENT INFO" backgroundColor:UIColorFromRGB(0x3cb7a3)];
    [paymentButton addTarget:self action:@selector(pushPaymentController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:paymentButton];
}

- (void)pushPaymentController {
    PaymentViewController *pvc = [[PaymentViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:pvc];
    pvc.delegate = self;
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)closePaymentController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
