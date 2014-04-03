//
//  TutorialViewController.m
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/3/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView {
    [super loadView];
    NSLog(@"Hi");
    tutorialScrollView.contentSize = CGSizeMake(320*3, 568);
    UILabel *s1welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 300, 40)];
    s1welcomeLabel.textAlignment = NSTextAlignmentCenter;
    s1welcomeLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:32];
    s1welcomeLabel.textColor = [UIColor whiteColor];
    s1welcomeLabel.text = @"Welcome, traveller.";
    [tutorialScrollView addSubview:s1welcomeLabel];
    
    
    UILabel *s1welcomeLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, 300, 300)];
    s1welcomeLabel2.textAlignment = NSTextAlignmentCenter;
    s1welcomeLabel2.font = [UIFont fontWithName:@"Roboto-Thin" size:24];
    s1welcomeLabel2.textColor = [UIColor whiteColor];
    s1welcomeLabel2.numberOfLines = 3;
    s1welcomeLabel2.text = @"Wanderlust helps you\n plan weekend getaways\n with your friends.";
    [tutorialScrollView addSubview:s1welcomeLabel2];
    
    
    UILabel *s2enterLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10+320, 40, 300, 60)];
    s2enterLabel1.textAlignment = NSTextAlignmentCenter;
    s2enterLabel1.font = [UIFont fontWithName:@"Roboto-Thin" size:24];
    s2enterLabel1.textColor = [UIColor whiteColor];
    s2enterLabel1.text = @"1. Enter your preferences.";
    [tutorialScrollView addSubview:s2enterLabel1];
    
    UIImageView *s2pic1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"preferences"]];
    s2pic1.frame = CGRectMake(130+320, 100, 70, 70);
    [tutorialScrollView addSubview:s2pic1];
    
    UILabel *s2pickLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10+320, 200, 300, 60)];
    s2pickLabel2.textAlignment = NSTextAlignmentCenter;
    s2pickLabel2.font = [UIFont fontWithName:@"Roboto-Thin" size:24];
    s2pickLabel2.textColor = [UIColor whiteColor];
    s2pickLabel2.text = @"2. Pick a theme.";
    [tutorialScrollView addSubview:s2pickLabel2];
    
    UIImageView *s2pic2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"theme"]];
    s2pic2.frame = CGRectMake(130+320, 260, 70, 70);
    [tutorialScrollView addSubview:s2pic2];
    
    UILabel *s2bookLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(10+320, 360, 300, 60)];
    s2bookLabel3.textAlignment = NSTextAlignmentCenter;
    s2bookLabel3.font = [UIFont fontWithName:@"Roboto-Thin" size:24];
    s2bookLabel3.textColor = [UIColor whiteColor];
    s2bookLabel3.text = @"3. Book a trip with friends!";
    [tutorialScrollView addSubview:s2bookLabel3];
    
    UIImageView *s2pic3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"friends"]];
    s2pic3.frame = CGRectMake(130+320, 420, 70, 70);
    [tutorialScrollView addSubview:s2pic3];
    
    UILabel *s3readyLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10+640, 100, 300, 60)];
    s3readyLabel1.textAlignment = NSTextAlignmentCenter;
    s3readyLabel1.font = [UIFont fontWithName:@"Roboto-Regular" size:32];
    s3readyLabel1.textColor = [UIColor whiteColor];
    s3readyLabel1.text = @"Ready to travel?";
    [tutorialScrollView addSubview:s3readyLabel1];
    
    UIImageView *s3pic1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car"]];
    s3pic1.frame = CGRectMake(50+640, 130, 220, 220);
    [tutorialScrollView addSubview:s3pic1];
    
    UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectMake(60+640, 340, 200, 60)];
    [doneButton setTitle:@"I'M READY" forState:UIControlStateNormal];
    doneButton.titleLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:20];
    doneButton.titleLabel.textColor = [UIColor whiteColor];
    doneButton.layer.cornerRadius = 2;
    doneButton.layer.borderWidth = 1;
    doneButton.layer.borderColor = [UIColor cyanColor].CGColor;
    [tutorialScrollView addSubview:doneButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = sender.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    switch (page) {
        case 0:
            [self transitionImageView:@"EiffelNightLargeBlur.jpg"];
            break;
        case 1:
        case 2:
            [self transitionImageView:@"Background.jpg"];
            break;
    }
    pageControl.currentPage = page;
    
}

- (void)transitionImageView:(NSString *) newImageName {
    UIImage * toImage = [UIImage imageNamed:newImageName];
    [UIView transitionWithView:backgroundImageView
                      duration:5.0f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        backgroundImageView.image = toImage;
                    } completion:nil];
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
