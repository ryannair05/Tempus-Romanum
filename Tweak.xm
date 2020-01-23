#import <UIKit/UIKit.h>

@interface _UIStatusBarStringView : UILabel
@end

@interface SBUILegibilityLabel : UILabel
-(void)setString:(NSString *)arg1;
@end

BOOL enabled, wantsCoversheet, wants24HourTime;

NSString * convertToRomanString() {
  	NSArray *ones = [NSArray arrayWithObjects: @"", @"I", @"II", @"III", @"IV", @"V", @"VI", @"VII", @"VIII", @"IX", nil];
    NSArray *tens = [NSArray arrayWithObjects: @"", @"X", @"XX", @"XXX", @"XL", @"L", nil];
	NSInteger hour = [[NSCalendar currentCalendar]  component:NSCalendarUnitHour fromDate:[NSDate date]];
	NSInteger minute = [[NSCalendar currentCalendar]  component:NSCalendarUnitMinute fromDate:[NSDate date]];
	if (hour > 12 && !wants24HourTime) hour -= 12;
	return [NSString stringWithFormat:@"%@%@:%@%@", [tens objectAtIndex:hour / 10],[ones objectAtIndex:hour % 10] , [tens objectAtIndex:minute / 10],[ones objectAtIndex: minute % 10]];
}

%hook _UIStatusBarStringView
- (void)setText:(NSString *)text {
	if([text containsString:@":"] && enabled) {
		self.adjustsFontSizeToFitWidth = YES;
		text = convertToRomanString();
    }	
	return %orig;
}
%end

%hook SBFLockScreenDateView
-(void)_updateLabels {
    %orig;
	if (enabled && wantsCoversheet) {
		SBUILegibilityLabel *timeLabel = MSHookIvar<SBUILegibilityLabel *>(self,"_timeLabel");
		timeLabel.adjustsFontSizeToFitWidth = YES;
		[timeLabel setString:convertToRomanString()];
	}
}
%end

void initPrefs() {
	NSString *path = @"/User/Library/Preferences/com.ryannair05.tempusromanumprefs.plist";
	NSString *pathDefault = @"/Library/PreferenceBundles/tempusromanumprefs.bundle/Defaults.plist";
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if (![fileManager fileExistsAtPath:path]) {
		[fileManager copyItemAtPath:pathDefault toPath:path error:nil];
	}
}

void loadPrefs() {
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.ryannair05.tempusromanumprefs.plist"];
	if (prefs) {
		enabled = [[prefs objectForKey:@"enabled"] boolValue];
        wantsCoversheet = [[prefs objectForKey:@"coversheet"] boolValue];
        wants24HourTime = [[prefs objectForKey:@"24hourtime"] boolValue];
	}
}

%ctor {
    @autoreleasepool {
	    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.ryannair05.tempusromanumprefs/prefsupdated"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	    initPrefs();
	    loadPrefs();
		%init;
	}
}
