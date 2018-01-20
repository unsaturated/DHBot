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

#import "DHMAddDnsCommand.h"

@implementation DHMAddDnsCommand

+(NSString*) command { return DHM_DNS_ADD_REC; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Add DNS Record", @"Add DNS Record - the command name itself");
        mCommandDesc = NSLocalizedString(@"Adds a DNS record", @"Adds a DNS record");
        mRunningText = NSLocalizedString(@"Adding record...", @"In-progress text for adding a DNS record");
        mEnabled = NO;
        mRequiresUserSelection = NO;
        mPointCost = 3;
        mCommandCategory = cat.cat;
        mCommandCategoryEnumName = cat.name;
    }
    
    return self;
}

-(BOOL) returnsArray { return NO; }

/**
 * Returns the valid parameters.
 *
 * record  : the full name of the record you'd like to add, e.g. testing.groo.com
 * type    : A, CNAME, NS, PTR, NAPTR, SRV, TXT, SPF, or AAAA
 * value   : the DNS record's value
 * comment : optional comment
 */
-(NSArray*) acceptableParameters { return @[@"record", @"type", @"value", @"comment"]; }

-(BOOL) requiresGuid { return YES; }

@end
