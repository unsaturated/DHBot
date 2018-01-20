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

#import "DHMApi.h"
#import "RestKit/RestKit.h"
#import "DHMCommandCategory.h"

// Account
#import "DHMAccountDomainUsageCommand.h"
#import "DHMAccountStatusCommand.h"
#import "DHMAccountUserUsageCommand.h"
#import "DHMAccountSshKeysCommand.h"

// Announcement
#import "DHMListAnnounceListsCommand.h"
#import "DHMListAnnounceSubscribersCommand.h"
#import "DHMAddAnnounceSubscriberCommand.h"
#import "DHMRemoveAnnounceSubscriberCommand.h"
#import "DHMPostAnnounceCommand.h"

// API
#import "DHMListApiCapabilitiesCommand.h"
#import "DHMListApiKeysCommand.h"

// Domains
#import "DHMListDomainsCommand.h"
#import "DHMListRegistrationsCommand.h"
#import "DHMDomainCheckCommand.h"

// DNS
#import "DHMListDnsRecordsCommand.h"
#import "DHMAddDnsCommand.h"
#import "DHMRemoveDnsCommand.h"

// Jabber
#import "DHMListJabberUsersCommand.h"

// Mail
#import "DHMAddMailFilterCommand.h"
#import "DHMRemoveMailFilterCommand.h"
#import "DHMListMailFiltersCommand.h"

// MySQL
#import "DHMListMySqlDbCommand.h"
#import "DHMListMySqlHostnamesCommand.h"
#import "DHMAddMySqlHostnameCommand.h"
#import "DHMRemoveMySqlHostnameCommand.h"
#import "DHMAddMySqlUserCommand.h"
#import "DHMRemoveMySqlUserCommand.h"
#import "DHMListMySqlUsersCommand.h"

// Private Server
#import "DHMAddPsCommand.h"
#import "DHMListImagesPsCommand.h"
#import "DHMListPendingPsCommand.h"
#import "DHMListPsCommand.h"
#import "DHMListPsUsageCommand.h"
#import "DHMListRebootHistoryPsCommand.h"
#import "DHMListSettingsPsCommand.h"
#import "DHMListSizeHistoryPsCommand.h"
#import "DHMRebootPsCommand.h"
#import "DHMRemovePendingPsCommand.h"
#import "DHMRemovePsCommand.h"
#import "DHMSetSizePsCommand.h"
#import "DHMUpdateSettingsPsCommand.h"

// Rewards
#import "DHMAddRewardPromoCommand.h"
#import "DHMDisableRewardPromoCommand.h"
#import "DHMEnableRewardPromoCommand.h"
#import "DHMListRewardPromoDetailCommand.h"
#import "DHMListRewardPromosCommand.h"
#import "DHMListRewardReferralSummaryCommand.h"
#import "DHMListRewardReferralsPromoCommand.h"
#import "DHMRemoveRewardPromoCommand.h"

// Service
#import "DHMServiceProgressCommand.h"

// User
#import "DHMListUsersCommand.h"
#import "DHMAddUserCommand.h"
#import "DHMRemoveUserCommand.h"

// Data
#import "DHMApiCommandData.h"
#import "DHMApiListKeysDataItem.h"

#import "DHMAccountStatusDataItem.h"
#import "DHMAccountUsageDataItem.h"
#import "DHMAccountUserUsageDataItem.h"
#import "DHMAccountSshKeysDataItem.h"

#import "DHMListDnsRecordsDataItem.h"
#import "DHMDomainCheckDataItem.h"
#import "DHMListDomainsDataItem.h"
#import "DHMListRegistrationsDataItem.h"


#import "DHMListUserDataItem.h"

@implementation DHMApi

+(DHMApi*) sharedInstance
{
    static DHMApi *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DHMApi alloc] init];
        // Potentially other initializations here
    });
    
    return sharedInstance;
}

#pragma mark Initialization

-(id) init
{
    if( (self = [super init]) )
    {
        // Initialize RestKit logging
        RKLogConfigureByName("RestKit/Network*", RKLogLevelTrace);
        RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
        
        // Initialize RestKit
        NSURL *baseURL = [NSURL URLWithString:@"https://api.dreamhost.com"];
        
        [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"application/javascript"];
        
        NSLog(@"%@",[RKMIMETypeSerialization registeredMIMETypes]);
        
        
        // Enable Activity Indicator Spinner
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        // Init the base URI here
        [RKObjectManager managerWithBaseURL:baseURL];
       
        // Add date and time transform for Dreamhost specific format
        NSLocale* localeUS = [NSLocale localeWithLocaleIdentifier:@"en_US"];
        NSDateFormatter* dhDateFormat = [[NSDateFormatter alloc] init];
        [dhDateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dhDateFormat setLocale:localeUS];
        [[RKValueTransformer defaultValueTransformer] insertValueTransformer:dhDateFormat atIndex:0];
        
        // Add all commands to API
        NSMutableArray* tmpAllCommands = [NSMutableArray array];
        NSMutableArray* tmpAllCategories = [NSMutableArray array];
        [tmpAllCategories addObject:[DHMCommandCategory category:kNoCategory categoryName:@"None"]];
        
        // Account Commands
        DHMCommandCategory* cat = nil;
        
        cat = [DHMCommandCategory category:kAccountCategory categoryName:@"Account"];
        [tmpAllCategories addObject:cat];
        [tmpAllCommands addObject:[DHMAccountDomainUsageCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMAccountStatusCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMAccountUserUsageCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMAccountSshKeysCommand commandWithInternalDataAndCategory:cat]];
        
        // Announcement Commands
        cat = [DHMCommandCategory category:kAnnouncementCategory categoryName:@"Announcement"];
        [tmpAllCategories addObject:cat];
        [tmpAllCommands addObject:[DHMListAnnounceListsCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMListAnnounceSubscribersCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMAddAnnounceSubscriberCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMRemoveAnnounceSubscriberCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMPostAnnounceCommand commandWithInternalDataAndCategory:cat]];
        
        // API Commands
        cat = [DHMCommandCategory category:kAPICategory categoryName:@"API"];
        [tmpAllCategories addObject:cat];
        [tmpAllCommands addObject:[DHMListApiCapabilitiesCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMListApiKeysCommand commandWithInternalDataAndCategory:cat]];
        
        // Domains Commands
        cat = [DHMCommandCategory category:kDomainCategory categoryName:@"Domain"];
        [tmpAllCategories addObject:cat];
        [tmpAllCommands addObject:[DHMListDomainsCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMListRegistrationsCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMDomainCheckCommand commandWithInternalDataAndCategory:cat]];
        
        // DNS Commands
        cat = [DHMCommandCategory category:kDNSCategory categoryName:@"DNS"];
        [tmpAllCategories addObject:cat];
        [tmpAllCommands addObject:[DHMListDnsRecordsCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMAddDnsCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMRemoveDnsCommand commandWithInternalDataAndCategory:cat]];
        
        // Jabber Comands
        cat = [DHMCommandCategory category:kJabberCategory categoryName:@"Jabber"];
        [tmpAllCategories addObject:cat];
        [tmpAllCommands addObject:[DHMListJabberUsersCommand commandWithInternalDataAndCategory:cat]];
        
        // Mail Commands
        cat = [DHMCommandCategory category:kMailCategory categoryName:@"Mail"];
        [tmpAllCategories addObject:cat];
        [tmpAllCommands addObject:[DHMAddMailFilterCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMRemoveMailFilterCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMListMailFiltersCommand commandWithInternalDataAndCategory:cat]];
        
        // MySQL Commands
        cat = [DHMCommandCategory category:kMySQLCategory categoryName:@"MySQL"];
        [tmpAllCategories addObject:cat];
        [tmpAllCommands addObject:[DHMListMySqlDbCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMListMySqlHostnamesCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMAddMySqlHostnameCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMRemoveMySqlHostnameCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMAddMySqlUserCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMRemoveMySqlUserCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMListMySqlUsersCommand commandWithInternalDataAndCategory:cat]];
        
        // Private Server Commands
        cat = [DHMCommandCategory category:kPrivateServerCategory categoryName:@"Private Server"];
        [tmpAllCategories addObject:cat];
        [tmpAllCommands addObject:[DHMListPsUsageCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMListPsCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMRebootPsCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMAddPsCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMRemovePsCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMListPendingPsCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMRemovePendingPsCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMListSettingsPsCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMUpdateSettingsPsCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMListSizeHistoryPsCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMSetSizePsCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMListRebootHistoryPsCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMListImagesPsCommand commandWithInternalDataAndCategory:cat]];
        
        // Rewards Commands
        cat = [DHMCommandCategory category:kRewardsCategory categoryName:@"Rewards"];
        [tmpAllCategories addObject:cat];
        [tmpAllCommands addObject:[DHMAddRewardPromoCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMRemoveRewardPromoCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMEnableRewardPromoCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMDisableRewardPromoCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMListRewardPromosCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMListRewardPromoDetailCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMListRewardReferralsPromoCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMListRewardReferralSummaryCommand commandWithInternalDataAndCategory:cat]];
        
        // Service Commands
        cat = [DHMCommandCategory category:kServiceCategory categoryName:@"Service"];
        [tmpAllCategories addObject:cat];
        [tmpAllCommands addObject:[DHMServiceProgressCommand commandWithInternalDataAndCategory:cat]];
        
        // Users Commands
        cat = [DHMCommandCategory category:kUserCategory categoryName:@"User"];
        [tmpAllCategories addObject:cat];
        [tmpAllCommands addObject:[DHMListUsersCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMAddUserCommand commandWithInternalDataAndCategory:cat]];
        [tmpAllCommands addObject:[DHMRemoveUserCommand commandWithInternalDataAndCategory:cat]];
        
        
        _allCommands = [tmpAllCommands copy];
        _allCommandCategories = [tmpAllCategories copy];
    }
    
    return self;
}

-(void) initializeApi
{
    
}

-(void) shutdownApi
{
    [self cancelApiRequests];
}

-(NSUInteger) pendingApiRequestCount
{
    return [[RKObjectManager sharedManager].operationQueue operationCount];
}

-(void) cancelApiRequests
{
    if(self.pendingApiRequestCount > 0)
        [[RKObjectManager sharedManager].operationQueue cancelAllOperations];
}

#pragma mark Lookup Routines

-(CommandCategory) valueFromCategoryName:(NSString *)name
{
    NSParameterAssert(name != nil);
    
    NSAssert(_allCommandCategories != nil, @"Command categories are not yet populated");
    NSAssert([name length] > 0, @"Category name must have a value");
    
    CommandCategory wResult = kNoCategory;

    NSPredicate *wPred = [NSPredicate predicateWithFormat:@"name = %@", name];
    NSArray *wCollection = [_allCommandCategories filteredArrayUsingPredicate:wPred];
    if(wCollection.count > 0)
    {
        DHMCommandCategory *search = (DHMCommandCategory*)(wCollection[0]);
        wResult = search.cat;
    }

    return wResult;
}

-(NSString*) categoryNameFromValue:(CommandCategory)cat
{
    NSParameterAssert(cat >= 0);
    
    NSAssert(_allCommandCategories != nil, @"Command categories are not yet populated");

    NSString* wResult = nil;
    NSPredicate *wPred = [NSPredicate predicateWithFormat:@"cat = %d", cat];
    NSArray *wCollection = [_allCommandCategories filteredArrayUsingPredicate:wPred];
    if(wCollection.count > 0)
    {
        DHMCommandCategory *search = (DHMCommandCategory*)(wCollection[0]);
        wResult = search.name;
    }

    return wResult;
}

-(DHMBaseCommand*) commandFromCommandName:(NSString *)name
{
    NSParameterAssert(name != nil);
    NSParameterAssert(name.length > 0);
    
    DHMBaseCommand *wResult = nil;
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"command = %@", name];
    NSArray *filtered = [_allCommands filteredArrayUsingPredicate:pred];
    
    if(filtered.count >= 1)
        wResult = (DHMBaseCommand*)filtered[0];
    
    return wResult;
}

@synthesize selectedKey;

#pragma mark Building Queries

-(NSString*) buildQueryWithCommand:(DHMBaseCommand *)cmd
{
    return [self buildQueryWithCommand:cmd usingKey:self.selectedKey];
}

-(NSURLRequest*) buildRequestWithCommand:(DHMBaseCommand *)cmd
{
    NSURL* url = [NSURL URLWithString:[self buildQueryWithCommand:cmd] relativeToURL:[RKObjectManager sharedManager].baseURL];
    return [NSURLRequest requestWithURL:url];
}

-(NSString*) buildQueryWithCommand:(DHMBaseCommand *)cmd usingKey:(NSString *)key
{
    // /?key=blahblahblah123
    // &unique_id= .. Get something from NSUUID
    // &cmd=user-list_users_no_pw
    // &format=json
    NSString* query = nil;
    
    if(!cmd.hasParameters)
    {
        if(!cmd.requiresGuid)
        {
            query = [NSString stringWithFormat:@"/?key=%@&cmd=%@&format=%@",
                     key,
                     [[cmd class] command],
                     DH_QUERY_FORMAT];
        }
        else
        {
            NSUUID* guid = [NSUUID UUID];

            query = [NSString stringWithFormat:@"/?key=%@&cmd=%@&unique_id=%@&format=%@",
                     key,
                     [[cmd class] command],
                     guid.UUIDString,
                     DH_QUERY_FORMAT];
        }
    }
    else
    {
        NSMutableString* params = [NSMutableString string];
        [cmd.parameterDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop)
         {
             [params appendString:[NSString stringWithFormat:@"&%@=%@", key, obj]];
         }];
        
        if(!cmd.requiresGuid)
        {
            query = [NSString stringWithFormat:@"/?key=%@&cmd=%@&%@&format=%@",
                     self.selectedKey,
                     [[cmd class] command],
                     params,
                     DH_QUERY_FORMAT];
        }
        else
        {
            NSUUID* guid = [NSUUID UUID];
            
            query = [NSString stringWithFormat:@"/?key=%@&cmd=%@&%@&unique_id=%@&format=%@",
                     self.selectedKey,
                     [[cmd class] command],
                     params,
                     guid.UUIDString,
                     DH_QUERY_FORMAT];
        }
    }
    
    return query;
}

-(NSURLRequest*) buildRequestWithCommand:(DHMBaseCommand *)cmd usingKey:(NSString *)key
{
    NSURL* url = [NSURL URLWithString:[self buildQueryWithCommand:cmd usingKey:key] relativeToURL:[RKObjectManager sharedManager].baseURL];
    return [NSURLRequest requestWithURL:url];
}

-(NSDictionary*) dictionaryForCommandStrings:(NSArray *)commands
{
    return [self dictionaryForCommandStrings:commands filterInteractive:NO];
}

- (NSDictionary *)dictionaryForCommandStrings:(NSArray *)commands filterInteractive:(BOOL)removeInteractive
{
    NSParameterAssert(commands != nil);
    NSParameterAssert(commands.count > 0);
    
    // Resulting dictionary where
    // The key is the readable name of the CommandCategory
    // The value is an array of commands found in that category
    // For example
    //  "User"           : [DHMListUsersCommand]
    //  "Private Server" : [DHMListPsCommand, DHMListSizeHistoryPsCommand]
    NSMutableDictionary* wResult = [NSMutableDictionary dictionary];
    
    // Loop through all commands and find the matching command object
    for (NSString* cmdStr in commands)
    {
        DHMBaseCommand* cmd = [self commandFromCommandName:cmdStr];
        
        if(cmd != nil)
        {
            // Skip over commands that require user input
            if(cmd.requiresUserSelection && removeInteractive)
                continue;
            
            // Command exists so get the category then update the value array
            NSString* catName = [self categoryNameFromValue:cmd.category];
            
            // Might be nil if value doesn't exist
            NSMutableArray *array = [wResult valueForKey:catName];
            
            if(array == nil)
            {
                // Create the key/value pair - subsequent category matches will have to append
                // to the NSMutableArray already there
                [wResult
                 setObject:[NSMutableArray arrayWithObject:cmd]
                 forKey:catName];
            }
            else
            {
                // Key/Value pair already exist but we just need to add to the NSMutableArray
                [array addObject:cmd];
            }
        }
    }
    
    return wResult;
}

/**
 Stores all command meta data so API details are kept within the encrypted app bundle.
 @return dictionary of command data
 */
-(NSDictionary*) commandMetaDataDictionary
{
    
    return nil;
}

@end
