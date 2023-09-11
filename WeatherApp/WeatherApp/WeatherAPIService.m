//
//  WeatherAPIService.m
//  WeatherApp
//
//  Created by soujanya Balusu on 11/09/23.
//

#import "WeatherAPIService.h"
#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@implementation WeatherAPIService

- (void)fetchWeatherDataForUrl:(NSString *)forUrl completion:(void (^)(NSDictionary * _Nullable, NSError * _Nullable))completion {
    
    // Make the GET request using Alamofire
    [[AFHTTPSessionManager manager] GET:forUrl
                              parameters:nil
                                 headers:nil
                                progress:nil
                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                     // Handle the API response here
                                     if (completion) {
                                         completion(responseObject, nil);
                                     }
                                 }
                                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                     // Handle any errors here
                                     if (completion) {
                                         completion(nil, error);
                                     }
                                 }];
}

@end
