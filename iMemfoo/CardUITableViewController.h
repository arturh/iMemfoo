//
//  CardUITableViewController.h
//  iMemfoo
//
//  Created by Artur Honzawa on 3/4/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface CardUITableViewController : UITableViewController {
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
    NSArray *cards;
}

@property (retain, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (retain, nonatomic)  NSArray *cards;

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;


@end


