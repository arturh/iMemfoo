//
//  Card.h
//  iMemfoo
//
//  Created by Arturo Yoshio Honzawa Puig on 3/3/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Card : NSManagedObject {
    
}

@property (nonatomic, retain) NSNumber * cardId;
@property (nonatomic, retain) NSString * kanji;
@property (nonatomic, retain) NSString * kana;
@property (nonatomic, retain) NSString * meaning;
@property (nonatomic, retain) NSNumber * correct;
@property (nonatomic, retain) NSDate * due;
@property (nonatomic, retain) NSDate * introduced;
@property (nonatomic, retain) NSString * audio;

@end
