//
//  MasterViewController.m
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/3/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "TripBrowseViewController.h"
#import "TutorialViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *backBBI = [[UIBarButtonItem alloc] initWithTitle:@"Theme" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backBBI;
    
    UIBarButtonItem *leftBBI = [[UIBarButtonItem alloc] initWithTitle:@"My Trips" style:UIBarButtonItemStylePlain target:self action:@selector(pushMyTripsController)];
    self.navigationItem.leftBarButtonItem = leftBBI;
    
    UIBarButtonItem *rightBBI = [[UIBarButtonItem alloc] initWithTitle:@"Skip" style:UIBarButtonItemStylePlain target:self action:@selector(skip)];
//    self.navigationItem.rightBarButtonItem = rightBBI;
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TutorialViewController *tvc = (TutorialViewController *)[sb instantiateViewControllerWithIdentifier:@"TutorialViewController"];
    tvc.delegate = self;
//    [self presentViewController:tvc animated:NO completion:nil];
    
    self.title = @"Pick Theme";
    
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects addObject:@{@"image":@"theme-nature.jpg", @"title":@"Nature"}];
    [_objects addObject:@{@"image":@"theme-city.jpg", @"title":@"City"}];
    [_objects addObject:@{@"image":@"theme-adventure.jpg", @"title":@"Adventure"}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showTutorial {
    NSLog(@"Show tutorial");
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TutorialViewController *tvc = (TutorialViewController *)[sb instantiateViewControllerWithIdentifier:@"TutorialViewController"];
    tvc.delegate = self;
    [self presentViewController:tvc animated:YES completion:nil];
}

- (void)closeTutorial {
    NSLog(@"Close tutorial");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pushMyTripsController {
    MyTripsTableViewController *mtvc = [[MyTripsTableViewController alloc] init];
    mtvc.title = @"My Trips";
    mtvc.delegate = self;
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:mtvc];
    [nc.navigationBar setTintColor:UIColorFromRGB(0xbdc3c7)];
    [self.navigationController presentViewController:nc animated:YES completion:nil];
}

- (void)closeMyTripsController {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)skip {
    TripBrowseViewController *dvc = [[TripBrowseViewController alloc] init];
    [self.navigationController pushViewController:dvc animated:YES];
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
        themeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, 310, 40)];
        themeLabel.textAlignment = NSTextAlignmentRight;
        themeLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:30];
        themeLabel.textColor = [UIColor whiteColor];
        themeLabel.tag = 101;
        [cell.contentView addSubview:themeLabel];
    }
    else {
        themeLabel = (UILabel *)[cell.contentView viewWithTag:101];
    }
    
    pictureView.image = [UIImage imageNamed:[[_objects objectAtIndex:indexPath.row] objectForKey:@"image"]];
    themeLabel.text = [[_objects objectAtIndex:indexPath.row] objectForKey:@"title"];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
