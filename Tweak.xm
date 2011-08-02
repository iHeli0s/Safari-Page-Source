#import <UIKit/UIKit.h>
#import <MobileSafari/TabDocument.h>
#import <MobileSafari/BrowserController.h>
#import <MobileSafari/TabController.h>
#import <MobileSafari/BrowserController-BrowserControllerTabs.h>
#import <MobileSafari/BrowserController-BrowserControllerPanels.h>
#define PREFSPATH @"/var/mobile/Library/Preferences/com.fr0zensun.SafariPageSourceSettings.plist"

static NSString *selectedURL;
static int buttonNumber;
id linkSheet;
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
%hook UIActionSheet

-(void)presentSheetInView:(id)view { 
NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:PREFSPATH];
if ([[dict objectForKey:@"SPSEnabled"] boolValue])
{
		if(self.numberOfButtons > 4 && self != linkSheet) {
[self addButtonWithTitle:@"View Page Source"];
id button = [[self buttons] lastObject];
			[[self buttons] removeObject:button];			
		self.cancelButtonIndex = self.numberOfButtons;

			[[self buttons] insertObject:button atIndex:self.numberOfButtons - 1];
			buttonNumber = self.numberOfButtons - 1;

selectedURL = [active URLString];

}
}
[dict release];

%orig;

}





%end
%hook TabController
- (void)setActiveTabDocument:(id)arg1 {
active = arg1;
%orig;
}


%end
%hook UIWebDocumentView

-(void)actionSheet:(id)sheet clickedButtonAtIndex:(int)index {
if (index == buttonNumber) {
NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:PREFSPATH];
if ([[dict objectForKey:@"SPSEnabled"] boolValue])
{	
%class BrowserController;

NSString *path = nil;
	if ([[dict objectForKey:@"simpleEnabled"] boolValue]) {

path = @"file:///Library/PreferenceBundles/SafariPageSourceSettings.bundle/index_simple.html?url=";
}
else {
path = @"file:///Library/PreferenceBundles/SafariPageSourceSettings.bundle/index.html?url=";


}
NSString *finalString = [NSString stringWithFormat:@"%@%@",path,selectedURL];
	id controller = [$BrowserController sharedBrowserController];
	NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:PREFSPATH];
if ([[dict objectForKey:@"SPSOpenInNewWindow"] boolValue])
{
[controller loadURLInNewWindow:[NSURL URLWithString:finalString] animated:YES];
}
else {
	[active loadURL:[NSURL URLWithString:finalString] userDriven:YES];
	}

}
[dict release];



}

%orig;		

}
%end


%hook ActionPanel


%new(v@:@i)
- (void)actionSheet:(id)arg1 clickedButtonAtIndex:(int)arg2 {
NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:PREFSPATH];
if ([[dict objectForKey:@"SPSEnabled"] boolValue])
{
    if (arg2 == buttonNumber) {
	%class BrowserController;
NSString *path = nil;
	if ([[dict objectForKey:@"simpleEnabled"] boolValue]) {

path = @"file:///Library/PreferenceBundles/SafariPageSourceSettings.bundle/index_simple.html?url=";
}
else {
path = @"file:///Library/PreferenceBundles/SafariPageSourceSettings.bundle/index.html?url=";


}NSString *finalString = [NSString stringWithFormat:@"%@%@",path,selectedURL];
	id controller = [$BrowserController sharedBrowserController];
	NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:PREFSPATH];
if ([[dict objectForKey:@"SPSOpenInNewWindow"] boolValue])
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

%end;