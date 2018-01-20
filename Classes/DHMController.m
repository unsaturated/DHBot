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

#import "DHMController.h"
#import "DHMApi.h"
#import "DHMApiKeyModel.h"
#import "DHMApiKeyServiceModel.h"
#import "DHMCommandHistoryModel.h"
#import "ZAActivityBar.h"

@implementation DHMController
{    
    BOOL _partialDisplayApiKeys;
}

-(void)saveAppSettings
{
    NSLog(@">>>> SAVING app settings to NSUserDefaults <<<<");
    NSLog(@"  Saving app version: %@", [self.class appVersion]);
    [[NSUserDefaults standardUserDefaults] setValue:[self.class appVersion] forKey:NSUD_ONBOARDED_LAST_VERSION_KEY];
    NSLog(@"  Saving version to settings: %@", DHM_VERSION);
    [[NSUserDefaults standardUserDefaults]
     setObject:[NSString stringWithFormat:@"Version %@", DHM_VERSION]
     forKey:SETTING_FOR_VERSION];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)restoreAppSettings
{
    NSLog(@">>>> RESTORING app settings from NSUserDefaults <<<<");
    _partialDisplayApiKeys = [[NSUserDefaults standardUserDefaults] boolForKey:SETTING_FOR_PARTIAL_API];
    NSLog(@"  Restored partial API key display: %s", _partialDisplayApiKeys ? "YES" : "NO");
}

- (DHMApiKeyModel*)keyModelWithKeyString:(NSString *)key
{
    NSParameterAssert(key != nil);
    
    if(self.userApiKeys == nil)
        return nil;
    
    if(self.userApiKeys.count == 0)
        return nil;
    
    // Create a predicate and find the results (it should only be one)
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"apiKey == %@", key];
    NSArray* results = [self.userApiKeys filteredArrayUsingPredicate:pred];
    
    if(results.count > 0)
        return (DHMApiKeyModel*)results[0];
    
    return nil;
}

- (UIWindow *)mainWindow
{
    UIWindow *frontWindow = [[[UIApplication sharedApplication] windows] lastObject];
    
    return frontWindow;
}

#pragma mark - Error and Message Reporting

- (void)reportMessage:(NSString *)title withDescription:(NSString *)desc
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:desc
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"OK", @"Short message to acknowledge, like OK")
                                          otherButtonTitles:nil];
    [alert show];
    
    NSLog(@"Message reported: %@", desc);
}

-(void) reportError:(NSError *)error withOp:(RKObjectRequestOperation *)operation
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Short word for error during generic request")
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"OK", @"Short message to acknowledge, like OK")
                                          otherButtonTitles:nil];
    [alert show];
    
    NSLog(@"Hit error: %@", error);
}

-(void) reportNetworkError
{
    // Cancel activity spinner
    [ZAActivityBar dismiss];
    
    // Now cancel any ongoing requests
    BOOL hasPendingRequests = [[RKObjectManager sharedManager].operationQueue operationCount] > 0;
    
    NSString* contextError = nil;
    if(hasPendingRequests)
        contextError = [NSString stringWithFormat:NSLocalizedString(@"DHBot needs an internet connection. Running commands are cancelled.", @"Error message to indicate an internet connection is needed and that running commands are now cancelled.")];
    else
        contextError = [NSString stringWithFormat:NSLocalizedString(@"DHBot needs an internet connection.", @"Error message that an internet connection is needed")];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Network Problem", @"Short string referring to a network problem")
                                                    message:contextError
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"OK", @"Short message to acknowledge, like OK")
                                          otherButtonTitles:nil];
    
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    alertView.delegate = nil;
    switch (buttonIndex)
    {
        case 0:
            // Do nothing since "OK" just dismisses the alert
            break;
        case 1:
            // Switch to the points tab
            [((UITabBarController*)self.mainWindow.rootViewController) setSelectedIndex:HistoryTab];
            break;
        default:
            break;
    }
}

-(void) segueFromApiCommand:(NSString *)name toViewController:(UIViewController *)vc withSender:(id)sender
{
    if([name isEqualToString:DHM_ACCT_GET_USAGE])
        [vc performSegueWithIdentifier:@"accountUsageSegue" sender:sender];
    else if([name isEqualToString:DHM_ACCT_GET_USER_USE])
        [vc performSegueWithIdentifier:@"userUsageSegue" sender:sender];
    else if([name isEqualToString:DHM_USER_LIST])
        [vc performSegueWithIdentifier:@"userListSegue" sender:sender];
    else if([name isEqualToString:DHM_ACCT_LIST_KEYS])
        [vc performSegueWithIdentifier:@"sshKeysSegue" sender:sender];
    else if([name isEqualToString:DHM_ACCT_GET_STATUS])
        [vc performSegueWithIdentifier:@"accountStatusSegue" sender:sender];
    else if([name isEqualToString:DHM_PS_LIST])
        [vc performSegueWithIdentifier:@"psListSegue" sender:sender];
    else if([name isEqualToString:DHM_SQL_LIST_DBS])
        [vc performSegueWithIdentifier:@"mysqlDbListSegue" sender:sender];
    else if([name isEqualToString:DHM_SQL_LIST_HOSTS])
        [vc performSegueWithIdentifier:@"mysqlHostnameListSegue" sender:sender];
    else if([name isEqualToString:DHM_SQL_LIST_USERS])
        [vc performSegueWithIdentifier:@"mysqlUserListSegue" sender:sender];
    else if([name isEqualToString:DHM_LISTSRV_LIST])
        [vc performSegueWithIdentifier:@"lstSrvListSegue" sender:sender];
    else if([name isEqualToString:DHM_DNS_LIST_RECS])
        [vc performSegueWithIdentifier:@"dnsListSegue" sender:sender];
    else if([name isEqualToString:DHM_MAIL_LIST_FILTERS])
        [vc performSegueWithIdentifier:@"listMailFilterSegue" sender:sender];
    else if([name isEqualToString:DHM_DOM_LIST_HOSTED])
        [vc performSegueWithIdentifier:@"listDomainsSegue" sender:sender];
    else if([name isEqualToString:DHM_DOM_LIST_REG])
        [vc performSegueWithIdentifier:@"listRegistrationsSegue" sender:sender];
    else if([name isEqualToString:DHM_API_LIST_ACCESS])
        [vc performSegueWithIdentifier:@"listAvailableApiSegue" sender:sender];
    else if([name isEqualToString:DHM_DOM_REG_AVAIL])
        [vc performSegueWithIdentifier:@"domainCheckSegue" sender:sender];
    else if([name isEqualToString:DHM_API_LIST_KEYS])
        [vc performSegueWithIdentifier:@"listApiKeysSegue" sender:sender];
    else if([name isEqualToString:DHM_USER_ADD])
        [vc performSegueWithIdentifier:@"addUserSegue" sender:sender];
    else if([name isEqualToString:DHM_JAB_LIST_USERS_NOPASS])
        [vc performSegueWithIdentifier:@"listJabberUsersSegue" sender:sender];
}

#pragma mark - Formatting and Presentation

@synthesize currencyFormatter = _currencyFormatter;

- (BOOL)partialDisplayApiKeys {
    // Get value directly from Settings bundle
    _partialDisplayApiKeys = [[NSUserDefaults standardUserDefaults] boolForKey:SETTING_FOR_PARTIAL_API];
    return _partialDisplayApiKeys;
}

-(UIColor*) errorColor
{
    // 235, 119, 109
    return [UIColor colorWithRed:0.92157f green:0.46667f blue:0.42745f alpha:1.0f];
}

+(NSString*) convertBytesToReadableValue:(NSNumber*)bytes
{
    return [NSByteCountFormatter stringFromByteCount:bytes.longLongValue countStyle:NSByteCountFormatterCountStyleFile];
}

+(void)statusShow:(NSString *)text forCommand:(NSString *)cmd icon:(DHMReportStatusIcon)icon
{
    switch (icon)
    {
        case kReportRunningStatus:
            [ZAActivityBar showWithStatus:text forAction:cmd];
            break;
        case kReportGoodStatus:
            [ZAActivityBar showImage:[UIImage imageNamed:@"green_check"] status:text duration:1.5f forAction:cmd];
            break;
        case kReportBadStatus:
            [ZAActivityBar showImage:[UIImage imageNamed:@"red_x"] status:text duration:2.3f forAction:cmd];
        default:
            break;
    }
}

+(void) statusDismissForAction:(NSString*)action
{
    [ZAActivityBar dismissForAction:action];
}

+ (void)statusDismiss
{
    [ZAActivityBar dismiss];
}

+ (NSString *)appVersion
{
    NSString* currentVersion = DHM_VERSION;
    return [currentVersion copy];
}

#pragma mark - Onboarding

- (BOOL) onboardingShouldDisplay
{
    NSString* lastOnboard = self.onboardingLastDisplayedOnVersion;
    NSString* currentVersion = [self.class appVersion];
    BOOL isVersionChanged = ![lastOnboard isEqualToString:currentVersion];
    
    // Co-opt the onboarding check and use it for upgrades.
    if(isVersionChanged)
    {
        // 1.0.0 -> 1.1.0
        if([lastOnboard isEqualToString:@"1.0.0"])
        {
            NSLog(@"++ Updated NSUserDefaults from 1.0.0 to 1.1.0");
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSUD_LOW_POINTS_WARNINGS_ISSUED_KEY];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSUD_PTS_SAVED_KEY];
        }
    }
    
    return isVersionChanged;
}

- (NSString*) onboardingLastDisplayedOnVersion
{
    NSString* lastOnboard = [[NSUserDefaults standardUserDefaults] stringForKey:NSUD_ONBOARDED_LAST_VERSION_KEY];
    return [lastOnboard copy];
}

- (void) onboardingViewed
{
    NSString *version = [self.class appVersion];
    [[NSUserDefaults standardUserDefaults] setValue:version forKey:NSUD_ONBOARDED_LAST_VERSION_KEY];
}

#pragma mark - History

- (void)addToHistory:(NSString *)key command:(NSString *)cmd
{
    DHMCommandHistoryModel* historyObj = [DHMCommandHistoryModel entryWithKey:key command:cmd date:[NSDate date]];
    [self.userCommandHistory insertObject:historyObj atIndex:0];
    [[NSNotificationCenter defaultCenter] postNotificationName:HISTORY_ADDED_NOTIFICATION object:historyObj];
    [DHMCommandHistoryModel saveApiHistoryLocally:self.userCommandHistory];
}

- (void)clearHistory:(NSString *)key
{
    if(self.userCommandHistory.count == 0)
        return;
    
    if(key == nil)
    {
        // Clear all history
        self.userCommandHistory = [NSMutableArray array];
    }
    else
    {
        // Keep all non-matches
        NSPredicate* pred = [NSPredicate predicateWithFormat:@"apiKey != %@", key];
        NSArray* cleanArray = [self.userCommandHistory filteredArrayUsingPredicate:pred];
        
        if(cleanArray.count > 0)
        {
            // Reassign
            self.userCommandHistory = [NSMutableArray arrayWithArray:cleanArray];
        }
        else
        {
            // Or clear
            self.userCommandHistory = [NSMutableArray array];
        }
    }
    
    // Save
    [DHMCommandHistoryModel saveApiHistoryLocally:self.userCommandHistory];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HISTORY_CLEAR_NOTIFICATION object:nil];
}

#pragma mark - Singleton Messages

+(DHMController*) sharedInstance
{
    static DHMController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DHMController alloc] init];
    });
    
    return sharedInstance;
}

-(id) init
{
    if( (self = [super init]) )
    {
        // Loading version...
        NSLog(@"####### Starting DH Bot version %@ #######", DHM_VERSION);
        
        // Set top-level application style
        [self mainWindow].tintColor = UIColorFromRGB(0x0066FF);
        
        // Number and currency formatters
        _currencyFormatter = [[NSNumberFormatter alloc] init];
        [_currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        
        NSLocale* localeUS = [NSLocale localeWithLocaleIdentifier:@"en_US"];
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [_dateFormatter setLocale:localeUS];
        
        // Initialize the API
        [DHMApi sharedInstance];
        
        // Load previous keys (if any) and assign empty array instance if none found
        self.userApiKeys = [NSMutableArray arrayWithArray:[DHMApiKeyModel loadApiKeysLocally]];
        if(!self.userApiKeys)
        {
            self.userApiKeys = [NSMutableArray array];
        }
        
        // Load previous service tokens (if any) and assign array if none found
        self.userServiceTokens = [NSMutableArray arrayWithArray:[DHMApiKeyServiceModel loadTokensLocally]];
        if(!self.userServiceTokens)
        {
            self.userServiceTokens = [NSMutableArray array];
        }
        
        // Load command history
        self.userCommandHistory = [NSMutableArray arrayWithArray:[DHMCommandHistoryModel loadApiHistoryLocally]];
        if(!self.userCommandHistory)
        {
            self.userCommandHistory = [NSMutableArray array];
        }
    }
    
    return self;
}

@end
