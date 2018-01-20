/**
 * DH Bot is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *  
 * DH Bot is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *  
 * You should have received a copy of the GNU General Public License
 * along with DH Bot. If not, see 
 * https://github.com/unsaturated/DHBot/blob/master/LICENSE.
 */

#import "DHMDomainCheckViewController.h"
#import "DHMApi.h"
#import "DHMDomainCheckDataItem.h"
#import "DHMErrorData.h"
#import "DHMController.h"

@interface DHMDomainCheckViewController ()

@property (weak, nonatomic) IBOutlet UITextField *domainNameText;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation DHMDomainCheckViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark Command Message and Properties

-(DHMBaseCommand*) command
{
    if(_mCommand == nil)
        _mCommand = [[DHMApi sharedInstance] commandFromCommandName:DHM_DOM_REG_AVAIL];
    
    return _mCommand;
}

#pragma mark Standard ViewController Messages

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set the title so user can remember which command they're using
    self.title = self.command.commandName;
    
    AFNetworkReachabilityStatus start = [RKObjectManager sharedManager].HTTPClient.networkReachabilityStatus;
    [self updateUIforNetworkStatus:start];
    
    // Previous check is for immediate update - the following block is for *changes* to that status
    [[RKObjectManager sharedManager].HTTPClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         [self updateUIforNetworkStatus:status];
     }];
}

#pragma mark Refinements / Customizations

- (void)executeCommand
{    
    if(self.command != nil)
    {
        DHMApi* api = [DHMApi sharedInstance];
        
        RKResponseDescriptor* response = [DHMDomainCheckDataItem responseDescriptorForREST];
        
        if([self.command.acceptableParameters containsObject:@"domain"])
        {
            [self.command setParameterKey:@"domain" withValue:self.domainNameText.text];
        }
        
        NSURLRequest* req = [api buildRequestWithCommand:self.command];
        RKObjectRequestOperation* op = [[RKObjectRequestOperation alloc] initWithRequest:req responseDescriptors:@[response]];
        
        [op setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            id queryResult = [mappingResult firstObject];
            
            if([queryResult isKindOfClass:[DHMDomainCheckDataItem class]])
            {
                //DHMDomainCheckDataItem* first = ((DHMDomainCheckDataItem*)queryResult);

                // Success, so get the "actual" data embedded within the first result
                NSArray* apiDataArray = ((DHMDomainCheckDataItem*)queryResult).data;
                
                // Assign to result array
                self.commandResultArray = [NSMutableArray arrayWithArray:apiDataArray];
                
                [self processData:self.commandResultArray[0] withError:nil];
            }
            else if([queryResult isKindOfClass:[DHMErrorData class]])
            {
                // Error so cast as an error object
                DHMErrorData* error = ((DHMErrorData*)queryResult);
                
                // Clear result array
                self.commandResultArray = nil;
                
                [self processData:nil withError:error];
            }

        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            // Error stuff!
        }];
        
        [self updateUIforCommandRunning];
        [op start];
    }
}

- (IBAction)domainEditingChanged:(id)sender
{
    [self updateUIforValidationRetry];
}

- (IBAction)domainDidEnd:(id)sender
{
    // Stub
}

- (IBAction)checkRequested
{
    if([self testLocallyWithRegexFails])
        return;
    
    [self updateUIforValidating];
    [self executeCommand];
}

#pragma mark UI Refinement

-(void) processData:(DHMDomainCheckDataItem*)data withError:(DHMErrorData*)error
{
    if(data)
    {        
        // Update UI
        if(data.available.boolValue)
            [self updateUIforValidationSuccess];
        else
            [self updateUIforValidationFailure:NSLocalizedString(@"Domain unavailable", @"Error label indicating a domain name is unavailable")];
    }
    else if(error)
    {
        if([error.errorData isEqualToString:@"invalid_tld"])
            [self updateUIforValidationFailure:NSLocalizedString(@"Invalid top-level domain", @"Error label that top-level domain is invalid")];
        else if([error.errorData isEqualToString:@"invalid_domain"])
            [self updateUIforValidationFailure:NSLocalizedString(@"Invalid domain or sub-domain", @"Error label that domain or sub-domain is invalid")];
    }
}

-(BOOL) testLocallyWithRegexFails
{    
    NSError* errorCode = NULL;
    
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"^[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$" options:NSRegularExpressionCaseInsensitive error:&errorCode];
    
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:self.domainNameText.text
                                                        options:0
                                                          range:NSMakeRange(0, [self.domainNameText.text length])];
    
    if(numberOfMatches == 0)
    {
        [self updateUIforValidationFailure:NSLocalizedString(@"Fails local format test", @"Error label indicating a domain name format fails the local test")];
        return YES;
    }

    return NO;
}

-(void) updateUIforValidating
{
    // Entire view
    [self.view endEditing:YES];
    
    // Domain
    self.domainNameText.enabled = NO;
    
    // Error label
    self.errorLabel.hidden = YES;
    
    // Check button
    [self.checkButton setTitle:NSLocalizedString(@"Checking...", @"Button while the domain name is being checked") forState:UIControlStateNormal];
    [self.checkButton sizeToFit];
    [self.checkButton setEnabled:NO];
}

-(void) updateUIforValidationSuccess
{
    // Domain
    self.domainNameText.enabled = YES;
    
    // Check button
    [self.checkButton setTitle:NSLocalizedString(@"Check Availability", @"Button when domain name can be checked") forState:UIControlStateNormal];
    [self.checkButton sizeToFit];
    [self.checkButton setEnabled:YES];

    // Status pop-up
    [DHMController statusShow:NSLocalizedString(@"Domain available", @"Pop-up (good) message when the domain is available") forCommand:DHM_DOM_REG_AVAIL icon:kReportGoodStatus];
}

-(void) updateUIforValidationFailure
{
//    [self updateUIforValidationFailure:@"Not a valid API key"];
}

-(void) updateUIforValidationFailure:(NSString*) reason
{
    // Domain name
    self.domainNameText.enabled = YES;
    self.domainNameText.backgroundColor = [DHMController sharedInstance].errorColor;
    self.errorLabel.hidden = NO;
    self.errorLabel.text = reason;

    // Check button
    [self.checkButton setTitle:NSLocalizedString(@"Check Availability", @"Button when domain name can be checked") forState:UIControlStateNormal];
    [self.checkButton setEnabled:YES];
    [self.checkButton sizeToFit];

    // Status pop-up
    [DHMController statusShow:NSLocalizedString(@"Check error message", @"Pop-up error message indicating error label has details") forCommand:DHM_DOM_REG_AVAIL icon:kReportBadStatus];
}

-(void) updateUIforValidationRetry
{
    // TODO : Should probably check a BOOL to ensure this isn't set on every key press
    self.domainNameText.backgroundColor = nil;
    
    // Check button
    [self.checkButton setTitle:NSLocalizedString(@"Check Availability", @"Button when domain name can be checked") forState:UIControlStateNormal];
    [self.checkButton sizeToFit];
    
    // Error label
    self.errorLabel.hidden = YES;
    
    // Status pop-up
    [DHMController statusDismissForAction:DHM_DOM_REG_AVAIL];
}

@end
