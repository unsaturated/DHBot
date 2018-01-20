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

#import "DHMBaseCommand.h"

/**
 * Command to request list of disk and bandwidth usage for all visible users. 
 * Disk usage is in kilobytes; bandwidth usage is in bytes since the start 
 * of the billing cycle. In most cases, bandwidth usage will appear as zero here.
 * @see http://wiki.dreamhost.com/API/Account_commands
 */
@interface DHMAccountUserUsageCommand : DHMBaseCommand

@end
