//
//  LodgingViewController.m
//  Wanderlust
//
//  Created by Sidwyn Koh on 5/1/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import "LodgingViewController.h"

@interface LodgingViewController ()

@end

@implementation LodgingViewController

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
    self.view.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
    UIScrollView *miniPhotoView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    miniPhotoView.contentSize = CGSizeMake(320*5, 80);
    UIImageView *firstImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    UIImageView *secondImage = [[UIImageView alloc] initWithFrame:CGRectMake(320*1, 0, 320, 240)];
    UIImageView *thirdImage = [[UIImageView alloc] initWithFrame:CGRectMake(320*2, 0, 320, 240)];
    UIImageView *fourthImage = [[UIImageView alloc] initWithFrame:CGRectMake(320*3, 0, 320, 240)];
    UIImageView *fifthImage = [[UIImageView alloc] initWithFrame:CGRectMake(320*4, 0, 320, 240)];
    firstImage.image = [UIImage imageNamed:@"lodging1.jpg"];
    secondImage.image = [UIImage imageNamed:@"lodging2.jpg"];
    thirdImage.image = [UIImage imageNamed:@"lodging3.jpg"];
    fourthImage.image = [UIImage imageNamed:@"lodging4.jpg"];
    fifthImage.image = [UIImage imageNamed:@"lodging5.jpg"];
    miniPhotoView.pagingEnabled = YES;
    [miniPhotoView addSubview:firstImage];
    [miniPhotoView addSubview:secondImage];
    [miniPhotoView addSubview:thirdImage];
    [miniPhotoView addSubview:fourthImage];
    [miniPhotoView addSubview:fifthImage];
    [self.view addSubview:miniPhotoView];
    miniPhotoView.delegate = self;
    miniPhotoView.showsHorizontalScrollIndicator = NO;
    self.title = @"Lodging";
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(10, 210, 300, 40)];
    pageControl.numberOfPages = 5;
    [self.view addSubview:pageControl];
    [self.view bringSubviewToFront:pageControl];
    
    UILabel *s1welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 245, 300, 40)];
    s1welcomeLabel.textAlignment = NSTextAlignmentLeft;
    s1welcomeLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:22];
    s1welcomeLabel.textColor = [UIColor whiteColor];
    s1welcomeLabel.text = @"Yosemite Lodge at the Falls";
    [self.view addSubview:s1welcomeLabel];
    
    UIImageView *placeImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 285, 10, 10)];
    placeImage.image = [UIImage imageNamed:@"place"];
    [self.view addSubview:placeImage];
    
    UILabel *venueLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 270, 300, 40)];
    venueLabel.textAlignment = NSTextAlignmentLeft;
    venueLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    venueLabel.textColor = [UIColor whiteColor];
    venueLabel.text = @"9006 Yosemite Lodge Drive, Yosemite, CA 95389";
    [self.view addSubview:venueLabel];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 300, 340)];
    descriptionLabel.textAlignment = NSTextAlignmentLeft;
    descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.textColor = [UIColor whiteColor];
    descriptionLabel.text = @"As the closest property to Yosemite Falls, Yosemite Lodge at the Falls is an idyllic spot for families, group retreats and visitors seeking the comforts of a hotel after an exciting day exploring the wilderness.";
    [self.view addSubview:descriptionLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidScroll:(UIScrollView *)sender {
    //    NSLog(@"scroll view scroll");
    CGFloat pageWidth = sender.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
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
