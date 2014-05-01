//
//  MyTripsTableViewController.m
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/17/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import "MyTripsTableViewController.h"
#import "MasterViewController.h"
#import "TripPageViewController.h"

@interface MyTripsTableViewController ()

@end

@implementation MyTripsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.title = @"My Trips";
    UIImage *image = [[UIImage imageNamed:@"menu.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(openMenu)];
    self.navigationItem.leftBarButtonItem = button;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(openMenu)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.navigationController.navigationBar addGestureRecognizer:swipeRight];
    
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects addObject:@{@"image":@"mytrips-yosemite.jpg", @"title":@"YOSEMITE"}];
    [_objects addObject:@{@"image":@"mytrips-carmel.jpg", @"title":@"CARMEL"}];
    [_objects addObject:@{@"image":@"mytrips-napa.jpg", @"title":@"NAPA VALLEY"}];
}

- (void)openMenu {
    NSArray *images = @[
                        [UIImage imageNamed:@"plus"],
                        [UIImage imageNamed:@"menu-car"]
                        ];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)] borderColors:nil labelStrings:@[@"Add Trip", @"My Trips"]];
    callout.delegate = self;
    [callout show];
}


- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    [sidebar dismissAnimated:YES];
    if (index == 0) {
        NSLog(@"Yep");
        MasterViewController *mtvc = [[MasterViewController alloc] init];
        mtvc.title = @"Pick Theme";
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:mtvc];
        [self.navigationController presentViewController:nc animated:NO completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 168;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = @"";
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *pictureView;
    if (![cell.contentView viewWithTag:100]) {
        pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 168)];
        pictureView.tag = 100;
        [cell.contentView addSubview:pictureView];
    }
    else {
        pictureView = (UIImageView *)[cell.contentView viewWithTag:100];
    }
    
    UILabel *themeLabel;
    if (![cell.contentView viewWithTag:101]) {
        themeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 320, 80)];
        themeLabel.textAlignment = NSTextAlignmentCenter;
        themeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:40];
        themeLabel.textColor = [UIColor whiteColor];
        themeLabel.tag = 101;
        [cell.contentView addSubview:themeLabel];
    }
    else {
        themeLabel = (UILabel *)[cell.contentView viewWithTag:101];
    }
    
    pictureView.image = [UIImage imageNamed:[[_objects objectAtIndex:indexPath.row] objectForKey:@"image"]];
    
    NSAttributedString *attributedString =
    [[NSAttributedString alloc]
     initWithString:[[_objects objectAtIndex:indexPath.row] objectForKey:@"title"]
     attributes:
     @{
       NSFontAttributeName : [themeLabel font],
       NSForegroundColorAttributeName : [themeLabel textColor],
       NSKernAttributeName : @(4.0f)
       }];
    themeLabel.attributedText = attributedString;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TripPageViewController *tbvc = [[TripPageViewController alloc] init];
    switch (indexPath.row) {
        case 0:
            tbvc.pageNumber = YOSEMITEPAGE;
            break;
        case 1:
            tbvc.pageNumber = CARMELPAGE;
            break;
        case 2:
            tbvc.pageNumber = NAPAVALLEY;
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:tbvc animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
