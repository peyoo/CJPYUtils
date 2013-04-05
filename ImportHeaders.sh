#!/bin/sh

#  ImportHeaders.sh
#  Utils
#
#  Created by 彭 勇 on 13-4-3.
#  Copyright (c) 2013年 cjpystuido. All rights reserved.

rm ./${PRODUCT_NAME}/CJPYUtilsHeaders.h
#find Pods/CJPYUtils -name '*.h' | sed 's/.*\//#import "/; s/\.h/.h"/;' >./Headers.h
find ${PRODUCT_NAME} -name '*.h' | sed 's/.*\//#import "/; s/\.h/.h"/;' >>./${PRODUCT_NAME}/CJPYUtilsHeaders.h