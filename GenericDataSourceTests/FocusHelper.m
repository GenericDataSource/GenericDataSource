//
//  FocusHelper.m
//  GenericDataSourceTests
//
//  Created by Mohamed Afifi on 10/8/17.
//  Copyright © 2017 mohamede1945. All rights reserved.
//

#import "FocusHelper.h"
#import <objc/runtime.h>

@implementation FocusHelper

+ (void)DumpObjcMethods:(Class) clz {

    unsigned int methodCount = 0;
    Method *methods = class_copyMethodList(clz, &methodCount);

    printf("Found %d methods on '%s'\n", methodCount, class_getName(clz));

    for (unsigned int i = 0; i < methodCount; i++) {
        Method method = methods[i];

        printf("\t'%s' has method named '%s' of encoding '%s'\n",
               class_getName(clz),
               sel_getName(method_getName(method)),
               method_getTypeEncoding(method));

        /**
         *  Or do whatever you need here...
         */
    }

    free(methods);
}

@end
