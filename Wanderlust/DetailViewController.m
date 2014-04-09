//
//  DetailViewController.m
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/3/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import "DetailViewController.h"
#import "TripBrowseViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    self.title = @"Pick No. of Travelers";
    
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects addObject:@{@"image":@"theme-nature.jpg", @"title":@"Solo"}];
    [_objects addObject:@{@"image":@"theme-city.jpg", @"title":@"Two"}];
    [_objects addObject:@{@"image":@"theme-adventure.jpg", @"title":@"Group"}];
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
    return 3;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TripBrowseViewController *tbvc = [[TripBrowseViewController alloc] init];
    [self.navigationController pushViewController:tbvc animated:YES];
}


@end
