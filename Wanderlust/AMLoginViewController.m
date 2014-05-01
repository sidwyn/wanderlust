//
//  AMLoginViewController.m
//  LoginVideo
//
//  Created by AMarliac on 2014-04-02.
//  Copyright (c) 2014 AMarliac. All rights reserved.
//

#import "AMLoginViewController.h"
#import "MasterViewController.h"

@interface AMLoginViewController ()
{
    AVPlayer * avPlayer;
    AVPlayerLayer *avPlayerLayer;
    CMTime time;
    
    //blur
    GPUImageiOSBlurFilter *_blurFilter;
    GPUImageBuffer *_videoBuffer;
    GPUImageMovie *_liveVideo;

    
    UITextField * usernameTf;
    UITextField * passwordTf;
}

@end

@implementation AMLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
#if TARGET_IPHONE_SIMULATOR
    UIImageView *bigView = [[UIImageView alloc] initWithFrame:self.view.frame];
    bigView.image = [UIImage imageNamed:@"napa2.jpg"];
    bigView.alpha = 0.6;
    bigView.contentMode =UIViewContentModeScaleAspectFill;
    [self.view addSubview:bigView];
    [self.view bringSubviewToFront:bigView];
    
    [self setViewItems];
//    [self.view sendSubviewToBack:bigView];
#endif
    
#if !TARGET_IPHONE_SIMULATOR
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];

    // ---------------------------AVPLAYER STUFF -------------------------------

    
    NSString * resource = [[NSBundle mainBundle] pathForResource:@"yosemitevideo2" ofType:@".mp4"];
    

    NSURL * urlPathOfVideo = [NSURL fileURLWithPath:resource];
    avPlayer = [AVPlayer playerWithURL:urlPathOfVideo];
    avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;

    avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:avPlayer];
    avPlayerLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view.layer addSublayer: avPlayerLayer];
    
    [avPlayer play];
    time = kCMTimeZero;
    
    //prevent music coming from other app to be stopped
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];

    
    // -------------------------------------------------------------------------

    
    //AVPlayer Notifications

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[avPlayer currentItem]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pauseVideo)
                                                 name:@"PauseBgVideo"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resumeVideo)
                                                 name:@"ResumeBgVideo"
                                               object:nil];
    
    
    
    
    // ---------------------------BLUR STUFF -------------------------------
    
    
    _blurFilter = [[GPUImageiOSBlurFilter alloc] init];
    //change the float value in order to change the blur effect
    _blurFilter.blurRadiusInPixels = 12.0f;
    _blurFilter.downsampling = 1.0f;
    _videoBuffer = [[GPUImageBuffer alloc] init];
    [_videoBuffer setBufferSize:1];
    
    // ---------------------------------------------------------------------

    
    
    //GESTURE - Dismiss the keyboard when tapped on the controller's view
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    tap.delegate = self;
    
    //start processing BLUR with background video
    
    [self setViewItems];
    [self procesBlurWithBackgroundVideoOnView:_usernameView];
    [self procesBlurWithBackgroundVideoOnView:_passwordView];
#endif
    
    UIImage *image = [[UIImage imageNamed:@"menu.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(openMenu)];
    self.navigationItem.leftBarButtonItem = button;
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(openMenu)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.navigationController.navigationBar addGestureRecognizer:swipeRight];

    self.title = @"Log In";
    
    [usernameTf performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:1.0];
}


- (void)openMenu {
    NSString *thirdName = @"Log In";
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"loggedIn"] boolValue]) {
        thirdName = @"Settings";
    }
    
    NSArray *images = @[
                        [UIImage imageNamed:@"plus"],
                        [UIImage imageNamed:@"menu-car"],
                        [UIImage imageNamed:@"menu-gear"]
                        ];
    
    callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)] borderColors:nil labelStrings:@[@"Add Trip", @"My Trips", thirdName]];
    callout.delegate = self;
    [callout show];
}

- (void)closeMenu {
    if (callout) {
        [callout dismissAnimated:YES];
    }
}


- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    [sidebar dismissAnimated:YES];
    
    if (index == 0) {
        MasterViewController *mvc = [[MasterViewController alloc] init];
        [self.navigationController pushViewController:mvc animated:NO];
    }
    else if (index == 1) {
        [self pushMyTripsController];
    }
    else if (index == 2) {
        AMLoginViewController *amlvc = [[AMLoginViewController alloc] init];
        [self.navigationController pushViewController:amlvc animated:NO];
    }
}


- (void)pushMyTripsController {
    MyTripsTableViewController *mtvc = [[MyTripsTableViewController alloc] init];
    mtvc.title = @"My Trips";
    mtvc.delegate = self;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:mtvc];
    [nc.navigationBar setTintColor:UIColorFromRGB(0xbdc3c7)];
    [self.navigationController presentViewController:nc animated:NO completion:nil];
}

#pragma mark - AVPlayer methods


- (void)pauseVideo
{
    [avPlayer pause];
    time = avPlayer.currentTime;
}


- (void)resumeVideo
{
    [avPlayer seekToTime:time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    [avPlayer play];
    [self procesBlurWithBackgroundVideoOnView:_usernameView];
    [self procesBlurWithBackgroundVideoOnView:_passwordView];
}


- (void)playerItemDidReachEnd:(NSNotification *)notification
{
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}


- (void) procesBlurWithBackgroundVideoOnView:(BlurView*)view
{

        _liveVideo = [[GPUImageMovie alloc] initWithPlayerItem:avPlayer.currentItem];
        
        [_liveVideo addTarget:_videoBuffer];
        [_videoBuffer addTarget:_blurFilter];
    NSLog(@"view is %@", view);
        [_blurFilter addTarget:view];
        [_liveVideo startProcessing];
}


- (void) setViewItems
{
    UIImageView * loginImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 90, 300, 30)];
    [loginImage setImage:[UIImage imageNamed:@"wanderlust_logo"]];
    loginImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:loginImage];
    
    _usernameView = [[BlurView alloc] initWithFrame:CGRectMake(35, 150, 250, 50)];
    _passwordView = [[BlurView alloc] initWithFrame:CGRectMake(35, 200, 250, 50)];
    
    _sendButtonView = [[UIView alloc] initWithFrame:CGRectMake(35, 270, 250, 50)];
    _sendButtonView.backgroundColor = [UIColor colorWithRed:0.925 green:0.941 blue:0.945 alpha:0.7];
    
    //BUTTON
    KHFlatButton *sendButton = [KHFlatButton buttonWithFrame:CGRectMake(0, 0, _sendButtonView.frame.size.width, _sendButtonView.frame.size.height) withTitle:@"LOG IN" backgroundColor:UIColorFromRGB(0x3cb7a3)];

    [sendButton addTarget:self action:@selector(doneLoggingIn) forControlEvents:UIControlEventTouchUpInside];
    [_sendButtonView addSubview:sendButton];
//    [sendButton addTarget:self action:@selector(setBgColorForButton:) forControlEvents:UIControlEventTouchDown];
//    [sendButton addTarget:self action:@selector(clearBgColorForButton:) forControlEvents:UIControlEventTouchDragExit];

    //USERNAME Text Field
    UIImageView * userImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 61, 50)];
    [userImage setImage:[UIImage imageNamed:@"user.png"]];
    
    [_usernameView addSubview:userImage];
    
    
    usernameTf = [[UITextField alloc]initWithFrame:CGRectMake(60, 10, 150, 30)];
    usernameTf.delegate = self;
    usernameTf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"USERNAME" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    usernameTf.returnKeyType = UIReturnKeyNext;
    usernameTf.textColor = [UIColor whiteColor];
    usernameTf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    usernameTf.autocorrectionType = UITextAutocorrectionTypeNo;
    [_usernameView addSubview:usernameTf];
    
    
    //PASSWORD Text Field
    UIImageView * lockImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 61, 50)];
    [lockImage setImage:[UIImage imageNamed:@"lock.png"]];
    [_passwordView addSubview:lockImage];
    
    passwordTf = [[UITextField alloc]initWithFrame:CGRectMake(60, 10, 150, 30)];
    passwordTf.delegate = self;
    passwordTf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"PASSWORD" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    passwordTf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passwordTf.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordTf.secureTextEntry = YES;
    passwordTf.returnKeyType = UIReturnKeyGo;
    passwordTf.textColor = [UIColor whiteColor];
    [_passwordView addSubview:passwordTf];
    
    
    [self.view addSubview:_usernameView];
    [self.view addSubview:_passwordView];
    [self.view addSubview:_sendButtonView];

}

- (void)doneLoggingIn {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"loggedIn"] boolValue] == YES) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"loggedIn"];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"loggedIn"];
    }
    [self sidebar:callout didTapItemAtIndex:0];
}

#pragma mark - Miscellaneous


-(void) dismissKeyboard
{
    [usernameTf resignFirstResponder];
    [passwordTf resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == usernameTf) {
        [_passwordView becomeFirstResponder];
    } else if (theTextField == passwordTf) {
        [self doneLoggingIn];
    }
    return YES;
}


#pragma mark - Life cycle methods


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
