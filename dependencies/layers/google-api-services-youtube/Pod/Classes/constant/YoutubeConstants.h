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
#import "GTLYouTubePlaylistItem.h"
#import "GTLYouTubePlaylistItemContentDetails.h"
#import "GTLYouTubeChannelBrandingSettings.h"
#import "GTLYouTubeImageSettings.h"

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
#import "GTLYouTubePlaylistItem.h"


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
#import "MABYT3_Thumbnail.h"
#import "MABYT3_ThumbnailDetails.h"
#import "MABYT3_SearchItem.h"
#include "MABYT3_Activity.h"
#import "MABYT3_Channel.h"



// common
#import <AsyncDisplayKit/AsyncDisplayKit.h>

#endif


// module

//#define YTYouTubeVideo  GTLYouTubeVideo
#define YTYouTubeVideo  MABYT3_Video

#define YTYouTubeChannel  GTLYouTubeChannel
#define YTYouTubeSubscription  GTLYouTubeSubscription
#define YTYouTubePlaylistItem  GTLYouTubePlaylistItem
#define YTYouTubeMABThumbmail  MABYT3_Thumbnail
#define YTYouTubeMABChannel  MABYT3_Channel


//
#define YTServiceYouTube  GTLServiceYouTube
#define YTOAuth2Authentication  GTMOAuth2Authentication




//
#define YTQueryYouTube  GTLQueryYouTube


// different
//#define YTYouTubeSearchResult  GTLYouTubeSearchResult
#define YTYouTubeSearchResult  MABYT3_SearchItem

#define YTYouTubeActivity  MABYT3_Activity














