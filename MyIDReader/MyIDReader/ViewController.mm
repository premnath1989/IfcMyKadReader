//
//  ViewController.m
//  MyIDReader
//
//  Created by Jerry on 3/10/13.
//  Copyright (c) 2013 SecureMetric Technology Sdn. Bhd. All rights reserved.
//

#import "ViewController.h"
#import "MyKadViewController.h"
#import "MyKidViewController.h"
#import <MyID/MYKID.h>
#import <MyID/MYKAD.h>



@implementation ViewController


-(void)dealloc
{
    [timerText invalidate];
    timerText = nil;
    
    if(idCard != nil)
    {
       [idCard release];
        idCard = nil;
    }
    [super dealloc];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor: [UIColor colorWithPatternImage:[UIImage imageNamed:@"MainBg.png"]]];
    
    [self showStatus:STATUS_NOREADER];
    
//    idCard = [[[MyID alloc] init] autorelease];
    idCard = [[MyID alloc] init];
    
    idCard.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showStatus: (uint16_t) status
{
    switch(status)
    {
        case STATUS_CARD_INSERTED:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MyIDCloseform" object:self] ;
            
            [timerText invalidate];
            timerText = nil;
            lblMsg.hidden =  FALSE;
            
            imgMyKad.hidden = TRUE;
            imgMyKid.hidden =  TRUE;
            lblMsg.text = @"Reading Smartcard...";
            

            [lblMsg setTextColor:[UIColor darkGrayColor]];
            activityProgress.hidden =  FALSE;
            [activityProgress startAnimating];
            
            break;
        case STATUS_NOREADER:
            if(!timerText.isValid)
                timerText = [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(blinkText:) userInfo:nil repeats:YES];

            lblMsg.text =  @"Insert Smartcard Reader";
            [lblMsg setTextColor:[UIColor colorWithRed:46.0/255 green:59.0/255 blue:146.0/255 alpha:1]];
            imgMyKad.hidden = FALSE;
            imgMyKid.hidden =  FALSE;
            
            [activityProgress stopAnimating];
            activityProgress.hidden =  TRUE;

            break;
            
        default:
            [timerText invalidate];
            timerText = nil;
            if(!timerText.isValid)
                timerText = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(blinkText:) userInfo:nil repeats:YES];

            imgMyKad.hidden = FALSE;
            imgMyKid.hidden =  FALSE;
            lblMsg.hidden =  FALSE;
            
            [activityProgress stopAnimating];
            activityProgress.hidden =  TRUE;
            
            [lblMsg setTextColor:[UIColor darkGrayColor]];
            
            lblMsg.text =  @"Insert Smartcard";
            
            break;
    }
    
    
}

-(void) blinkText:(NSTimer*)theTimer 
{
    if(lblMsg.hidden)
        lblMsg.hidden =  FALSE;
    else
        lblMsg.hidden =  TRUE;
}

-(uint16_t) readCard
{
    NSError *err=nil;
    
    Boolean isSuccess = false;
 
    NSArray * lstReader = [idCard listCardReadersAndReturnError:&err];
 
    if(lstReader == NULL || lstReader.count <= 0 )
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:@"Announcement" message:@"Unable to List reader" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        
        });
        return STATUS_NOREADER;
        
    }

    
    isSuccess = [idCard connectWithReaderName: [lstReader objectAtIndex:0] error:&err];
    if(!isSuccess)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:@"Announcement" message:@"Unable connect to reader" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
        });
        
        return STATUS_NOREADER;
    }
   
    NSObject *objData = [idCard readMyIDCardAndReturnError:&err];
    if(!objData)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
                    
            UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:@"Announcement" message:[NSString stringWithFormat:@"Failed reading card. \n%@", err] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
                    
        });
        
        [idCard disconnectReaderAndReturnError:&err];
        
        return STATUS_NOCARD;
    }
    
    if([objData isKindOfClass:[MYKID class]] )
    {
         MYKID *tmp = (MYKID*)objData;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            MyKidViewController *mykid = [[MyKidViewController alloc ]initWithStyle:UITableViewStyleGrouped data:tmp];
        

            [self presentViewController:mykid animated:YES completion:nil];
            [mykid release];
        });
        
        
    }
    else if([objData isKindOfClass:[MYKAD class]] )
    {
       MYKAD *tmp = (MYKAD*)objData;
        
        UIImage *photo =  [idCard readMyKADPhotoAndReturnError:&err];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            MyKadViewController *mykadView = [[MyKadViewController  alloc] initWithStyle:UITableViewStyleGrouped data:tmp photo:photo];
            [self presentViewController:mykadView animated:YES completion:nil];
            [mykadView release];
            
        });
    }
    
    
    
    [idCard disconnectReaderAndReturnError:&err];
    
   
    
    return 0;
    
    
}


-(void) onCardStatusChange:(uint16_t)status
{
    uint16_t ret;
    
    if(status == STATUS_CARD_INSERTED)
    {
        [self showStatus:status];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            int ret;
            
            ret = [self readCard];
            if(ret != 0)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showStatus:ret];
                });
            }
            
        });
    }
    else
    {
        [self showStatus:status];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MyIDCloseform" object:self] ;
        
    }
}

@end
