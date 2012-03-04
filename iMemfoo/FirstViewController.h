//
//  FirstViewController.h
//  iMemfoo
//
//  Created by Arturo Yoshio Honzawa Puig on 3/2/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "Card.h"

@interface FirstViewController : UIViewController  <NSFetchedResultsControllerDelegate> {
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
    
    AVAudioPlayer *audioPlayer;

    UIButton *btnKana;
    UIButton *btnShowBack;
    UIButton *btnForget;
    UIButton *btnRemember;
    UILabel  *tvKanji;
    UITextView *tvMeaning;
    

    
    Card *currentCard;
    
    
}

@property (nonatomic, retain) AVAudioPlayer *audioPlayer;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) IBOutlet UIButton *btnKana;
@property (nonatomic, retain) IBOutlet UIButton *btnShowBack;
@property (nonatomic, retain) IBOutlet UIButton *btnForget;
@property (nonatomic, retain) IBOutlet UIButton *btnRemember;
@property (nonatomic, retain) IBOutlet UILabel *tvKanji;
@property (nonatomic, retain) IBOutlet UITextView *tvMeaning;

@property (nonatomic, retain) Card *currentCard;
-(void)loadNextCard;
-(IBAction)playAudio:(id)sender;

@end

