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

#import "DHMApiKeyModel.h"

// Version (Remember to update in the bundle properties!)
// ----------------------------------------------------------------------------
#define DHM_VERSION @"1.1.0"
// ----------------------------------------------------------------------------

// Keys for NSUserDefaults
// ----------------------------------------------------------------------------
#define NSUD_ONBOARDED_LAST_VERSION_KEY     @"com.unsaturated.dhbot.lastonboarded"
#define NSUD_LOW_POINTS_WARNINGS_ISSUED_KEY @"com.unsaturated.dhbot.lowpointswarned"
#define NSUD_PTS_SAVED_KEY                  @"com.unsaturated.dhbot.points"
// ----------------------------------------------------------------------------

// Keys for Settings Bundle
// ----------------------------------------------------------------------------
#define SETTING_FOR_VERSION       @"com.unsaturated.dhbot.settingforversion"
#define SETTING_FOR_PARTIAL_API   @"com.unsaturated.dhbot.settingforpartialapi"
#define PARTIAL_API_CHARS_TO_DISP 8
#define PARTIAL_API_CHAR          @"◦"
// ----------------------------------------------------------------------------

// Security
// ----------------------------------------------------------------------------
#define PTS_SALT_PART1   @"2n07@(0x2839^!{, bhd^& 9KEBVNksqpow.37^!*#"
#define PTS_SALT_PART2   @"3hiv029bk. 928y0mknz.<9237,ad038bvEHWOIj01"
// ----------------------------------------------------------------------------

// iTunesConnect Data and In-App Purchases
// ----------------------------------------------------------------------------
#define IAP_KEY_TIER1_PTS  @"com.unsaturated.dhbot.tier1points"  //  400
#define IAP_KEY_TIER2_PTS  @"com.unsaturated.dhbot.tier2points"  //  800
#define IAP_KEY_TIER3_PTS  @"com.unsaturated.dhbot.tier3points"  // 1400
#define IAP_KEY_TIER4_PTS  @"com.unsaturated.dhbot.tier4points"  // 2200
#define IAP_KEY_TIER5_PTS  @"com.unsaturated.dhbot.tier5points"  // 3000

#define PTS_ADDED_NOTIFICATION               @"PointsAddedNotification"
#define PTS_REMOVED_NOTIFICATION             @"PointsRemovedNotification"
#define IAP_PURCHASE_SUCCESS_NOTIFICATION    @"IAPPurchaseSuccessNotification"
#define IAP_PURCHASE_INPROG_NOTIFICATION     @"IAPPurchaseInProgNotification"
#define IAP_PURCHASE_FAILED_NOTIFICATION     @"IAPPurchaseFailedNotification"
#define IAP_PRODUCTS_LIST_NOTIFICATION       @"IAPProductListNotification"
#define IAP_PRODUCTS_LIST_ERROR_NOTIFICATION @"IAPProductListErrorNotification"
// ----------------------------------------------------------------------------

// History Events
// ----------------------------------------------------------------------------
#define HISTORY_ADDED_NOTIFICATION           @"HistoryAddedNotification"
#define HISTORY_CLEAR_NOTIFICATION           @"HistoryClearNotification"
// ----------------------------------------------------------------------------

/**
 Enumeration of pop-up report status.
 */
typedef enum
{
    kReportRunningStatus,
    kReportGoodStatus,
    kReportBadStatus
} DHMReportStatusIcon;

/**
 Enumeration of tabs used on main controller.
 */
typedef NS_ENUM(NSUInteger, MainTabEnum)
{
    KeysTab = 0,
    ServiceTag = 999,
    HistoryTab = 1
};

/* Handy macro section */

/**
 Creates a UIColor from an RGB value expressed as 0xAABBCC.
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 * Primary means of interacting with the DHMApi, view-controllers, and
 * the DHMAppDelegate (for process life cycle).
 */
@interface DHMController : NSObject <UIAlertViewDelegate>

/**
 Gets the instance of the DH Bot Controller.
 */
+(DHMController*) sharedInstance;

/**
 Converts a number value expressed in bytes to a human readable format (23 KB, 2 GB, etc).
 @param bytes bytes to express as human readable form
 @return Properly formatted string
 */
+(NSString*) convertBytesToReadableValue:(NSNumber*)bytes;

/**
 Reports status immediately using a non-modal view.
 @param text Short description to display
 @param cmd Command associated with display
 @param icon Icon to display (optional)
 */
+(void) statusShow:(NSString*)text forCommand:(NSString*)cmd icon:(DHMReportStatusIcon)icon;

/**
 Reporting status is dismissed for all actions.
 */
+(void) statusDismiss;

/**
 Reporting status is dismissed for a specific action.
 @param action Action to dismiss status
 */
+(void) statusDismissForAction:(NSString*)action;

/**
 Gets the X.Y version of the application.
 */
+(NSString*) appVersion;

/**
 Saves app settings to NSUserDefaults.
 */
-(void) saveAppSettings;

/**
 Restores app settings from NSUserDefaults.
 */
-(void) restoreAppSettings;

/**
 Reports a message to the user with a modal dialog.
 @param title text to display as title
 @param desc test to display as description
 */
-(void) reportMessage:(NSString*)title withDescription:(NSString*)desc;

/**
 Reports an error to the user with a modal dialog.
 */
-(void) reportError:(NSError*)error withOp:(RKObjectRequestOperation*) operation;

/**
 Reports a network error with a modal dialog box.
 */
-(void) reportNetworkError;

/**
 Segues from the selected API command to its primary view controller.
 @param name API name of the command
 @param vc view-controller that will perform the segue
 @param sender sender of the segue request
 */
-(void) segueFromApiCommand:(NSString*)name toViewController:(UIViewController*)vc withSender:(id)sender;

/**
 Gets the error color to use.
 */
@property (nonatomic, readonly, copy) UIColor* errorColor;

/**
 The list of user API keys as an array of DHMApiKeyModel objects.
 */
@property (nonatomic) NSMutableArray* userApiKeys;

/**
 The list of user API service tokens as an array of DHMApiKeyServiceModel objects.
 */
@property (nonatomic) NSMutableArray* userServiceTokens;

/**
 The list of user commands executed as an array of DHMCommandHistoryModel objects.
 */
@property (nonatomic) NSMutableArray* userCommandHistory;

/**
 Gets the currency formatter for the application.
 */
@property (nonatomic, readonly) NSNumberFormatter* currencyFormatter;

/**
 Gets the date formatter for the application.
 */
@property (nonatomic, readonly) NSDateFormatter* dateFormatter;

/**
 Gets or sets whether the API keys should only be partially displayed.
 */
@property (nonatomic, readwrite) BOOL partialDisplayApiKeys;

/**
 Gets the key model object from the userApiKeys property with the matching key string.
 @param key API key string
 @return Model API key data or nil if not found
 */
-(DHMApiKeyModel*) keyModelWithKeyString:(NSString*)key;

/**
 Gets the main window of the application.
 @return Main window view
 */
-(UIWindow*) mainWindow;

/**
 Gets whether the onboarding view-controller should be displayed.
 */
- (BOOL) onboardingShouldDisplay;

/**
 Gets the last version of the app in which onboarding was viewed.
 @return Last viewed version or nil if never viewed
 */
- (NSString*) onboardingLastDisplayedOnVersion;

/**
 Stores the app onboarding as viewed. This is persisted in NSUserDefaults.
 */
- (void) onboardingViewed;

/**
 Adds a command to the history record. Records are immediately saved to the device
 and the NSNotification sent to listeners.
 @param key API key used to execute
 @param cmd Command that was executed
 */
-(void) addToHistory:(NSString*)key command:(NSString*)cmd;

/**
 Clears the history for a given key or all history.
 @param key API key to clear from history (nil clears all)
 */
-(void) clearHistory:(NSString*)key;

@end
