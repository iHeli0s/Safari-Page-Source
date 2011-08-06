#import <UIKit/UIKit.h>
#import <MobileSafari/TabDocument.h>
#import <MobileSafari/BrowserController.h>
#import <MobileSafari/TabController.h>
#import <MobileSafari/BrowserController-BrowserControllerTabs.h>
#import <MobileSafari/BrowserController-BrowserControllerPanels.h>
#define PREFSPATH @"/var/mobile/Library/Preferences/com.fr0zensun.SafariPageSourceSettings.plist"

static NSString *selectedURL;
static int buttonNumber;
@class BrowserController;

TabDocument *active;
%hook PSRootController
%new(v@:)
-(void)SPSOpenTwitter{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://twitter.com/fr0zensun"]];


}
%new(v@:)
-(void)SPSOpenTwitter_2{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://twitter.com/iHeli0s"]];

}

%end

%hook TabController
- (void)setActiveTabDocument:(id)arg1 {
active = arg1;
%orig;
}
%end


%hook ActionPanel
- (void)setVisible:(BOOL)arg1 animate:(BOOL)arg2 {

%orig;
   UIActionSheet *sheet = MSHookIvar<UIActionSheet *>(self, "_sheet"); 

NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:PREFSPATH];
if ([[dict objectForKey:@"SPSEnabled"] boolValue] ||[dict objectForKey:@"SPSEnabled"] == nil )
{
[sheet addButtonWithTitle:@"View Page Source"];
id button = [[sheet buttons] lastObject];
			[[sheet buttons] removeObject:button];			
		sheet.cancelButtonIndex = sheet.numberOfButtons;

			[[sheet buttons] insertObject:button atIndex:sheet.numberOfButtons - 1];
			buttonNumber = sheet.numberOfButtons - 1;

selectedURL = [active URLString];
[sheet layout];


}
[dict release];

}

%new(v@:@i)
- (void)actionSheet:(id)arg1 clickedButtonAtIndex:(int)arg2 {
NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:PREFSPATH];
if ([[dict objectForKey:@"SPSEnabled"] boolValue] ||[dict objectForKey:@"SPSEnabled"] == nil )
{
    if (arg2 == buttonNumber) {
	%class BrowserController;
NSString *path = nil;
	if ([[dict objectForKey:@"simpleEnabled"] boolValue] || [dict objectForKey:@"simpleEnabled"] == nil ) {

path = @"file:///Library/PreferenceBundles/SafariPageSourceSettings.bundle/index_simple.html?url=";
}
else {
path = @"file:///Library/PreferenceBundles/SafariPageSourceSettings.bundle/index.html?url=";


}NSString *finalString = [NSString stringWithFormat:@"%@%@",path,selectedURL];
	id controller = [$BrowserController sharedBrowserController];
	NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:PREFSPATH];
if ([[dict objectForKey:@"SPSOpenInNewWindow"] boolValue] || [dict objectForKey:@"SPSOpenInNewWindow"] == nil)
{
[controller loadURLInNewWindow:[NSURL URLWithString:finalString] animated:YES];
}
else {
	[active loadURL:[NSURL URLWithString:finalString] userDriven:YES];
	}

}
}
%orig;
}

%end





