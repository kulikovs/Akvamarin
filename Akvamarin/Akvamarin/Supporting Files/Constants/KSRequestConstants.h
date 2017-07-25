//
//  KSRequestConstants.h
//  Akvamarin
//
//  Created by KulikovS on 02.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#ifndef KSRequestConstants_h
#define KSRequestConstants_h

static NSString * const kKSHTTPMethodGET         = @"GET";
static NSString * const kKSHTTPMethodPOST        = @"POST";

//requests for photoZone
static NSString * const kKSPhotoZoneUrlString    = @"https://test-self-app.herokuapp.com/categories";
static NSString * const kKSAcceptHeaderKey       = @"accept";
static NSString * const kKSContentHeaderKey      = @"content-type";
static NSString * const kKSApplicationHeaderKey  = @"application/json";

//requests for calendar
static NSString * const kKSMaxResult             = @"2500";
//old calendar
//static NSString * const kKSCalendarId            = @"q962o107vv3t9t3pfmkrkuj6is@group.calendar.google.com";
static NSString * const kKSCalendarId            = @"akvamarin.photostudio@gmail.com";
static NSString * const kKSApiKey                = @"AIzaSyDtYcy1F9oeUXwjREGM5YnlndEGn0d_luM";
static NSString * const kKSCalendarUrlFormat     = @"https://www.googleapis.com/calendar/v3/calendars/%@/events?maxResults=%@&timeMin=%ld-01-01T10:00:00Z&key=%@&fields=items(id,start,end,summary,status)";

//requests for sending e-mail
static NSString * const kKSSendMailUrlString     = @"http://test-self-app.herokuapp.com/send_email";
static NSString * const kKSStartTimeKey          = @"start_time";
static NSString * const kKSEndTimeKey            = @"end_time";
static NSString * const kKSDateKey               = @"date";
static NSString * const kKSNameKey               = @"name";
static NSString * const kKSEmailKey              = @"email";
static NSString * const kKSPhoneKey              = @"phone";
static NSString * const kKSUserKey               = @"user";

#endif /* KSRequestConstants_h */
