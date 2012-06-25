/*
 * Settings.m
 *
 * This file is a part of the Yandex Map Kit.
 *
 * Version for iOS © 2011 YANDEX
 * 
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at http://legal.yandex.ru/mapkit/
 */

#import "Settings.h"

static NSString * const kYandexMapKitApiKey = @"YandexMapKitApiKey";

@implementation Settings

@dynamic apiKey;


static Settings *sharedSettings = nil;

+ (Settings *)sharedSettings {
    @synchronized(self) {
        if (!sharedSettings) {
            sharedSettings = [self new];
        }
    }
    return sharedSettings;
}

- (NSString *)apiKey {
    return [[NSUserDefaults standardUserDefaults] stringForKey:kYandexMapKitApiKey];
}

- (void)setApiKey:(NSString *)apiKey {
    [[NSUserDefaults standardUserDefaults] setValue:apiKey forKey:kYandexMapKitApiKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
