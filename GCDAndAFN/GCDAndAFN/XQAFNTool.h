//
//  XQAFNTool.h
//  GCDAndAFN
//
//  Created by 吴晓群 on 16/11/18.
//  Copyright © 2016年 WuXiaoQun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XQAFNTool : NSObject
+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(void(^)(id json))success
     failure:(void(^)(NSError *error))failure;
@end
