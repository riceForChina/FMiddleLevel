//
//  FRegisterHandler.h
//  FMiddleLevel
//
//  Created by FanQiLe on 2021/7/2.
//

#import <Foundation/Foundation.h>
#include <dlfcn.h>
#include <mach-o/getsect.h>


#define FDATA(sectname) __attribute((used, section("__DATA,"#sectname" ")))

#define FService(servicename,impl) \
class MiddleLevel; char * k##servicename##_service FDATA(FServices) = "{ \""#servicename"\" : \""#impl"\"}";

typedef void (^ModuleInfoBlock)(NSMutableArray<NSString *> *info);

@interface FRegisterHandler : NSObject

@property (nonatomic, copy) NSMutableArray *moduleList;

+ (instancetype)shareInstance;

+ (void)readDataFromMachOWithBlock:(ModuleInfoBlock)block;

@end

