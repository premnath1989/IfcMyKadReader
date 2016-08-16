//
//  CardStatusDelegate.h
//  MyID
//
//  Created by Jerry on 4/2/13.
//  Copyright (c) 2013 SecureMetric Technology Sdn. Bhd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyIDDelegate <NSObject>

-(void) onCardStatusChange: (uint16_t)status;

@end
