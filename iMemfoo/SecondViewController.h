//
//  SecondViewController.h
//  iMemfoo
//
//  Created by Arturo Yoshio Honzawa Puig on 3/2/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController {
    UILabel *lbCardsLeft;
    UILabel *lbCardsLearned;
    UILabel *lbDueTomorrow;
    
    NSManagedObjectContext *managedObjectContext;
}

@property (retain, nonatomic) IBOutlet UILabel *lbCardsLeft;
@property (retain, nonatomic) IBOutlet UILabel *lbCardsLearned;
@property (retain, nonatomic) IBOutlet UILabel *lbDueTomorrow;

@property (retain, nonatomic)  NSManagedObjectContext *managedObjectContext;

-(NSUInteger)cardsLeft;
-(NSUInteger)cardsTotal;
-(NSUInteger)cardsLearned;
-(NSUInteger)cardsDueTomorrow;

@end

