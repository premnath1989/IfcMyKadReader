//
//  MyKadViewController.h
//  MyIDReader
//
//  Created by Jerry on 3/13/13.
//  Copyright (c) 2013 SecureMetric Technology Sdn. Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYKAD;

@interface MyKadViewController : UITableViewController
{
    UIView *tableHeaderView;
    UILabel *lblHeaderName;
    UILabel *lblHeaderICNo;
    UIImageView *imgHeaderPhoto;
    MYKAD *mykadData;
    UIImage *mykadPhoto;
}

@property (nonatomic, retain) IBOutlet UIView *tableHeaderView;
@property (nonatomic, retain) IBOutlet UILabel *lblHeaderName;
@property (nonatomic, retain) IBOutlet UILabel *lblHeaderICNo;
@property (nonatomic, retain) IBOutlet UIImageView *imgHeaderPhoto;

- (void) receiveCloseNotification:(NSNotification *) notification;
-(NSString*) getRowStringNameFromSection:(NSInteger)section Row:(NSInteger)row;
-(NSString*) getMyKadDataFromSection:(NSInteger)section Row:(NSInteger) row;

- (id)initWithStyle:(UITableViewStyle)style data:(MYKAD*) myKadDataOrNil photo:(UIImage*)photoOrNil;

@end
