//
//  MYKAD.h
//  MyID
//
//  Created by Jerry on 2/15/13.
//  Copyright (c) 2013 SecureMetric Technology Sdn. Bhd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYKAD : NSObject
{
    NSString *name;
    NSString *gmpcName;
    NSString *kptName;
    NSString *ICNo;
    NSString *oldICNo;
    NSDate *DOB;
    NSString *POB;
    NSString *gender;
    NSString* citizenship;
    NSDate* issueDate;
    NSString *race;
    NSString *religion;
    NSString *address1;
    NSString *address2;
    NSString *address3;
    NSString *postcode;
    NSString *city;
    NSString *state;
}
@property(readonly, nonatomic, retain) NSString* name;
@property(readonly, nonatomic, retain) NSString* gmpcName;
@property(readonly, nonatomic, retain) NSString* kptName;
@property(readonly, nonatomic, retain) NSString* ICNo;
@property(readonly, nonatomic, retain) NSString* oldICNo;
@property(readonly, nonatomic, retain) NSDate* DOB;
@property(readonly, nonatomic, retain) NSString* POB;
@property(readonly, nonatomic, retain) NSString* gender;
@property(readonly, nonatomic, retain) NSString* citizenship;
@property(readonly, nonatomic, retain) NSDate* issueDate;
@property(readonly, nonatomic, retain) NSString* race;
@property(readonly, nonatomic, retain) NSString* religion;
@property(readonly, nonatomic, retain) NSString* address1;
@property(readonly, nonatomic, retain) NSString* address2;
@property(readonly, nonatomic, retain) NSString* address3;
@property(readonly, nonatomic, retain) NSString* postcode;
@property(readonly, nonatomic, retain) NSString* city;
@property(readonly, nonatomic, retain) NSString* state;

@end
