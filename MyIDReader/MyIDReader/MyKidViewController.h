//
//  MyKidViewController.h
//  MyIDReader
//
//  Created by Jerry on 3/13/13.
//  Copyright (c) 2013 SecureMetric Technology Sdn. Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYKID;

@interface MyKidViewController : UITableViewController
{
    UIView *tableHeaderView;
    UILabel *lblHeaderName;
    UILabel *lblHeaderICNo;
    MYKID *mykidData;
}

@property (nonatomic, retain) IBOutlet UILabel *lblHeaderName;
@property (nonatomic, retain) IBOutlet UILabel *lblHeaderICNo;
@property (nonatomic, retain) IBOutlet UIView *tableHeaderView;

- (void) receiveCloseNotification:(NSNotification *) notification;
-(NSString*) getRowStringNameFromSection:(NSInteger)section Row:(NSInteger) row;
- (id)initWithStyle:(UITableViewStyle)style data:(MYKID*) myKidDataOrNil;

@end
