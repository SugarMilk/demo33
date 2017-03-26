//
//  GFPersistenceConfig.h
//  GFPersistence
//
//  Created by huangjian on 17/3/14.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#ifndef GFPersistenceConfig_h
#define GFPersistenceConfig_h

//trykey kBJ_Keychain_trykey
static NSString * kGFKeychain_trykey = @"trykey";

//macKeyName 适应老版本 kBJ_Keychain_mac
static NSString * kGFKeychain_mac = @"idfa.name";

//guidKeyName 适应老版本 kBJ_Keychain_Old_guid
static NSString * kGFKeychain_oldGuid = @"name";

//trykey.name 适应老版本 kBJ_Keychain_Old_tryKey
static NSString * kGFKeychain_oldTryKey = @"trykey.name";

//新版本补单升级判断字段 kBJ_Keychain_Is_New_Supplement
static NSString * kGFKeychain_isNewSupplement = @"newSupplement";

//内购keychain存储字段 kBJ_Keychain_Payment_*
static NSString * kGFKeychain_Payment_storeKey = @"payios9keychain";
static NSString * kGFKeychain_Payment_transactionId = @"transactionId";
static NSString * kGFKeychain_Payment_receipt = @"receipt";
static NSString * kGFKeychain_Payment_finishTransaction = @"finishTransaction";
static NSString * kGFKeychain_Payment_productID = @"item";
static NSString * kGFKeychain_Payment_itemNum = @"itemnum";
static NSString * kGFKeychain_Payment_appSid = @"appsid";
static NSString * kGFKeychain_Payment_roleID = @"ext";
static NSString * kGFKeychain_Payment_uid = @"uid";
static NSString * kGFKeychain_Payment_vtime = @"vtime";

//sdk url kBJ_Keychain_SDK_Url
static NSString * kGFKeychain_sdkURL = @"sdkUrl";

//imprest url kBJ_Keychain_imprest_Url
static NSString * kGFKeychain_imprestURL = @"imprestUrl";

/* 平台帐号信息缓存本地图片，返回 UIImage kBJ_Head_Image */
static NSString * kGFSandbox_headImage = @"headImage";

/* 提交问题信息缓存本地图片，返回 UIImage kBJ_SubmitQuestion_Image */
static NSString * kGFSandbox_submitQuestionImage = @"submitQuestionImage";

/* 平台帐号信息待上传缓存本地图片，返回 UIImage kBJ_Upload_Head_Image */
static NSString * kGFSandbox_uploadHeadImage = @"uploadHeadImage";

/* 客服聊天追加消息缓存本地图片，返回 UIImage kBJ_Upload_AppendQuestion_Image */
static NSString * kGFSandbox_uploadAppendQuestionImage = @"appendImage";

/* FAQ缓存本地JSON文件，返回 NSDictionary  kBJ_FAQ_Dictionary */
static NSString * kGFSandbox_FAQDictionary = @"faq";

/* 旧版XML缓存本地文件，返回 NSDictionary kBJ_OLD_XML */
static NSString * kGFSandbox_oldXML = @"gfconfig";

/* uuid kBJ_UserDefaults_uuid */
static NSString * kGFUserDefaults_uuid = @"uuid";

/* 旧版数据 userList kBJ_UserDefaults_UserList_Old */
static NSString * kGFUserDefaults_userListOld = @"storage_account";

/* 旧版数据 usernameList  kBJ_UserDefaults_UsernameList_Old */
static NSString * kGFUserDefaults_usernameListOld = @"storage_account_time";

/* userList 2.0初版数据 kBJ_UserDefaults_userList_2 */
static NSString * kGFUserDefaults_userList2 = @"userList";

/* userNameList  2.0初版数据 列表用 kBJ_UserDefaults_userNameList_2 */
static NSString * kGFUserDefaults_userNameList2 = @"userNameList";

/* userList 新版最终帐号缓存数据 kBJ_UserDefaults_UserList_New */
static NSString * kGFUserDefaults_userListNew = @"userList_new";

/* token kBJ_UserDefaults_token */
static NSString * kGFUserDefaults_token = @"token";

/* faq ver kBJ_UserDefaults_faqver */
static NSString * kGFUserDefaults_faqver = @"faqver";

/* customAccountInfo  kBJ_UserDefaults_customAccountInfo */
static NSString * kGFUserDefaults_customAccountInfo  = @"customAccountInfo";

/* 指定uid查询离线消息事件的key，同时也是key的后缀  kBJ_UserDefaults_lastReqForMsgTimeSuffix */
static NSString * kGFUserDefaults_lastReqForMsgTimeSuffix = @"_lastReqForMsgTime";

/* 指定uid未验证邮箱的key，同时也是key的后缀  kBJ_UserDefaults_UnCheckEmailSuffix */
static NSString * kGFUserDefaults_unCheckEmailSuffix = @"_unCheckEmail";

/* bindMobileInfo kBJ_UserDefaults_bindMobileInfoKey */
static NSString * kGFUserDefaults_bindMobileInfoKey = @"bindMobileInfo";

/* realNameAuthenticationInfo kBJ_UserDefaults_realNameAuthenticationInfoKey */
static NSString * kGFUserDefaults_realNameAuthenticationInfoKey = @"realNameAuthenticationInfo";

/* 数据是否已升级 kBJ_Data_isUpdate */
static NSString * kGFUserDefaults_dataIsUpdate = @"dataIsUpdate";

#endif /* GFPersistenceConfig_h */
