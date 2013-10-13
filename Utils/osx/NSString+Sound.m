//
//  NSString+Sound.m
//  Utils
//
//  Created by cjpystudio on 13-10-6.
//  Copyright (c) 2013年 cjpystuido. All rights reserved.
//

#import "NSString+Sound.h"

@implementation NSString (Sound)

+ (NSArray *)allSound {
    static NSMutableArray *allSounds;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        allSounds = [[NSMutableArray alloc] init];
        NSArray *knownSoundTypes = [NSSound soundUnfilteredTypes];
        NSArray *libs = NSSearchPathForDirectoriesInDomains(
                                                            NSLibraryDirectory,
                                                            NSUserDomainMask | NSLocalDomainMask | NSSystemDomainMask,
                                                            YES);
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSWorkspace *workspace = [NSWorkspace sharedWorkspace];
        for (NSString *folder in libs) {
            NSString *folderName = [folder stringByAppendingPathComponent:@"Sounds"];
            BOOL isDir;
            if ([fileManager fileExistsAtPath:folderName isDirectory:&isDir] && isDir) {
                for (NSString *file in [fileManager contentsOfDirectoryAtPath:folderName error:nil]) {
                    NSString *absoluteFile = [folderName stringByAppendingPathComponent:file];
                    NSString *fileType = [workspace typeOfFile:absoluteFile error:nil];
                    if (fileType && [knownSoundTypes containsObject:fileType]) {
                        [allSounds addObject:[file stringByDeletingPathExtension]];
                    }
                }
            }
        }
    });
    
    return allSounds;
}
@end
