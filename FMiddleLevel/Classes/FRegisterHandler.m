//
//  FRegisterHandler.m
//  FMiddleLevel
//
//  Created by FanQiLe on 2021/7/2.
//

#import "FRegisterHandler.h"
#include <mach-o/getsect.h>
#include <mach-o/loader.h>
#include <mach-o/dyld.h>
#include <dlfcn.h>
#import <objc/runtime.h>
#import <objc/message.h>
#include <mach-o/ldsyms.h>

#define FServiceSectName "FServices"


NSArray<NSString *>* BHReadConfiguration(char *sectionName,const struct mach_header *mhp);
static void dyld_callback(const struct mach_header *mhp, intptr_t vmaddr_slide)
{
  
    //register services
    NSArray<NSString *> *services = BHReadConfiguration(FServiceSectName,mhp);
    for (NSString *map in services) {
        NSData *jsonData =  [map dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        id json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if (!error) {
            if ([json isKindOfClass:[NSDictionary class]] && [json allKeys].count) {
                NSString *key = [json allKeys][0];
                NSString *value  = [json allValues][0];
                [[FRegisterHandler shareInstance].moduleList addObject:[NSString stringWithFormat:@"%@.%@",key,value]];
            }
        }
    }
    
}

NSArray<NSString *>* BHReadConfiguration(char *sectionName,const struct mach_header *mhp)
{
    NSMutableArray *configs = [NSMutableArray array];
    unsigned long size = 0;
#ifndef __LP64__
    uintptr_t *memory = (uintptr_t*)getsectiondata(mhp, SEG_DATA, sectionName, &size);
#else
    const struct mach_header_64 *mhp64 = (const struct mach_header_64 *)mhp;
    uintptr_t *memory = (uintptr_t*)getsectiondata(mhp64, SEG_DATA, sectionName, &size);
#endif
    
    unsigned long counter = size/sizeof(void*);
    for(int idx = 0; idx < counter; ++idx){
        char *string = (char*)memory[idx];
        NSString *str = [NSString stringWithUTF8String:string];
        if(!str)continue;
        if(str) [configs addObject:str];
    }
    
    return configs;
}

@interface FRegisterHandler ()


@end

@implementation FRegisterHandler

+ (instancetype)shareInstance
{
    static dispatch_once_t p;
    static id temp = nil;
    
    dispatch_once(&p, ^{
        temp = [[self alloc] init];
    });
    
    return temp;
}

-(NSMutableArray *)moduleList{
    if (!_moduleList) {
        _moduleList = [NSMutableArray array];
    }
    return _moduleList;
}

+ (void)readDataFromMachOWithBlock:(ModuleInfoBlock)block{
    [FRegisterHandler shareInstance].moduleList = nil;
    _dyld_register_func_for_add_image(dyld_callback);
    block([FRegisterHandler shareInstance].moduleList);
}

@end
