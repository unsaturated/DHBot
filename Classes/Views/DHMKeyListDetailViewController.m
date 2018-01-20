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

#import "DHMKeyListDetailViewController.h"
#import "DHMKeyListTableViewController.h"
#import "DHMApi.h"
#import "DHMListApiCapabilitiesCommand.h"
#import "DHMApiCommandData.h"
#import "DHMController.h"

@interface DHMKeyListDetailViewController ()

#define DHM_ZA_VALIDATION_CA @"ValidationCommand"

@property (weak, nonatomic) IBOutlet UITextField *apiKeyTextField;
@property (weak, nonatomic) IBOutlet UILabel *apiKeyErrorTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIButton *validateButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end

@implementation DHMKeyListDetailViewController

@synthesize keyToSave;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    AFNetworkReachabilityStatus start = [RKObjectManager sharedManager].HTTPClient.networkReachabilityStatus;
    [self updateUIforNetworkStatus:start];
    
    // Previous check is for immediate update - the following block is for *changes* to that status
    [[RKObjectManager sharedManager].HTTPClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
    {
        [self updateUIforNetworkStatus:status];
    }];
}

#pragma mark Command Logic

-(void) validateKey
{
    if([self testIsKeyStoredLocally])
        return;
    
    // command
    DHMListApiCapabilitiesCommand* cmd = [DHMListApiCapabilitiesCommand new];
    
    DHMApi* api = [DHMApi sharedInstance];
    
    RKResponseDescriptor* response = [DHMApiCommandData responseDescriptorForREST];
    NSURLRequest* req = [api buildRequestWithCommand:cmd usingKey:self.apiKeyTextField.text];
    RKObjectRequestOperation* op = [[RKObjectRequestOperation alloc] initWithRequest:req responseDescriptors:@[response]];
    
    [op setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        id queryResult = [mappingResult firstObject];
        DHMApiCommandData* first = ((DHMApiCommandData*)queryResult);
        if([DHMBaseData isSuccess:first])
        {
            // Success, so get the "actual" data embedded within the first result
            NSArray* apiDataArray = ((DHMApiCommandData*)queryResult).data;
            
            // Now extract the commands from the DHMApiCommandData objects
            NSMutableArray *cmdArray = [NSMutableArray array];
            
            for (DHMApiCommandData* data in apiDataArray)
            {
                // Extract the command string based upon the object class
                [cmdArray addObject:data.cmd];
            }
            
            self.keyToSave = [DHMApiKeyModel entryWithKey:self.apiKeyTextField.text
                                              description:self.descriptionTextField.text
                                                 commands:[NSArray arrayWithArray:cmdArray]];
            [self updateUIforValidationSuccess];
        }
        else
        {
            // TODO : Handle error condition
            [self updateUIforValidationFailure];
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [[DHMController sharedInstance] reportError:error withOp:operation];
    }];
    
    [op start];
}

-(BOOL) testIsKeyStoredLocally
{
    // If the user entered something then go forward
    if([self.apiKeyTextField.text length] != 0)
    {
        DHMController* ctl = [DHMController sharedInstance];
        
        // Does the set of loaded keys contain this entry?
        if([ctl.userApiKeys containsObject:self.apiKeyTextField.text])
        {
            [self updateUIforValidationFailure:NSLocalizedString(@"You already added that key to DH Bot", @"Error label that the API key was already added")];
            return YES;
        }
    }
    
    return NO;
}


#pragma mark UI Action Handlers

- (IBAction)validatePressed:(UIButton *)sender
{
    [self updateUIforValidating];
    [self validateKey];
}

/**
 * Handle changes to value entered into text field.
 */
- (IBAction)apiKeyEditingChanged:(UITextField *)sender
{
    sender.text = [sender.text uppercaseString];
    self.validateButton.enabled = (sender.text.length >= DHM_API_KEY_LENGTH);
    [self updateUIforValidationRetry];
}

/** 
 * Handles 'Next' on keyboard.
 */
- (IBAction)apiKeyDidEndOnExit:(UITextField *)sender
{
    [self.descriptionTextField becomeFirstResponder];
}

/**
 * Stub
 */
- (IBAction)descriptionDidEndOnExit:(UITextField *)sender
{
    //[self.apiKeyTextField becomeFirstResponder];
    // TODO : Do key validation
}

/**
 * Dismisses the current modal viewcontroller.
 */
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender
{
    if(!self.isBeingDismissed)
    {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

/**
 * Adds the validated key to the local user defaults.
 */
- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender
{
    if(self.keyToSave)
    {
        // Add to the controller then archive via the class function
        [[DHMController sharedInstance].userApiKeys addObject:self.keyToSave];
        [DHMApiKeyModel saveApiKeysLocally:[DHMController sharedInstance].userApiKeys];
        if([self.apiKeyReceiver conformsToProtocol:@protocol(NewApiKeyReceiver)])
        {
            [self.apiKeyReceiver setupForNewApiKey];
        }
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark UI Updates For Validation

-(void) updateUIforValidating
{
    // Entire view
    [self.view endEditing:YES];
    
    // API key
    self.apiKeyTextField.enabled = NO;
    self.apiKeyErrorTextField.hidden = YES;
    
    // Validation button
    [self.validateButton setTitle:NSLocalizedString(@"Validating...", @"In-progress button while API key is validating") forState:UIControlStateNormal];
    [self.validateButton sizeToFit];
    [self.validateButton setEnabled:NO];
    
    // Status pop-up
    [DHMController statusShow:NSLocalizedString(@"Validating key...", @"In-progress pop-up while API key is validating")  forCommand:DHM_ZA_VALIDATION_CA icon:kReportRunningStatus];
}

-(void) updateUIforValidationSuccess
{
    // API key
    self.apiKeyTextField.enabled = YES;
    
    // Validation button
    [self.validateButton setTitle:NSLocalizedString(@"Validated", @"Button after API key is validated") forState:UIControlStateNormal];
    [self.validateButton sizeToFit];
    
    // Status pop-up
    [DHMController statusShow:NSLocalizedString(@"Validated", @"Pop-up after API key is validated") forCommand:DHM_ZA_VALIDATION_CA icon:kReportGoodStatus];
    
    // Accessibility
    UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, self.doneButton);
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, NSLocalizedString(@"Validated API key", @"Pop-up after API key is validated for accessibility"));
    
    // Enable Done
    self.doneButton.enabled = YES;
}

-(void) updateUIforValidationFailure
{
    [self updateUIforValidationFailure:NSLocalizedString(@"Not a valid API key", @"Error label when API key is not valid")];
}

-(void) updateUIforValidationFailure:(NSString*) reason
{
    // API key
    self.apiKeyTextField.enabled = YES;
    self.apiKeyErrorTextField.hidden = NO;
    self.apiKeyErrorTextField.text = reason;
    self.apiKeyTextField.backgroundColor = [DHMController sharedInstance].errorColor;
    
    // Validation button
    [self.validateButton setTitle:NSLocalizedString(@"Validate", @"Button to validate the key") forState:UIControlStateNormal];
    [self.validateButton setEnabled:YES];
    [self.validateButton sizeToFit];
    
    // Status pop-up
    [DHMController statusShow:NSLocalizedString(@"Validation failed", @"Pop-up error when validation has failed") forCommand:DHM_ZA_VALIDATION_CA icon:kReportBadStatus];
    
    // Accessibility
    UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, self.apiKeyErrorTextField);
    UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, NSLocalizedString(@"Validation failed for API key", @"Pop-up error when validation has failed"));
    
    // Done button
    self.doneButton.enabled = NO;
}

-(void) updateUIforValidationRetry
{
    // TODO : Should probably check a BOOL to ensure this isn't set on every key press
    self.apiKeyTextField.backgroundColor = nil;
    
    // Validation button
    [self.validateButton setTitle:NSLocalizedString(@"Validate", @"Button to validate the key") forState:UIControlStateNormal];
    [self.validateButton sizeToFit];
    
    // Status pop-up
    [DHMController statusDismissForAction:DHM_ZA_VALIDATION_CA];
    
    // Validation may have changed
    self.doneButton.enabled = NO;
}

-(void) updateUIforNetworkStatus:(AFNetworkReachabilityStatus)status
{
    if ( (status == AFNetworkReachabilityStatusNotReachable) || (status == AFNetworkReachabilityStatusUnknown) )
    {
        [self updateUIforNetworkProblem];
    }
    else if( (status == AFNetworkReachabilityStatusReachableViaWiFi) || (status == AFNetworkReachabilityStatusReachableViaWWAN))
    {
        [self updateUIforValidationRetry];
    }
}

-(void) updateUIforNetworkProblem
{
    // TODO : Should probably check a BOOL to ensure this isn't set on every key press
    self.apiKeyTextField.backgroundColor = nil;
    
    // Validation button should also provide network feedback
    [self.validateButton setTitle:NSLocalizedString(@"No Connection", @"Button (disabled) when there is no internet connection") forState:UIControlStateNormal];
    [self.validateButton setEnabled:NO];
    [self.validateButton sizeToFit];
    
    // Cancel status pop-up
    [DHMController statusDismissForAction:DHM_ZA_VALIDATION_CA];
    
    // Operation cannot proceed to DONE
    self.doneButton.enabled = NO;
    
    // Display a helpful network error message pop-up
    [[DHMController sharedInstance] reportNetworkError];
}

@end
