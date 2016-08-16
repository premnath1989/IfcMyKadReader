//
//  MyID.h
//  MyID
//
//  Created by Jerry on 2/14/13.
//  Copyright (c) 2013 SecureMetric Technology Sdn. Bhd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

@class MYKAD;
@class MYKID;
@protocol MyIDDelegate;

@interface MyID : NSObject
{
    id <MyIDDelegate> delegate;
}

@property (retain, nonatomic) id <MyIDDelegate> delegate;

-(NSArray*) listCardReadersAndReturnError:(NSError **)err;
-(bool) connectWithReaderName:(NSString*)readerName error:(NSError**)err;
-(NSObject*) readMyIDCardAndReturnError:(NSError**)err;
-(UIImage*) readMyKADPhotoAndReturnError:(NSError**)err;
-(bool) disconnectReaderAndReturnError:(NSError**)err;


@end

#define STATUS_NOREADER                 0x2001
#define STATUS_NOCARD                   0x2002
#define STATUS_CARD_INSERTED            0x2003
