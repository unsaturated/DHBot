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

#import "DHMCommandCategory.h"

@implementation DHMCommandCategory

+(CommandCategory) categoryFromEnumName:(NSString*)name
{
    NSDictionary *stringToEnum = @{  @"kNoCategory" : @0,
                                       @"kAPICategory": @1,
                                       @"kAccountCategory": @2,
                                       @"kUserCategory": @3,
                                       @"kDomainCategory": @4,
                                       @"kAnnouncementCategory": @5,
                                       @"kMySQLCategory": @6,
                                       @"kMailCategory": @7,
                                       @"kDNSCategory": @8,
                                       @"kRewardsCategory": @9,
                                       @"kPrivateServerCategory": @10,
                                       @"kServiceCategory": @11,
                                       @"kJabberCategory": @12};
    NSNumber* catNum = (NSNumber*)[stringToEnum valueForKey:name];
    CommandCategory cat = (CommandCategory)catNum.intValue;
    
    return cat;
}

+(id) category:(CommandCategory)cat categoryName:(NSString *)name
{
    return [[self alloc] initWithCat:cat andName:name];
}

-(id) initWithCat:(CommandCategory)cat andName:(NSString *)name
{
    if( (self = [super init]) )
    {
        _cat = cat;
        _name = name;
    }
    
    return self;
}

@synthesize cat = _cat;
@synthesize name = _name;

@end
