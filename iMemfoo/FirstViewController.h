//
//  FirstViewController.h
//  iMemfoo
//
//  Created by Arturo Yoshio Honzawa Puig on 3/2/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController {
    UIButton *btnKana;
    UIButton *btnShowBack;
    UIButton *btnForget;
    UIButton *btnRemember;
    UITextView *tvKanji;
    UITextView *tvMeaning;
}



@property (nonatomic, retain) IBOutlet UIButton *btnKana;
@property (nonatomic, retain) IBOutlet UIButton *btnShowBack;
@property (nonatomic, retain) IBOutlet UIButton *btnForget;
@property (nonatomic, retain) IBOutlet UIButton *btnRemember;
@property (nonatomic, retain) IBOutlet UITextView *tvKanji;
@property (nonatomic, retain) IBOutlet UITextView *tvMeaning;

@end

