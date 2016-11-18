//
//  XQAFNTool.m
//  GCDAndAFN
//
//  Created by 吴晓群 on 16/11/18.
//  Copyright © 2016年 WuXiaoQun. All rights reserved.
//

#import "XQAFNTool.h"
#import "AFNetworking.h"

@implementation XQAFNTool
+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(void(^)(id json))success
     failure:(void(^)(NSError *error))failure
{
    //创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"2" forHTTPHeaderField:@"User_Agent"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain", nil];
    
    //2发送请求
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)     {
        if (success)
        {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure)
        {
            failure(error);
        }
    }];
}
@end
