//
//  DetailViewController.h
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/3/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UITableViewController {
    NSMutableArray *_objects;

}

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
