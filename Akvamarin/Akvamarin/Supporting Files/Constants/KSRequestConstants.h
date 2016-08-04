//
//  KSRequestConstants.h
//  Akvamarin
//
//  Created by KulikovS on 02.08.16.
//  Copyright © 2016 KulikovS. All rights reserved.
//

#ifndef KSRequestConstants_h
#define KSRequestConstants_h

static NSString * const kKSGetHTTPMethod         = @"GET";

//request for photoZone
static NSString * const kKSPhotoZoneUrlString    = @"https://test-self-app.herokuapp.com/categories";
static NSString * const kKSAcceptHeaderKey       = @"accept";
static NSString * const kKSContentHeaderKey      = @"content-type";
static NSString * const kKSApplicationHeaderKey  = @"application/json";

//request for calendar
static NSString * const kKSCalendarId            = @"ubvnm5gta74qgg9vrfclv99nl4@group.calendar.google.com";
static NSString * const kKSApiKey                = @"AIzaSyDtYcy1F9oeUXwjREGM5YnlndEGn0d_luM";
static NSString * const kKSCalendarUrlFormat     = @"https://www.googleapis.com/calendar/v3/calendars/%@/events?key=%@&fields=items(id,start,end,summary,status)";

#endif /* KSRequestConstants_h */
