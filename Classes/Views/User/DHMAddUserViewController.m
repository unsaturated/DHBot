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

#import "DHMAddUserViewController.h"
#import "DHMController.h"
#import "DHMApi.h"
#import "DHMAddUserDataItem.h"
#import "DHMErrorData.h"

@interface DHMAddUserViewController ()

#define MIN_LENGTH_USERNAME 4
#define MIN_LENGTH_PASSWORD 4
#define MIN_LENGTH_FULLNAME 4

#pragma mark Properties

// Top-level views
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *addUserView;

// User type
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

// User name, password, and full name
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UILabel *userNameError;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *passwordError;
@property (weak, nonatomic) IBOutlet UITextField *fullname;
@property (weak, nonatomic) IBOutlet UILabel *fullnameError;

// Shell type
@property (weak, nonatomic) IBOutlet UILabel *shellTypeLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *shellTypeSegment;

// Add button
@property (weak, nonatomic) IBOutlet UIButton *addButton;

// Currently selected field (for moving UIScrollView)
@property (weak, nonatomic) UIView* activeField;

// Data entry properties
@property (copy, nonatomic) NSString* selectedType;
@property (copy, nonatomic) NSString* selectedUserName;
@property (copy, nonatomic) NSString* selectedPassword;
@property (copy, nonatomic) NSString* selectedFullName;
@property (copy, nonatomic) NSString* selectedShell;
@property (copy, nonatomic) NSString* selectedServer;

@end

@implementation DHMAddUserViewController

#pragma mark Command Message and Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Select the FTP user by default
        self.segmentControl.selectedSegmentIndex = 0;
    }
    return self;
}

-(DHMBaseCommand*) command
{
    if(_mCommand == nil)
        _mCommand = [[DHMApi sharedInstance] commandFromCommandName:DHM_USER_ADD];
    
    return _mCommand;
}

- (void)viewDidLoad
{
    // Ensure the label itself has focus rather than the text field because the
    // user should see the section (label) name for proper context
    self.activeField = self.userName;
    
    [self registerForKeyboardNotifications];
    
    NSDictionary *viewsDictionary;
    
    viewsDictionary = @{
                        @"addUserView": self.addUserView,
                        @"scrollView": self.scrollView
                        };
    
    // Set the translatesAutoresizingMaskIntoConstraints to NO so that the views autoresizing mask is not translated into auto layout constraints.
    // NOTE : The UIScrollView doesn't seem to need this property
    //self.scrollView.translatesAutoresizingMaskIntoConstraints  = NO;
    // Refer to https://developer.apple.com/library/ios/technotes/tn2154/_index.html
    self.addUserView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[addUserView]|"
                                                                            options:kNilOptions
                                                                            metrics:nil
                                                                              views:viewsDictionary]];
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[addUserView]|"
                                                                            options:kNilOptions
                                                                            metrics:nil
                                                                              views:viewsDictionary]];
    
    
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

- (void)viewWillDisappear:(BOOL)animated
{
    [self unregisterForKeyboardNotifications];
    [super viewWillDisappear:animated];
}

#pragma mark Keyboard Handling

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

-(void) unregisterForKeyboardNotifications
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    // Retrieved from the below URLs with modifications to account for the navigation bar height
    // Refer to https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html
    // See also http://stackoverflow.com/questions/13161666/how-do-i-scroll-the-uiscrollview-when-the-keyboard-appears

    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // Account for nav bar and status bar
    float statusAndNavHeight = [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.toolbar.frame.size.height;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(statusAndNavHeight, 0.0, kbSize.height, 0.0);
    
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    CGRect aRect = self.addUserView.frame;
    aRect.size.height -= kbSize.height;
    CGPoint origin = self.activeField.frame.origin;
    if (!CGRectContainsPoint(aRect, origin) )
    {
        CGPoint scrollPoint = CGPointMake(0.0, self.activeField.frame.origin.y-(aRect.size.height));
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    float statusAndNavHeight = [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.toolbar.frame.size.height;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(statusAndNavHeight, 0.0, 0.0, 0.0);
    
    [UIView animateWithDuration:0.4 animations:^{
        self.scrollView.contentInset = contentInsets;
        
    }];
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark Command Execution

- (void)executeCommand
{
    if(self.command != nil)
    {
        //DHMApi* api = [DHMApi sharedInstance];
        
        /*
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
         */
    }
}


#pragma mark UI Action Handlers

- (IBAction)userTypeSegmentChanged:(UISegmentedControl *)sender
{
    if(sender.selectedSegmentIndex == 0)
    {
        // FTP
        self.shellTypeLabel.enabled = NO;
        self.shellTypeSegment.enabled = NO;
        self.shellTypeSegment.selected = NO;
        self.shellTypeSegment.selectedSegmentIndex = -1;
    }
    else if(sender.selectedSegmentIndex == 1)
    {
        // SFTP
        self.shellTypeLabel.enabled = NO;
        self.shellTypeSegment.enabled = NO;
        self.shellTypeSegment.selected = NO;
        self.shellTypeSegment.selectedSegmentIndex = -1;
    }
    else
    {
        // Shell
        self.shellTypeLabel.enabled = YES;
        self.shellTypeSegment.enabled = YES;
        self.shellTypeSegment.selected = YES;
        self.shellTypeSegment.selectedSegmentIndex = 0;
    }
}

- (IBAction)userNameDidBeginEdit:(UITextField *)sender
{
    self.activeField = sender;
}

- (IBAction)userNameEditingChanged:(UITextField *)sender
{
    [self updateUIforValidationRetry];
}

- (IBAction)userNameDidEndExit:(UITextField *)sender
{
    [self.password becomeFirstResponder];
}

- (IBAction)passwordEditingChanged:(UITextField *)sender
{
    [self updateUIforValidationRetry];
}

- (IBAction)passwordDidBeginEdit:(UITextField *)sender
{
    self.activeField = sender;
}

- (IBAction)passwordDidEndExit:(UITextField *)sender
{
    [self.fullname becomeFirstResponder];
    self.activeField = sender;
}

- (IBAction)fullnameEditingChanged:(UITextField *)sender
{
    [self updateUIforValidationRetry];
}

- (IBAction)fullnameBeginEditing:(UITextField *)sender
{
    self.activeField = sender;
}

- (IBAction)fullnameDidEndExit:(UITextField *)sender
{
    [self.view endEditing:YES];
    self.activeField = nil;
}

- (IBAction)shellTypeSegmentChanged:(UISegmentedControl *)sender
{
    // TODO : Update selected shell type
}

- (IBAction)addUserButtonPressed:(UIButton *)sender
{
    // Local tests first
    if([self testIsUsernameLocalFail])
        return;
    
    if([self testIsPasswordLocalFail])
        return;

    if([self testIsFullNameLocalFail])
        return;
    
    // Update the UI
    [self updateUIForValidating];
    
    // Execute the command
    [self executeCommand];
}

#pragma mark UI Updates for Validation

-(void) updateUIForValidating
{
    // Entire view
    [self.view endEditing:YES];
    
    // User type
    self.segmentControl.enabled = NO;
    
    // Username
    self.userName.enabled = NO;
    self.userNameError.hidden = YES;
    
    // Full name
    self.fullname.enabled = NO;
    self.fullnameError.hidden = YES;
    
    // Shell type
    self.shellTypeSegment.enabled = NO;
    
    // Validation button
    [self.addButton setTitle:NSLocalizedString(@"Adding...", @"In-progress button text while adding a user") forState:UIControlStateNormal];
    [self.addButton sizeToFit];
    [self.addButton setEnabled:NO];
    
    // Status pop-up
    [DHMController statusShow:NSLocalizedString(@"Adding user...", @"In-progress pop-up message while adding a user") forCommand:DHM_USER_ADD icon:kReportRunningStatus];
}

-(void) updateUIForValidationSuccess
{
    // TODO : Clear out all fields to their defaults because the same information shouldn't be submitted again
}

-(void) updateUIForValidationFailure
{
    
}

-(void) updateUIforValidationFailure:(UIView*)failedObject withReason:(NSString*) reason
{
    // Re-enable the UI objects
    self.segmentControl.enabled = YES;
    self.userName.enabled = YES;
    self.password.enabled = YES;
    self.fullname.enabled = YES;
    
    if(self.segmentControl.selectedSegmentIndex == 2)
    {
        self.shellTypeSegment.enabled = YES;
    }
    
    [self.addButton setTitle:NSLocalizedString(@"Add User", @"Button to add a user") forState:UIControlStateNormal];
    self.addButton.enabled = YES;

    // Failure is on username
    if(failedObject == self.userName)
    {
        self.userName.backgroundColor = [DHMController sharedInstance].errorColor;
        self.userNameError.hidden = NO;
        self.userNameError.text = reason;
    }
    else if(failedObject == self.password)
    {
        self.password.backgroundColor = [DHMController sharedInstance].errorColor;
        self.passwordError.hidden = NO;
        self.passwordError.text = reason;
    }
    else if(failedObject == self.fullname)
    {
        self.fullname.backgroundColor = [DHMController sharedInstance].errorColor;
        self.fullnameError.hidden = NO;
        self.fullnameError.text = reason;
    }
    
    // Status pop-up
    [DHMController statusShow:NSLocalizedString(@"Check error message", @"Pop-up message to indicate error messages should be checked") forCommand:DHM_USER_ADD icon:kReportBadStatus];
}

-(void) updateUIforValidationRetry
{
    // Clear out the error colors if there are any
    self.userName.backgroundColor = nil;
    self.password.backgroundColor = nil;
    self.fullname.backgroundColor = nil;
    
    [self.addButton setTitle:NSLocalizedString(@"Add User", @"Button to add a user") forState:UIControlStateNormal];
    self.addButton.enabled = YES;
}

#pragma mark Data Processing and Local Tests

-(void) processData:(DHMAddUserDataItem*)data withError:(DHMErrorData*)error
{
    /*
    if(data)
    {
        if(data.available.boolValue)
            [self updateUIforValidationSuccess];
        else
            [self updateUIforValidationFailure:@"Domain unavailable"];
    }
    else if(error)
    {
        if([error.errorData isEqualToString:@"invalid_tld"])
            [self updateUIforValidationFailure:@"Invalid top-level domain"];
        else if([error.errorData isEqualToString:@"invalid_domain"])
            [self updateUIforValidationFailure:@"Invalid domain or sub-domain"];
    }*/
}

-(BOOL) testIsUsernameLocalFail
{
    if(self.userName.text.length < MIN_LENGTH_USERNAME)
    {
        [self updateUIforValidationFailure:self.userName withReason:NSLocalizedString(@"Fails local length test", @"Label to indicate entry failed the local length test")];
        return YES;
    }
    
    return NO;
}

-(BOOL) testIsPasswordLocalFail
{
    if(self.password.text.length < MIN_LENGTH_PASSWORD)
    {
        [self updateUIforValidationFailure:self.password withReason:NSLocalizedString(@"Fails local length test", @"Label to indicate entry failed the local length test")];
        return YES;
    }
    
    return NO;
}

-(BOOL) testIsFullNameLocalFail
{
    if(self.fullname.text.length < MIN_LENGTH_FULLNAME)
    {
        [self updateUIforValidationFailure:self.fullname withReason:NSLocalizedString(@"Fails local length test", "Label to indicate entry failed the local length test")];
        return YES;
    }
    
    return NO;
}

#pragma mark Override Superclass Methods

-(void) updateUIforNetworkProblem
{
    // TODO : Should probably check a BOOL to ensure this isn't set on every key press
    self.userName.backgroundColor = nil;
    self.fullname.backgroundColor = nil;
    
    // Validation button should also provide network feedback
    [self.addButton setTitle:NSLocalizedString(@"No Connection", @"Pop-up message to indicate no internet connection") forState:UIControlStateNormal];
    [self.addButton setEnabled:NO];
    [self.addButton sizeToFit];
    
    // Call super since it uses a modal pop-up
    [super updateUIforNetworkProblem];
}

@end
