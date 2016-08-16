//
//  MyKidViewController.m
//  MyIDReader
//
//  Created by Jerry on 3/13/13.
//  Copyright (c) 2013 SecureMetric Technology Sdn. Bhd. All rights reserved.
//

#import "MyKidViewController.h"
#import <MyID/MYKID.h>


@implementation MyKidViewController

@synthesize tableHeaderView;
@synthesize lblHeaderICNo;
@synthesize lblHeaderName;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)initWithStyle:(UITableViewStyle)style data:(MYKID*) myKidDataOrNil
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        mykidData = [myKidDataOrNil retain];
    }
    return self;
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [mykidData release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(tableHeaderView == nil)
    {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            [[NSBundle mainBundle] loadNibNamed:@"MyKidHeader_iPhone" owner:self options:nil];
        }
        else
        {
            [[NSBundle mainBundle] loadNibNamed:@"MyKidHeader_iPad" owner:self options:nil];
        }
        self.tableView.tableHeaderView = tableHeaderView;
        self.tableView.allowsSelectionDuringEditing = NO;
        self.tableView.backgroundView = nil;
        

    }
    
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MyKidBg.png"]] ];
    
    if(mykidData != nil )
    {
        self.lblHeaderICNo.text = mykidData.ICNo;
        self.lblHeaderName.text = mykidData.name;
    }
    else
    {
        self.lblHeaderICNo.text = @"";
        self.lblHeaderName.text = @"";
        
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveCloseNotification:)
                                                 name:@"MyIDCloseform"
                                               object:nil];


}

- (void) receiveCloseNotification:(NSNotification *) notification
{
    
    if ([[notification name] isEqualToString:@"MyIDCloseform"])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


-(NSString*) getRowStringNameFromSection:(NSInteger)section Row:(NSInteger) row
{
    NSString* rowString=nil;
    
    switch (section)
    {
        case 0:
            
            switch (row)
        {
            case 0:
                rowString = @"Name";
                break;
            case 1:
                rowString = @"IC No";
                break;
            case 2:
                rowString = @"Birth Cert No";
                break;
            default:
                rowString = @"";
                break;
        }
            
            break;
        case 1:
            
            switch (row)
        {
            case 0:
                rowString = @"DOB";
                break;
            case 1:
                rowString = @"POB";
                break;
                
            default:
                rowString = @"";
                break;
        }
            
            break;
        case 2:
            
            switch (row)
        {
            case 0:
                rowString = @"Gender";
                break;
            case 1:
                rowString = @"Citizenship";
                break;
            case 2:
                rowString = @"Registration Date";
                break;

            default:
                rowString = @"";
                break;
        }
            
            break;
        
        case 3:
            
            switch (row)
        {
            case 0:
                rowString = @"Address 1";
                break;
            case 1:
                rowString = @"Address 2";
                break;
            case 2:
                rowString = @"Address 3";
                break;
            case 3:
                rowString = @"Postcode";
                break;
            case 4:
                rowString = @"City";
                break;
            case 5:
                rowString = @"State";
                break;
            default:
                rowString = @"";
                break;
        }
            
            break;
            
        case 4:
        case 5:
            
            switch (row)
            {
                case 0:
                    rowString = @"Name";
                    break;
                case 1:
                    rowString = @"IC No";
                    break;
                case 2:
                    rowString = @"Resident Type";
                    break;
                case 3:
                    rowString = @"Race";
                    break;
                case 4:
                    rowString = @"Religion";
                    break;
                default:
                    rowString = @"";
                    break;
            }
            
            break;
        default:
            rowString = @"";
            break;
    }
    
    
    return rowString;
}


-(NSString*) getMyKidDataFromSection:(NSInteger)section Row:(NSInteger) row
{
    NSString* rowString=nil;
    NSDateFormatter *dateFormatter = nil;
    
    
    
    if(mykidData == nil)
        return @"";
    
    switch (section)
    {
        case 0:
            
            switch (row)
        {
            case 0:
                rowString = mykidData.name;
                break;
            case 1:
                rowString = mykidData.ICNo;
                break;
            case 2:
                rowString = mykidData.birthCertNo;
                break;
            default:
                rowString = @"";
                break;
        }
            
            break;
        
        case 1:
            
            switch (row)
        {
            case 0:
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease] ];
                [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+08:00"]];
                
                [dateFormatter setDateFormat:@"dd MMMM yyyy HH:mm:ss"];
                
                
                rowString = [dateFormatter stringFromDate:mykidData.DOB];//DOB
                
                [dateFormatter release];
                
                break;
            case 1:
                rowString = mykidData.POB;
                break;
            default:
                rowString = @"";
                break;
        }
            
            break;
        case 2:
            
            switch (row)
        {
            case 0:
                
                if ([mykidData.gender caseInsensitiveCompare:@"l"] == NSOrderedSame)
                    rowString = @"Male";
                else
                    rowString = @"Female";
                
                break;
            case 1:
                rowString = mykidData.citizenship;
                break;
            case 2:
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease] ];
                [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+08:00"]];
                [dateFormatter setDateFormat:@"dd MMMM yyyy"];
                
                
                rowString = [dateFormatter stringFromDate:mykidData.registrationDate];//DOB
                
                [dateFormatter release];
                
                break;
            default:
                rowString = @"";
                break;
        }
            
            break;
        case 3:
            
            switch (row)
        {
            case 0:
                rowString = mykidData.address1;
                break;
            case 1:
                rowString = mykidData.address2;
                break;
            case 2:
                rowString = mykidData.address3;
                break;
            case 3:
                rowString = mykidData.postcode;
                break;
            case 4:
                rowString = mykidData.city;
                break;
            case 5:
                rowString = mykidData.state;
                break;
            default:
                rowString = @"";
                break;
        }
            
            break;
            
        case 4:
            switch (row)
        {
                case 0:
                rowString = mykidData.fatherName;
                    break;
            case 1:
                rowString = mykidData.fatherICNo;
                break;
            case 2:
                rowString = mykidData.fatherResidentType;
                break;
            case 3:
                rowString = mykidData.fatherRace;
                break;
            case 4:
                rowString = mykidData.fatherReligion;
                break;
    
                default:
                    break;
            }
            break;
        case 5:
            switch (row)
        {
            case 0:
                rowString = mykidData.motherName;
                break;
            case 1:
                rowString = mykidData.motherICNo;
                break;
            case 2:
                rowString = mykidData.motherResidentType;
                break;
            case 3:
                rowString = mykidData.motherRace;
                break;
            case 4:
                rowString = mykidData.motherReligion;
                break;
                
            default:
                break;
        }
            break;
        
        default:
            rowString = @"";
            break;
    }
    
    
    return rowString;
}

- (NSString*) tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *strTitle=@"";
    
    if(section == 4)
        strTitle = @"Father";
    else if(section == 5)
        strTitle = @"Mother";
    
    return strTitle;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    switch(section)
    {
        case 0:
            return 3;
        case 1:
            return 2;
        case 2:
            return 3;
        case 3:
            return 6;
        case 4:
            return 5;
        case 5:
            return 5;
    }
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyKidCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
    }

    // Configure the cell...
    
    cell.textLabel.font = [cell.textLabel.font fontWithSize:10];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    
    cell.textLabel.text = [self getRowStringNameFromSection:indexPath.section Row:indexPath.row];
    cell.detailTextLabel.text = [self getMyKidDataFromSection:indexPath.section Row:indexPath.row];
    

    CGRect resultRect = cell.detailTextLabel.frame;
    resultRect.size.height = cell.textLabel.frame.size.height;
    [cell.detailTextLabel setFrame:resultRect];
    
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
