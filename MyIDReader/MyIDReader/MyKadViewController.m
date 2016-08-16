//
//  MyKadViewController.m
//  MyIDReader
//
//  Created by Jerry on 3/13/13.
//  Copyright (c) 2013 SecureMetric Technology Sdn. Bhd. All rights reserved.
//

#import "MyKadViewController.h"
#import <MyID/MYKAD.h>

@implementation MyKadViewController


@synthesize tableHeaderView;
@synthesize lblHeaderICNo;
@synthesize lblHeaderName;
@synthesize imgHeaderPhoto;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style data:(MYKAD*) myKadDataOrNil photo:(UIImage *)photoOrNil
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        mykadData = [myKadDataOrNil retain];
        mykadPhoto = [photoOrNil retain];
    }
    return self;
}


-(void) dealloc
{
    [mykadPhoto release];
    [mykadData release];    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(tableHeaderView == nil)
    {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            [[NSBundle mainBundle] loadNibNamed:@"MyKadHeader_iPhone" owner:self options:nil];
        }
        else
        {
            [[NSBundle mainBundle] loadNibNamed:@"MyKadHeader_iPad" owner:self options:nil];
        }
        self.tableView.tableHeaderView = tableHeaderView;
        self.tableView.allowsSelectionDuringEditing = NO;
        self.tableView.backgroundView = nil;

        [tableHeaderView release];        
    }
    
    
    [self.tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MyKadBg.png"]] ];

    
    if(mykadData != nil )
    {
        self.lblHeaderICNo.text = mykadData.ICNo;
        self.lblHeaderName.text = mykadData.name;
    }
    else
    {
        self.lblHeaderICNo.text = @"";
        self.lblHeaderName.text = @"";
    }

    @try {
        self.imgHeaderPhoto.image = mykadPhoto;
    }
    @catch (NSException *exception) {
        self.imgHeaderPhoto.image = [UIImage imageNamed:@"nophoto"];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveCloseNotification:)
                                             name:@"MyIDCloseform"
                                             object:nil];
}

- (void) receiveCloseNotification:(NSNotification *) notification
{
    if ([[notification name] isEqualToString:@"MyIDCloseform"])
        [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
        case 1:
            return 2;
        case 2:
            return 2;
        case 3:
            return 5;
        case 4:
            return 6;
        default:
            break;
    }
    return 0;
}

- (NSString*) tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *strTitle=@"";
    
    return strTitle;
}

-(NSString*) getMyKadDataFromSection:(NSInteger)section Row:(NSInteger) row
{
    NSString* rowString=nil;
    NSDateFormatter *dateFormatter = nil;
    
    if(mykadData == nil)
        return @"";
    
    switch (section)
    {
        case 0:
            
            switch (row)
            {
                case 0:
                    rowString = mykadData.name;
                    break;
            	case 1:
                    rowString = mykadData.gmpcName;
                    break;
                case 2:
                    rowString = mykadData.kptName;
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
                    rowString = mykadData.ICNo;
                    break;
                case 1:
                    rowString = mykadData.oldICNo;
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
                    NSLog(@"%@", mykadData.DOB);
                    
                    dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease] ];
                    
                    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+08:00"]];
                    
                    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
                    
                    
                    rowString = [dateFormatter stringFromDate:mykadData.DOB];//DOB
                    
                    [dateFormatter release];
                    
                    
                    break;
                case 1:
                    rowString = mykadData.POB;
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
                    if ([mykadData.gender caseInsensitiveCompare:@"l"] == NSOrderedSame)
                        rowString = @"Male";
                    else
                        rowString = @"Female";

                    break;
                case 1:
                    rowString = mykadData.citizenship;
                    break;
                case 2:
                    dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease] ];
                    
                    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+08:00"]];
                    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
                    
                    
                    rowString = [dateFormatter stringFromDate:mykadData.issueDate];
                    
                    [dateFormatter release];
                    
                    break;
                case 3:
                    rowString = mykadData.race;
                    break;
                case 4:
                    rowString = mykadData.religion;
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
                    rowString = mykadData.address1;
                    break;
                case 1:
                    rowString = mykadData.address2;
                    break;
                case 2:
                    rowString = mykadData.address3;
                    break;
                case 3:
                    rowString = mykadData.postcode;
                    break;
                case 4:
                    rowString = mykadData.city;
                    break;
                case 5:
                    rowString = mykadData.state;
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
                    rowString = @"GMPC Name";
                    break;
                case 2:
                    rowString = @"KPT Name";
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
                    rowString = @"IC No";
                    break;
                case 1:
                    rowString = @"Old IC No";
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
        case 3:
            
            switch (row)
            {
                case 0:
                    rowString = @"Gender";
                    break;
                case 1:
                    rowString = @"Citizenship";
                    break;
                case 2:
                    rowString = @"Issue Date";
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
        case 4:
            
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
            
        default:
            rowString = @"";
            break;
    }

    
    return rowString;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyKadCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    

    cell.textLabel.font = [cell.textLabel.font fontWithSize:10];
    cell.textLabel.text = [self getRowStringNameFromSection:indexPath.section Row:indexPath.row];

    
    cell.detailTextLabel.text = [self getMyKadDataFromSection:indexPath.section Row:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryNone;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
  
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
    