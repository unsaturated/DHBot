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

#import "DHMBaseData.h"

@interface DHMListUserDataItem : DHMBaseData

@property (nonatomic) NSNumber * accountID;
@property (nonatomic, copy) NSString * user;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * shell;
@property (nonatomic, copy) NSString * home;
@property (nonatomic) NSNumber * diskUsedMB;
@property (nonatomic) NSNumber * diskQuotaMB;
@property (nonatomic, copy) NSString * gecos;

/**
 Formats the disk used and optionally formats with the quota, if available.
 @return disk utilization
 */
-(NSString*) diskUsedMBWithQuota:(BOOL)showQuota;

@end
