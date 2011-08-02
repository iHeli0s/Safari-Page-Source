#import <Preferences/Preferences.h>

@interface SafariPageSourceSettingsListController: PSListController {
}
@end

@implementation SafariPageSourceSettingsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"SafariPageSourceSettings" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
