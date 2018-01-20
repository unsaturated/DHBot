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

#import "DHMListRewardReferralsPromoCommand.h"

@implementation DHMListRewardReferralsPromoCommand

+(NSString*) command { return DHM_REW_REF_LOG; }

-(id) initWithCategory:(DHMCommandCategory*)cat
{
    if( (self = [super init]) )
    {
        mCommandName = NSLocalizedString(@"Referral Log", @"Referral Log - the command name itself");
        mCommandDesc = NSLocalizedString(@"Lists referral log", @"Lists the rewards/promotions referral log in a detailed view");
        mRunningText = NSLocalizedString(@"Getting log...", @"In-progress text for getting the referral log");
        mEnabled = NO;
        mRequiresUserSelection = YES;
        mPointCost = 1;
        mCommandCategory = cat.cat;
        mCommandCategoryEnumName = cat.name;
    }
    
    return self;
}

-(BOOL) returnsArray { return YES; }

/**
 * Returns the valid parameters.
 *
 * period : a period of time such as "1 day" or "3 months"
 */
-(NSArray*) acceptableParameters { return @[@"period"]; }

-(BOOL) requiresGuid { return YES; }

@end
