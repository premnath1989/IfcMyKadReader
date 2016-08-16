//
//  MYKID.h
//  MyID
//
//  Created by Jerry on 2/15/13.
//  Copyright (c) 2013 SecureMetric Technology Sdn. Bhd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYKID : NSObject
{
    NSString* name; // 150 char
    NSString* ICNo; // 12 char
    NSString* birthCertNo; //15 char
    NSString* gender;
	NSString* citizenship; //18 char
	NSDate* registrationDate;
	NSString* POB;  //80 char
	NSDate* DOB;
	NSString* address1; //30char
	NSString* address2;
	NSString* address3;
	NSString* postcode; //6 char
	NSString* city; //24 char
	NSString* state; //30 char
    
    //Father Info
    NSString* fatherName;
	NSString* fatherICNo;
	NSString* fatherResidentType;
	NSString* fatherRace;
	NSString* fatherReligion;
    
    //Mother Info
    NSString* motherName;
    NSString* motherICNo;
    NSString* motherResidentType;
    NSString* motherRace;
    NSString* motherReligion;
}

@property (readonly, nonatomic, retain) NSString* name;
@property (readonly, nonatomic, retain) NSString* ICNo;
@property (readonly, nonatomic, retain) NSString* birthCertNo;
@property (readonly, nonatomic, retain) NSString* gender;
@property (readonly, nonatomic, retain) NSString* citizenship;
@property (readonly, nonatomic, retain) NSDate* registrationDate;
@property (readonly, nonatomic, retain) NSString* POB;
@property (readonly, nonatomic, retain) NSDate* DOB;
@property (readonly, nonatomic, retain) NSString* address1;
@property (readonly, nonatomic, retain) NSString* address2;
@property (readonly, nonatomic, retain) NSString* address3;
@property (readonly, nonatomic, retain) NSString* postcode;
@property (readonly, nonatomic, retain) NSString* city;
@property (readonly, nonatomic, retain) NSString* state;
@property (readonly, nonatomic, retain) NSString* fatherName;
@property (readonly, nonatomic, retain) NSString* fatherICNo;
@property (readonly, nonatomic, retain) NSString* fatherResidentType;
@property (readonly, nonatomic, retain) NSString* fatherRace;
@property (readonly, nonatomic, retain) NSString* fatherReligion;
@property (readonly, nonatomic, retain) NSString* motherName;
@property (readonly, nonatomic, retain) NSString* motherICNo;
@property (readonly, nonatomic, retain) NSString* motherResidentType;
@property (readonly, nonatomic, retain) NSString* motherRace;
@property (readonly, nonatomic, retain) NSString* motherReligion;
@end
