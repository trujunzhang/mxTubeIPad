#ifdef __OBJC__

//================================================================================================
// Google-client-api
//================================================================================================
// module
#import "GTLYouTubeChannel.h"
#import "GTLYouTubeSubscription.h"
#import "GTLYouTubeSubscriptionSnippet.h"
#import "GTLYouTubeThumbnailDetails.h"
#import "GTLYouTubeThumbnail.h"
#import "GTLYouTubeChannelSnippet.h"
#import "GTLYouTubeVideo.h"
#import "GTLYouTubeVideoSnippet.h"
#import "GTLYouTubeVideoStatistics.h"

//
#import "GTLUtilities.h"
#import "GTMHTTPUploadFetcher.h"
#import "GTMHTTPFetcherLogging.h"

#import "GTLQueryYouTube.h"
#import "GTLYouTubeSearchListResponse.h"
#import "GTLYouTubeChannel.h"
#import "GTLYouTubeChannelContentDetails.h"
#import "GTLYouTubeSubscriptionListResponse.h"
#import "GTLYouTubePlaylistItemListResponse.h"
#import "GTLYouTubeChannelListResponse.h"
#import "GTLYouTubeSearchResult.h"
#import "GTLYouTubeResourceId.h"

//
#import "GTLServiceYouTube.h"
#import "GTMOAuth2Authentication.h"
#import "GTMOAuth2ViewControllerTouch.h"

//

//================================================================================================
// YouTubeAPI3-Objective-C-wrapper
//================================================================================================
#import "MABYT3_APIRequest.h"

// module
#import "MABYT3_Video.h"
#import "MABYT3_ThumbnailDetails.h"

#endif


//static NSString * apiKey = @"AIzaSyBd9kf5LB41bYWnxI3pfoxHJ2njRvmAA90";
//static NSString * kMyClientID = @"632947002586-hsu569tme6lt8635vvoofi5mnkqfkqus.apps.googleusercontent.com";
//static NSString * kMyClientSecret = @"dHWxjaetid5ckoVMzp0LmzJt";
//static NSString * scope = @"https://www.googleapis.com/auth/youtube https://www.googleapis.com/auth/youtube.readonly https://www.googleapis.com/auth/youtubepartner https://www.googleapis.com/auth/youtubepartner-channel-audit https://www.googleapis.com/auth/youtube.upload";

static NSString * kKeychainItemName = @"mxyoutube";

static NSUInteger search_maxResults = 15;

typedef NS_ENUM (NSUInteger, YTSegmentItemType) {
   YTSegmentItemVideo,
   YTSegmentItemChannel,
   YTSegmentItemPlaylist
};


// module

//#define YTYouTubeVideo  GTLYouTubeVideo
#define YTYouTubeVideo  MABYT3_Video

#define YTYouTubeChannel  GTLYouTubeChannel
#define YTYouTubeSubscription  GTLYouTubeSubscription

//
#define YTServiceYouTube  GTLServiceYouTube
#define YTOAuth2Authentication  GTMOAuth2Authentication



//
#define YTQueryYouTube  GTLQueryYouTube


// different
//#define YTYouTubeSearchResult  GTLYouTubeSearchResult
#define YTYouTubeSearchResult  MABYT3_SearchItem









