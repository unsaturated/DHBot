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

#import "DHMUpdateSettingsPsCommand.h"

@implementation DHMUpdateSettingsPsCommand

+(NSString*) command { return DHM_PS_SET_SETTINGS; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Update Settings", @"Update Settings - the command name itself");
        mCommandDesc = NSLocalizedString(@"Updates private server settings", @"Updates private server settings");
        mRunningText = NSLocalizedString(@"Updating server settings...", @"In-progress text for updating server settings");
        mEnabled = NO;
        mRequiresUserSelection = YES;
        mPointCost = 3;
        mCommandCategory = cat.cat;
        mCommandCategoryEnumName = cat.name;
    }
    
    return self;
}

-(BOOL) returnsArray { return YES; }

/**
 * Returns the valid parameters.
 *
 * ps : the name of the ps (get it from list_ps)
 * apache2_enabled : 0 or 1 (optional)
 * comment : Any string you'd like to describe this ps. (optional)
 * courier_enabled : 0 or 1 (optional)
 * jabber_transports_enabled : 0 or 1 (optional)
 * lighttpd_enabled : 0 or 1 (optional)
 * modphp_4_selected : 0 or 1 (optional)
 * php_cache_xcache : 0 or 1 (optional)
 * proftpd_enabled : 0 or 1 (optional)
 */
-(NSArray*) acceptableParameters { return @[
                                            @"ps",
                                            @"apache2_enabled",
                                            @"coment",
                                            @"courier_enabled",
                                            @"jabber_transports_enabled",
                                            @"lighttpd_enabled",
                                            @"modphp_4_selected",
                                            @"php_cache_xcache",
                                            @"proftpd_enabled"]; }

-(BOOL) requiresGuid { return YES; }

@end
