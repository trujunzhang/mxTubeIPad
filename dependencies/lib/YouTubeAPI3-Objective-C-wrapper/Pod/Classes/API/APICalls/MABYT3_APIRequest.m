//
//  MABYT3_LISTRequest.m
//  YTAPI3Demo
//
//  Created by Muhammad Bassio on 5/6/14.
//  Copyright (c) 2014 Muhammad Bassio. All rights reserved.
//

#import "MABYT3_APIRequest.h"
#import "AFHTTPRequestOperation.h"


@implementation MABYT3_APIRequest

static MABYT3_APIRequest * sharedlst = nil;


+ (MABYT3_APIRequest *)sharedInstance {

   if (!sharedlst) {
      sharedlst = [[MABYT3_APIRequest alloc] init];
   }
   return sharedlst;
}


- (NSString *)ActivitiesURLforUser:(MABYT3_Channel *)channel withMaxResults:(NSInteger)max {
   return [self ActivitiesURLforUserWithChannelId:channel.identifier withParameters:nil withMaxResults:max];
}


- (NSString *)ActivitiesURLforUserWithChannelId:(NSString *)channelId withParameters:(NSDictionary *)params withMaxResults:(NSInteger)max {
   NSString * paramS = [self getParameterString:params];
   if (max != 5) {
      paramS = [NSString stringWithFormat:@"%@&maxResults=%@", paramS, [@(max) stringValue]];
   }
   return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/activities?part=id,snippet,contentDetails&channelId=%@%@",
                                     channelId, paramS];
}


- (NSString *)ChannelURLWithParameters:(NSDictionary *)params withMaxResults:(NSInteger)max {
   NSString * paramS = [self getParameterString:params];
   if (max != 5) {
      paramS = [NSString stringWithFormat:@"%@&maxResults=%@", paramS, [@(max) stringValue]];
   }
   return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/channels?%@", paramS];
}


- (NSString *)ActivitiesURLforMeWithMaxResults:(NSInteger)max {

   if (max != 5) {
      return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/activities?part=id,snippet,contentDetails&mine=true&maxResults=%@",
                                        [@(max) stringValue]];
   }
   return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/activities?part=id,snippet,contentDetails&mine=true"];
}


- (NSString *)ActivitiesURLforHomeWithMaxResults:(NSInteger)max {

   if (max != 5) {
      return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/activities?part=id,snippet,contentDetails&home=true&maxResults=%@",
                                        [@(max) stringValue]];
   }
   return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/activities?part=id,snippet,contentDetails&home=true"];
}


- (NSString *)GuidedCategoriesURLforRegion:(NSString *)reg andLanguage:(NSString *)lang {

   if ([lang isEqualToString:@""]) {
      return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/guideCategories?part=id,snippet&regionCode=%@",
                                        reg];
   }
   return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/guideCategories?part=id,snippet&hl=%@&regionCode=%@",
                                     lang,
                                     reg];
}


- (NSString *)LanguagesURLforLanguae:(NSString *)lang {

   if ([lang isEqualToString:@""]) {
      return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/i18nLanguages?part=id,snippet"];
   }
   return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/i18nLanguages?part=id,snippet&hl=%@",
                                     lang];
}


- (NSString *)RegionsURLforLanguae:(NSString *)lang {

   if ([lang isEqualToString:@""]) {
      return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/i18nRegions?part=id,snippet"];
   }
   return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/i18nRegions?part=id,snippet&hl=%@", lang];
}


- (NSString *)PlayListItemsURLforPlayList:(NSString *)playlistId withMaxResults:(NSInteger)max {

   if (max == 5) {
      return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlistItems?part=id,snippet&playlistId=%@",
                                        playlistId];
   }
   return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlistItems?part=id,snippet&maxResults=%@&playlistId=%@",
                                     [@(max) stringValue],
                                     playlistId];
}


- (NSString *)PlayListsURLforMewithMaxResults:(NSInteger)max {

   if (max == 5) {
      return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlists?part=id,snippet,contentDetails&mine=true"];
   }
   return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlists?part=id,snippet,contentDetails&maxResults=%@&mine=true",
                                     [@(max) stringValue]];
}


- (NSString *)PlayListsURLforChannel:(NSString *)channelId withMaxResults:(NSInteger)max {

   if (max == 5) {
      return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlists?part=id,snippet,contentDetails&channelId=%@",
                                        channelId];
   }
   return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlists?part=id,snippet,contentDetails&maxResults=%@&channelId=%@",
                                     [@(max) stringValue],
                                     channelId];
}


- (NSString *)PlayListsURLforPlayList:(NSString *)playlistId withMaxResults:(NSInteger)max {

   if (max == 5) {
      return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlists?part=id,snippet,contentDetails&id=%@",
                                        playlistId];
   }
   return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlists?part=id,snippet,contentDetails&maxResults=%@&id=%@",
                                     [@(max) stringValue],
                                     playlistId];
}


- (NSString *)VideoSearchURLforTermWithParameters:(NSDictionary *)params withMaxResults:(NSInteger)max {
   NSString * paramS = [self getParameterString:params];
   if (max != 5) {
      paramS = [NSString stringWithFormat:@"%@&maxResults=%@", paramS, [@(max) stringValue]];
   }
   return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/search?%@", paramS];
}


- (NSString *)VideoSearchURLforTerm:(NSString *)term queryType:(NSString *)queryType withParameters:(NSDictionary *)params andMaxResults:(NSInteger)max {

   NSString * paramS = [self getParameterString:params];
   if (max != 5) {
      paramS = [NSString stringWithFormat:@"%@&maxResults=%@", paramS, [@(max) stringValue]];
   }
   return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/search?part=id,snippet&q=%@&type=%@%@",
                                     term,
                                     queryType,
                                     paramS];
}


- (NSString *)getParameterString:(NSDictionary *)params {
   NSString * paramS = @"";
   for (NSString * key in [params allKeys]) {
      paramS = [NSString stringWithFormat:@"%@&%@=%@", paramS, key, [params objectForKey:key]];
   }
   return paramS;
}


- (NSString *)ChannelSearchURLforTerm:(NSString *)term withParameters:(NSDictionary *)params andMaxResults:(NSInteger)max {

   NSString * paramS = @"";
   for (NSString * key in [params allKeys]) {
      paramS = [NSString stringWithFormat:@"%@&%@=%@", paramS, key, [params objectForKey:key]];
   }
   if (max != 5) {
      paramS = [NSString stringWithFormat:@"%@&maxResults=%@", paramS, [@(max) stringValue]];
   }
   return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/search?part=id,snippet&q=%@&type=channel%@",
                                     term,
                                     paramS];
}


- (NSString *)PlayListSearchURLforTerm:(NSString *)term withParameters:(NSDictionary *)params andMaxResults:(NSInteger)max {

   NSString * paramS = @"";
   for (NSString * key in [params allKeys]) {
      paramS = [NSString stringWithFormat:@"%@&%@=%@", paramS, key, [params objectForKey:key]];
   }
   if (max != 5) {
      paramS = [NSString stringWithFormat:@"%@&maxResults=%@", paramS, [@(max) stringValue]];
   }
   return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/search?part=id,snippet&q=%@&type=playlist%@",
                                     term,
                                     paramS];
}


- (NSString *)VideoURLforVideoWithParameters:(NSDictionary *)params withMaxResults:(NSInteger)max {
   NSString * paramS = @"";
   for (NSString * key in [params allKeys]) {
      paramS = [NSString stringWithFormat:@"%@&%@=%@", paramS, key, [params objectForKey:key]];
   }
   if (max != 5) {
      paramS = [NSString stringWithFormat:@"%@&maxResults=%@", paramS, [@(max) stringValue]];
   }
   return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/videos?%@",
                                     paramS];
}


- (NSString *)VideoURLforVideo:(NSString *)videoId withMaxResults:(NSInteger)max {

   if (max == 5) {
      return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/videos?part=id,snippet,contentDetails,statistics&id=%@",
                                        videoId];
   }
   return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/videos?part=id,snippet,contentDetails,statistics&id=%@&maxResults=%@",
                                     videoId,
                                     [@(max) stringValue]];
}


- (NSString *)ChannelURLforId:(NSString *)channelId withMaxResults:(NSInteger)max {

   if (max == 5) {
      return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/channels?part=id,snippet,contentDetails&id=%@",
                                        channelId];
   }
   return [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/channels?part=id,snippet,contentDetails&id=%@&maxResults=%@",
                                     channelId,
                                     [@(max) stringValue]];
}


- (void)LISTActivitiesForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler {

   __block NSString * nxtURLStr = @"";
   NSMutableArray * arr = [[NSMutableArray alloc] init];
   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&key=%@", urlStr, apiKey]]];

   [request setHTTPMethod:@"GET"];
   [self appendAuthInfo:request];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 200) {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"items"]) {
                                    NSArray * items = [dict objectForKey:@"items"];
                                    if (items.count > 0) {
                                       for (int i = 0; i < items.count; i++) {
                                          MABYT3_Activity * itm = [[MABYT3_Activity alloc] initFromDictionary:items[i]];
                                          [arr addObject:itm];
                                       }
                                    }
                                 }
                                 if ([dict objectForKey:@"nextPageToken"]) {
                                    NSString * pagetoken = [dict objectForKey:@"nextPageToken"];
//                                    nxtURLStr = [NSString stringWithFormat:@"%@&nextPageToken=%@", urlStr, pagetoken];
                                    nxtURLStr = pagetoken;
                                 }
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(arr, error, nxtURLStr);
                              });

                          }];
}


- (void)LISTChannelSectionsForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler {

   NSMutableArray * arr = [[NSMutableArray alloc] init];
   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&key=%@", urlStr, apiKey]]];

   [request setHTTPMethod:@"GET"];
   [self appendAuthInfo:request];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 200) {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"items"]) {
                                    NSArray * items = [dict objectForKey:@"items"];
                                    if (items.count > 0) {
                                       for (int i = 0; i < items.count; i++) {
                                          MABYT3_ChannelSection * itm = [[MABYT3_ChannelSection alloc] initFromDictionary:items[i]];
                                          [arr addObject:itm];
                                       }
                                    }
                                 }
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(arr, error, nil);
                              });

                          }];
}


- (void)LISTChannelsForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler {

   NSMutableArray * arr = [[NSMutableArray alloc] init];
   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&key=%@", urlStr, apiKey]]];

   [request setHTTPMethod:@"GET"];
   [self appendAuthInfo:request];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 200) {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"items"]) {
                                    NSArray * items = [dict objectForKey:@"items"];
                                    if (items.count > 0) {
                                       for (int i = 0; i < items.count; i++) {
                                          MABYT3_Channel * itm = [[MABYT3_Channel alloc] initFromDictionary:items[i]];
                                          [arr addObject:itm];
                                       }
                                    }
                                 }
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(arr, error, nil);
                              });

                          }];
}


- (void)LISTGuideCategoriesForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler {

   NSMutableArray * arr = [[NSMutableArray alloc] init];
   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&key=%@", urlStr, apiKey]]];

   [request setHTTPMethod:@"GET"];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 200) {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"items"]) {
                                    NSArray * items = [dict objectForKey:@"items"];
                                    if (items.count > 0) {
                                       for (int i = 0; i < items.count; i++) {
                                          MABYT3_GuideCategory * itm = [[MABYT3_GuideCategory alloc] initFromDictionary:items[i]];
                                          [arr addObject:itm];
                                       }
                                    }
                                 }
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(arr, error, nil);
                              });

                          }];
}


- (void)LISTLanguagesForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler {

   NSMutableArray * arr = [[NSMutableArray alloc] init];
   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&key=%@", urlStr, apiKey]]];

   [request setHTTPMethod:@"GET"];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 200) {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"items"]) {
                                    NSArray * items = [dict objectForKey:@"items"];
                                    if (items.count > 0) {
                                       for (int i = 0; i < items.count; i++) {
                                          MABYT3_Language * itm = [[MABYT3_Language alloc] initFromDictionary:items[i]];
                                          [arr addObject:itm];
                                       }
                                    }
                                 }
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(arr, error, nil);
                              });

                          }];
}


- (void)LISTPlayListItemsForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler {

   __block NSString * nxtURLStr = @"";
   NSMutableArray * arr = [[NSMutableArray alloc] init];
   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&key=%@", urlStr, apiKey]]];

   [request setHTTPMethod:@"GET"];
   [self appendAuthInfo:request];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 200) {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"items"]) {
                                    NSArray * items = [dict objectForKey:@"items"];
                                    if (items.count > 0) {
                                       for (int i = 0; i < items.count; i++) {
                                          MABYT3_PlayListItem * itm = [[MABYT3_PlayListItem alloc] initFromDictionary:items[i]];
                                          [arr addObject:itm];
                                       }
                                    }
                                 }
                                 if ([dict objectForKey:@"nextPageToken"]) {
                                    NSString * pagetoken = [dict objectForKey:@"nextPageToken"];
                                    nxtURLStr = [NSString stringWithFormat:@"%@&nextPageToken=%@", urlStr, pagetoken];
                                 }
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(arr, error, nxtURLStr);
                              });

                          }];
}


- (void)LISTPlayListsForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler {

   __block NSString * nxtURLStr = @"";
   NSMutableArray * arr = [[NSMutableArray alloc] init];
   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&key=%@", urlStr, apiKey]]];

   [request setHTTPMethod:@"GET"];
   [self appendAuthInfo:request];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 200) {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"items"]) {
                                    NSArray * items = [dict objectForKey:@"items"];
                                    if (items.count > 0) {
                                       for (int i = 0; i < items.count; i++) {
                                          MABYT3_PlayList * itm = [[MABYT3_PlayList alloc] initFromDictionary:items[i]];
                                          [arr addObject:itm];
                                       }
                                    }
                                 }
                                 if ([dict objectForKey:@"nextPageToken"]) {
                                    NSString * pagetoken = [dict objectForKey:@"nextPageToken"];
                                    nxtURLStr = [NSString stringWithFormat:@"%@&nextPageToken=%@", urlStr, pagetoken];
                                 }
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(arr, error, nxtURLStr);
                              });

                          }];
}


- (void)LISTRegionsForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler {

   NSMutableArray * arr = [[NSMutableArray alloc] init];
   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&key=%@", urlStr, apiKey]]];

   [request setHTTPMethod:@"GET"];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 200) {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"items"]) {
                                    NSArray * items = [dict objectForKey:@"items"];
                                    if (items.count > 0) {
                                       for (int i = 0; i < items.count; i++) {
                                          MABYT3_Region * itm = [[MABYT3_Region alloc] initFromDictionary:items[i]];
                                          [arr addObject:itm];
                                       }
                                    }
                                 }
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(arr, error, nil);
                              });

                          }];
}


#pragma mark -
#pragma mark fetch youtube search


- (void)fetchWithUrl:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler {
   __block NSString * pageToken = nil;

   NSMutableURLRequest * request = [self getRequest:urlStr withAuth:NO];

   AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

   void (^completionBlock)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation * operation, id o) {
       NSError * error = nil;
       NSMutableArray * array = [[NSMutableArray alloc] init];

       if (operation.response.statusCode == 200) {
          pageToken = [self parseSearchList:urlStr arr:array data:operation.responseData];
       }
       else {
          error = [self getError:operation.responseData httpresp:operation.response];
       }
       dispatch_async(dispatch_get_main_queue(), ^(void) {
           handler(array, error, pageToken);
       });
   };
   void (^failBlock)(AFHTTPRequestOperation *, NSError *) = ^(AFHTTPRequestOperation * operation, NSError * error) {
       dispatch_async(dispatch_get_main_queue(), ^(void) {
           handler(nil, error, nil);
       });
   };

   [operation setCompletionBlockWithSuccess:completionBlock failure:failBlock];
   [operation start];
}


#pragma mark -
#pragma mark -


- (NSMutableURLRequest *)getRequest:(NSString *)urlStr withAuth:(BOOL)auth {

   NSString * string = [NSString stringWithFormat:@"%@&key=%@", urlStr, apiKey];

   NSURL * url = [NSURL URLWithString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url];

   [request setHTTPMethod:@"GET"];
   if (auth) {
      if ([MAB_GoogleUserCredentials sharedInstance].signedin) {
         [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                      [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
        forHTTPHeaderField:@"Authorization"];
      }
   }
   return request;
}


- (NSString *)parseSearchList:(NSString *)urlStr arr:(NSMutableArray *)arr data:(NSData *)data {
   NSError * e = nil;
   NSString * pageToken;
   NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&e];
   if ([dict objectForKey:@"items"]) {
      NSArray * items = [dict objectForKey:@"items"];
      if (items.count > 0) {
         for (int i = 0; i < items.count; i++) {
            MABYT3_SearchItem * itm = [[MABYT3_SearchItem alloc] initFromDictionary:items[i]];
            [arr addObject:itm];
         }
      }
   }
   if ([dict objectForKey:@"nextPageToken"]) {
      pageToken = [dict objectForKey:@"nextPageToken"];
   }
   return pageToken;
}


- (NSError *)getError:(NSData *)data httpresp:(NSHTTPURLResponse *)httpresp {
   NSError * error;
   NSError * e = nil;
   NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&e];
   if ([dict objectForKey:@"error"]) {
      NSDictionary * dict2 = [dict objectForKey:@"error"];
      if ([dict2 objectForKey:@"errors"]) {
         NSArray * items = [dict2 objectForKey:@"errors"];
         if (items.count > 0) {
            NSString * dom = @"YTAPI";
            if ([items[0] objectForKey:@"domain"]) {
               dom = [items[0] objectForKey:@"domain"];
            }
            error = [NSError errorWithDomain:dom
                                        code:httpresp.statusCode
                                    userInfo:items[0]];
         }
      }
   }
   return error;
}


- (void)LISTSearchItemsForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler {

   __block NSString * nxtURLStr = @"";
   NSMutableArray * arr = [[NSMutableArray alloc] init];
   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&key=%@", urlStr, apiKey]]];

   [request setHTTPMethod:@"GET"];
   [self appendAuthInfo:request];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 200) {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"items"]) {
                                    NSArray * items = [dict objectForKey:@"items"];
                                    if (items.count > 0) {
                                       for (int i = 0; i < items.count; i++) {
                                          MABYT3_SearchItem * itm = [[MABYT3_SearchItem alloc] initFromDictionary:items[i]];
                                          [arr addObject:itm];
                                       }
                                    }
                                 }
                                 if ([dict objectForKey:@"nextPageToken"]) {
                                    NSString * pagetoken = [dict objectForKey:@"nextPageToken"];
                                    nxtURLStr = [NSString stringWithFormat:@"%@&nextPageToken=%@", urlStr, pagetoken];
                                 }
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(arr, error, nxtURLStr);
                              });

                          }];
}


- (void)LISTSubscriptionsForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler {

   __block NSString * nxtURLStr = @"";
   NSMutableArray * arr = [[NSMutableArray alloc] init];
   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&key=%@", urlStr, apiKey]]];

   [request setHTTPMethod:@"GET"];
   [self appendAuthInfo:request];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 200) {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"items"]) {
                                    NSArray * items = [dict objectForKey:@"items"];
                                    if (items.count > 0) {
                                       for (int i = 0; i < items.count; i++) {
                                          MABYT3_Subscription * itm = [[MABYT3_Subscription alloc] initFromDictionary:items[i]];
                                          [arr addObject:itm];
                                       }
                                    }
                                 }
                                 if ([dict objectForKey:@"nextPageToken"]) {
                                    NSString * pagetoken = [dict objectForKey:@"nextPageToken"];
                                    nxtURLStr = [NSString stringWithFormat:@"%@&nextPageToken=%@", urlStr, pagetoken];
                                 }
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(arr, error, nxtURLStr);
                              });

                          }];
}


- (void)LISTVideoCategoriesForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler {

   NSMutableArray * arr = [[NSMutableArray alloc] init];
   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&key=%@", urlStr, apiKey]]];

   [request setHTTPMethod:@"GET"];
   [self appendAuthInfo:request];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 200) {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"items"]) {
                                    NSArray * items = [dict objectForKey:@"items"];
                                    if (items.count > 0) {
                                       for (int i = 0; i < items.count; i++) {
                                          MABYT3_VideoCategory * itm = [[MABYT3_VideoCategory alloc] initFromDictionary:items[i]];
                                          [arr addObject:itm];
                                       }
                                    }
                                 }
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(arr, error, nil);
                              });

                          }];
}


- (void)LISTVideosForURL:(NSString *)urlStr andHandler:(MABYoutubeResponseBlock)handler {

   __block NSString * nxtURLStr = @"";
   NSMutableArray * arr = [[NSMutableArray alloc] init];
   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&key=%@", urlStr, apiKey]]];

   [request setHTTPMethod:@"GET"];

   [self appendAuthInfo:request];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 200) {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"items"]) {
                                    NSArray * items = [dict objectForKey:@"items"];
                                    if (items.count > 0) {
                                       for (int i = 0; i < items.count; i++) {
                                          MABYT3_Video * itm = [[MABYT3_Video alloc] initFromDictionary:items[i]];
                                          [arr addObject:itm];
                                       }
                                    }
                                 }
                                 if ([dict objectForKey:@"nextPageToken"]) {
                                    NSString * pagetoken = [dict objectForKey:@"nextPageToken"];
                                    nxtURLStr = pagetoken;
                                 }
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(arr, error, nxtURLStr);
                              });

                          }];
}


- (void)appendAuthInfo:(NSMutableURLRequest *)request {
   if ([MAB_GoogleUserCredentials sharedInstance].signedin) {
//      [request setValue:[NSString stringWithFormat:@"Bearer %@",
//                                                   [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
//     forHTTPHeaderField:@"Authorization"];
   }
}


- (void)LIKEVideo:(NSString *)videoId andHandler:(void (^)(NSError *, BOOL))handler {

   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/videos/rate?id=%@&rating=like&key=%@",
                                                                   videoId,
                                                                   apiKey]]];
   [request setHTTPMethod:@"POST"];
   [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
  forHTTPHeaderField:@"Authorization"];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              BOOL added = NO;
                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 204) {
                                 added = YES;
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(error, added);
                              });

                          }];
}


- (void)DISLIKEVideo:(NSString *)videoId andHandler:(void (^)(NSError *, BOOL))handler {

   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/videos/rate?id=%@&rating=dislike&key=%@",
                                                                   videoId,
                                                                   apiKey]]];
   [request setHTTPMethod:@"POST"];
   [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
  forHTTPHeaderField:@"Authorization"];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              BOOL added = NO;
                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 204) {
                                 added = YES;
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(error, added);
                              });

                          }];
}


- (void)INSERTSubscription:(NSString *)channelId andHandler:(void (^)(NSError *, BOOL))handler {

   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   NSString * post = [NSString stringWithFormat:@"{\"snippet\": {\"resourceId\": {\"channelId\": \"%@\",\"kind\": \"youtube#channel\"}}}",
                                                channelId];
   NSData * postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
   NSString * postLength = [NSString stringWithFormat:@"%lu", (unsigned long) [postData length]];

   [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
   [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
   [request setHTTPBody:postData];

   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/subscriptions?part=snippet&key=%@",
                                                                   apiKey]]];
   [request setHTTPMethod:@"POST"];
   [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
  forHTTPHeaderField:@"Authorization"];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              BOOL added = NO;
                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 200) {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"snippet"]) {
                                    added = YES;
                                 }
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(error, added);
                              });

                          }];
}


- (void)INSERTVideo:(NSString *)videoId inPlayList:(NSString *)playlistID atPosition:(NSInteger)pos andHandler:(void (^)(NSError *, BOOL))handler {

   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   NSString * post = [NSString stringWithFormat:@"{\"snippet\": {\"playlistId\": \"%@\",\"resourceId\": {\"videoId\": \"%@\",\"kind\": \"youtube#video\"},\"position\": %@}}",
                                                playlistID,
                                                videoId,
                                                [@(pos) stringValue]];
   NSData * postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
   //NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
   NSString * postLength = [NSString stringWithFormat:@"%lu", (unsigned long) [postData length]];

   [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
   [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
   [request setHTTPBody:postData];

   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&key=%@",
                                                                   apiKey]]];
   [request setHTTPMethod:@"POST"];
   [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
  forHTTPHeaderField:@"Authorization"];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              BOOL added = NO;
                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 200) {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"snippet"]) {
                                    added = YES;
                                 }
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(error, added);
                              });

                          }];
}


- (void)INSERTPlayList:(NSString *)playlistTitle withDescription:(NSString *)desc andPrivacyStatus:(YTPrivacyStatus)status andHandler:(void (^)(NSError *, NSString *, BOOL))handler {

   __block NSString * identifier = @"";
   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   NSString * post = [NSString stringWithFormat:@"{\"snippet\": {\"title\": \"%@\",\"description\": \"%@\"},\"status\": {\"privacyStatus\": \"%@\"}}",
                                                playlistTitle,
                                                desc,
                                                [self privacyStringFromStatus:status]];
   NSData * postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
   //NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
   NSString * postLength = [NSString stringWithFormat:@"%lu", (unsigned long) [postData length]];

   [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
   [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
   [request setHTTPBody:postData];

   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlists?part=snippet,status&key=%@",
                                                                   apiKey]]];
   [request setHTTPMethod:@"POST"];
   [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
  forHTTPHeaderField:@"Authorization"];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              BOOL added = NO;
                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 200) {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"id"]) {
                                    identifier = [dict objectForKey:@"id"];
                                 }
                                 if ([dict objectForKey:@"snippet"]) {
                                    added = YES;
                                 }
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(error, identifier, added);
                              });

                          }];
}


- (void)INSERTPlayList:(NSString *)playlistTitle andDescription:(NSString *)desc andHandler:(void (^)(NSError *, NSString *, BOOL))handler {

   __block NSString * identifier = @"";
   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   NSString * post = [NSString stringWithFormat:@"{\"snippet\": {\"title\": \"%@\",\"description\": \"%@\"}}",
                                                playlistTitle,
                                                desc];
   NSData * postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
   //NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
   NSString * postLength = [NSString stringWithFormat:@"%lu", (unsigned long) [postData length]];

   [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
   [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
   [request setHTTPBody:postData];

   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlists?part=snippet&key=%@",
                                                                   apiKey]]];
   [request setHTTPMethod:@"POST"];
   [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
  forHTTPHeaderField:@"Authorization"];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              BOOL added = NO;
                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 200) {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"id"]) {
                                    identifier = [dict objectForKey:@"id"];
                                 }
                                 if ([dict objectForKey:@"snippet"]) {
                                    added = YES;
                                 }
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(error, identifier, added);
                              });

                          }];
}


- (void)UPDATEPlayListItem:(NSString *)itemId withVideo:(NSString *)videoId inPlayList:(NSString *)playlistID atPosition:(NSInteger)pos andHandler:(void (^)(NSError *, BOOL))handler {

   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   NSString * post = [NSString stringWithFormat:@"{\"id\": \"%@\",\"snippet\": {\"playlistId\": \"%@\",\"resourceId\": {\"kind\": \"youtube#video\",\"videoId\": \"%@\"},\"position\": %@}}",
                                                itemId,
                                                playlistID,
                                                videoId,
                                                [@(pos) stringValue]];
   NSData * postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
   //NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
   NSString * postLength = [NSString stringWithFormat:@"%lu", (unsigned long) [postData length]];

   [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
   [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
   [request setHTTPBody:postData];

   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&key=%@",
                                                                   apiKey]]];
   [request setHTTPMethod:@"PUT"];
   [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
  forHTTPHeaderField:@"Authorization"];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              BOOL added = NO;
                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 200) {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"snippet"]) {
                                    added = YES;
                                 }
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(error, added);
                              });

                          }];
}


- (void)UPDATEPlayList:(NSString *)playlistID withTitle:(NSString *)playlistTitle withDescription:(NSString *)desc andPrivacyStatus:(YTPrivacyStatus)status andHandler:(void (^)(NSError *, BOOL))handler {

   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   NSString * post = [NSString stringWithFormat:@"{\"id\": \"%@\",\"snippet\": {\"title\": \"%@\",\"description\": \"%@\"},\"status\": {\"privacyStatus\": \"%@\"}}",
                                                playlistID,
                                                playlistTitle,
                                                desc,
                                                [self privacyStringFromStatus:status]];
   NSData * postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
   //NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
   NSString * postLength = [NSString stringWithFormat:@"%lu", (unsigned long) [postData length]];

   [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
   [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
   [request setHTTPBody:postData];

   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlists?part=snippet,status&key=%@",
                                                                   apiKey]]];
   [request setHTTPMethod:@"PUT"];
   [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
  forHTTPHeaderField:@"Authorization"];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              BOOL added = NO;
                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 200) {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"snippet"]) {
                                    added = YES;
                                 }
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(error, added);
                              });

                          }];
}


- (void)UPDATEPlayList:(NSString *)playlistID withTitle:(NSString *)playlistTitle andDescription:(NSString *)desc andHandler:(void (^)(NSError *, BOOL))handler {

   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   NSString * post = [NSString stringWithFormat:@"{\"id\": \"%@\",\"snippet\": {\"title\": \"%@\",\"description\": \"%@\"}}",
                                                playlistID,
                                                playlistTitle,
                                                desc];
   NSData * postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
   //NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
   NSString * postLength = [NSString stringWithFormat:@"%lu", (unsigned long) [postData length]];

   [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
   [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
   [request setHTTPBody:postData];

   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlists?part=snippet&key=%@",
                                                                   apiKey]]];
   [request setHTTPMethod:@"PUT"];
   [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
  forHTTPHeaderField:@"Authorization"];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              BOOL added = NO;
                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 200) {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"snippet"]) {
                                    added = YES;
                                 }
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(error, added);
                              });

                          }];
}


- (void)DELETEPlayListItem:(NSString *)itemId withHandler:(void (^)(NSError *, BOOL))handler {

   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlistItems?id=%@&key=%@",
                                                                   itemId,
                                                                   apiKey]]];
   [request setHTTPMethod:@"DELETE"];
   [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
  forHTTPHeaderField:@"Authorization"];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              BOOL added = NO;
                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 204) {
                                 added = YES;
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(error, added);
                              });

                          }];
}


- (void)DELETEPlayList:(NSString *)playlistID withHandler:(void (^)(NSError *, BOOL))handler {

   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/playlists?id=%@&key=%@",
                                                                   playlistID,
                                                                   apiKey]]];
   [request setHTTPMethod:@"DELETE"];
   [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
  forHTTPHeaderField:@"Authorization"];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              BOOL added = NO;
                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 204) {
                                 added = YES;
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(error, added);
                              });

                          }];
}


- (void)DELETESubscription:(NSString *)subscriptionId andHandler:(void (^)(NSError *, BOOL))handler {

   NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
   [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/subscriptions?id=%@&key=%@",
                                                                   subscriptionId,
                                                                   apiKey]]];
   [request setHTTPMethod:@"DELETE"];
   [request setValue:[NSString stringWithFormat:@"Bearer %@",
                                                [MAB_GoogleUserCredentials sharedInstance].token.accessToken]
  forHTTPHeaderField:@"Authorization"];

   NSOperationQueue * queue = [[NSOperationQueue alloc] init];
   [NSURLConnection sendAsynchronousRequest:request
                                      queue:queue
                          completionHandler:^(NSURLResponse * response, NSData * data, NSError * error) {

                              BOOL added = NO;
                              NSHTTPURLResponse * httpresp = (NSHTTPURLResponse *) response;
                              if (httpresp.statusCode == 204) {
                                 added = YES;
                              }
                              else {
                                 NSError * e = nil;
                                 NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:NSJSONReadingMutableContainers
                                                                                         error:&e];
                                 if ([dict objectForKey:@"error"]) {
                                    NSDictionary * dict2 = [dict objectForKey:@"error"];
                                    if ([dict2 objectForKey:@"errors"]) {
                                       NSArray * items = [dict2 objectForKey:@"errors"];
                                       if (items.count > 0) {
                                          NSString * dom = @"YTAPI";
                                          if ([items[0] objectForKey:@"domain"]) {
                                             dom = [items[0] objectForKey:@"domain"];
                                          }
                                          error = [NSError errorWithDomain:dom
                                                                      code:httpresp.statusCode
                                                                  userInfo:items[0]];
                                       }
                                    }
                                 }
                              }
                              dispatch_async(dispatch_get_main_queue(), ^(void) {
                                  handler(error, added);
                              });

                          }];
}


- (NSString *)privacyStringFromStatus:(YTPrivacyStatus)prvStts {

   NSString * retVal = @"public";

   switch (prvStts) {
      case kYTPrivacyStatusPrivate:
         retVal = @"private";
         break;
      case kYTPrivacyStatusUnlisted:
         retVal = @"unlisted";
         break;
      default:
         break;
   }
   return retVal;
}


@end
