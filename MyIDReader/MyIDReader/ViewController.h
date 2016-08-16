//
//  ViewController.h
//  MyIDReader
//
//  Created by Jerry on 3/10/13.
//  Copyright (c) 2013 SecureMetric Technology Sdn. Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MyID/MyID.h>
#import <MyID/MyIDDelegate.h>



@interface ViewController : UIViewController <MyIDDelegate>
{
    IBOutlet UILabel *lblMsg;
    MyID *idCard;
    IBOutlet UIImageView *imgMyKad;
    IBOutlet UIImageView *imgMyKid;
    IBOutlet UIActivityIndicatorView * activityProgress;
    
    NSTimer *timerText;
}


-(void) setInsertCardView;
-(void) setReadingCardView;
-(uint16_t) readCard;
-(void) blinkText:(NSTimer*)theTimer;


@end
