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

#import "DHMDomainCheckCommand.h"

@implementation DHMDomainCheckCommand

+(NSString*) command { return DHM_DOM_REG_AVAIL; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Domain Availability", @"Domain Availability - the command name itself");
        mCommandDesc = NSLocalizedString(@"Check domain availability", @"Check domain name availability");
        mRunningText = NSLocalizedString(@"Checking availability...", @"In-progress text for checking the availability of a domain name");
        mEnabled = YES;
        mRequiresUserSelection = NO;
        mPointCost = 2;
        mCommandCategory = cat.cat;
        mCommandCategoryEnumName = cat.name;
    }
    
    return self;
}

-(BOOL) returnsArray { return NO; }

/**
 * Returns the valid parameters.
 *
 * domain  : the domain name to check
 */
-(NSArray*) acceptableParameters { return @[@"domain"]; }

-(BOOL) requiresGuid { return NO; }

@end
