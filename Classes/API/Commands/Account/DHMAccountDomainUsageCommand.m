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

#import "DHMAccountDomainUsageCommand.h"

@implementation DHMAccountDomainUsageCommand

+(NSString*) command { return DHM_ACCT_GET_USAGE; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Domain Usage", @"Domain Usage - the command name itself");
        mCommandDesc = NSLocalizedString(@"Bandwidth usage for all domains", @"Bandwidth usage across all the domains");
        mRunningText = NSLocalizedString(@"Getting usage...", @"In-progress text for getting domain usage");
        mEnabled = YES;
        mRequiresUserSelection = NO;
        mPointCost = 1;
        mCommandCategory = cat.cat;
        mCommandCategoryEnumName = cat.name;
    }
    
    return self;
}

-(BOOL) returnsArray { return YES; }

@end
