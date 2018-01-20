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
 * Command to request adding a new user (of type ftp, sftp, or shell). If you do
 * not specify a password, then a password will be randomly generated and displayed
 * in the result. Otherwise the result will just display ******** for the password.
 * A Service token will also be returned (see Service Control Commands).
 * @see http://wiki.dreamhost.com/API/User_commands
 */
@interface DHMAddUserCommand : DHMBaseCommand

@end
