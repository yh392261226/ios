//
//  BYesWorkerViewController.m
//  worker
//
//  Created by 郭健 on 2017/9/14.
//  Copyright © 2017年 郭健. All rights reserved.
//

#import "BYesWorkerViewController.h"
#import "PartyInfoViewController.h"
#import "PartyBdismissViewController.h"
#import "BYesOrNoViewController.h"
#import "PartyBcommentViewController.h"
#import "PartyBinfoViewController.h"
#import "PartyBdismissViewController.h"

@interface BYesWorkerViewController ()<BMKLocationServiceDelegate, BMKMapViewDelegate>
{
    NSMutableArray *dataArray;
    
    UIView *backview;
    
    UIButton *icon;   //头像
    UILabel *name;     //名字
    UIImageView *sex;   //性别
    UILabel *workerType;   //工人状态
    UILabel *worker;    //工种
    UIButton *call;     //电话按钮
    
    UIImageView *red;   //红点
    UIImageView *blue;  //蓝点
    UIImageView *organer;  //黄点
    UIImageView *green;   //绿点
    
    UILabel *redLab;   //红点右面的文字
    UILabel *blueLab;  //蓝点右面的文字
    UILabel *organerLab;   //黄点右面的文字
    UILabel *greenLab;  //绿点右面的文字
    
    UILabel *bluelLabTo;
    
    
    UILabel *noLab;   //
    UIButton *noBtn;  //不想干了按钮
   
    
    
    UILabel *time;   //时间字样
    
    
    NSString *Xmap;
    NSString *Ymap;
    
    NSString *phone;
    
    NSMutableArray *skillsArr;
    
    
    NSMutableArray *bijiaoS;
    
    NSString *guzhuID;
    
    
    NSString *skillsName;   //工种中文字样
    
    
    
    NSString *iconStr;  //头像字符串
    NSString *sex1;
    
    NSString *haopingNUm ;  //传给下一页
}

@property (nonatomic, strong)BMKMapView *mapView;
@property (nonatomic, strong)BMKLocationService *locService;

@end

@implementation BYesWorkerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    dataArray = [NSMutableArray array];
    skillsArr = [NSMutableArray array];
    
    [self getdataSkills];
    
    [self getdata];
    
    
    [self addhead:@"已开工"];
    
    [self initUI];
    
    [self initMapView];
    
    
}

- (void)temp
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)initUI
{
    
    backview = [[[NSBundle mainBundle] loadNibNamed:@"Empty" owner:self options:nil] objectAtIndex:4];
    
    [self.view addSubview:backview];
    
    [backview mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.bottom.mas_equalTo(self.view).offset(0);
         make.left.mas_equalTo(self.view).offset(0);
         make.right.mas_equalTo(self.view).offset(0);
         make.height.mas_equalTo(238);
     }];
    
    
    icon = [backview viewWithTag:1001];
    icon.layer.cornerRadius = 35;
    icon.layer.masksToBounds = YES;
    icon.backgroundColor = [UIColor orangeColor];
    [icon addTarget:self action:@selector(detailBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    name = [backview viewWithTag:1002];
    
    
    
    sex = [backview viewWithTag:1003];
    sex.image = [UIImage imageNamed:@"job_woman"];
    
    
    
    
    workerType = [backview viewWithTag:1004];
    workerType.text = @"工作中";
    workerType.layer.masksToBounds = YES;
    workerType.layer.cornerRadius = 5;
    workerType.backgroundColor = [UIColor redColor];
    workerType.textAlignment = NSTextAlignmentCenter;
    workerType.textColor = [UIColor whiteColor];
    workerType.font = [UIFont systemFontOfSize:14];
    
    
    worker = [backview viewWithTag:1005];
    worker.textColor = [UIColor grayColor];
    
    
    call = [backview viewWithTag:1006];
    [call addTarget:self action:@selector(callBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    red = [backview viewWithTag:1007];
    red.layer.masksToBounds = YES;
    red.layer.cornerRadius = 7.5;
    red.backgroundColor = [UIColor redColor];
    
    
    redLab = [backview viewWithTag:1008];
    //   redLab.text = @"";
    // redLab.textColor = [UIColor grayColor];
    redLab.font = [UIFont systemFontOfSize:15];
    
    organer = [backview viewWithTag:1009];
    organer.backgroundColor = [UIColor orangeColor];
    organer.layer.masksToBounds = YES;
    organer.layer.cornerRadius = 7.5;
    
    
    organerLab = [backview viewWithTag:1010];
    // organerLab.text = @"";
    
    organerLab.font = [UIFont systemFontOfSize:15];
    
    
    green = [backview viewWithTag:1011];
    green.layer.masksToBounds = YES;
    green.layer.cornerRadius = 7.5;
    green.backgroundColor = [UIColor greenColor];
    
    greenLab = [backview viewWithTag:1012];
    //  greenLab.text = @"";
    //  greenLab.textColor = [UIColor grayColor];
    greenLab.font = [UIFont systemFontOfSize:15];
    
    
    blue = [backview viewWithTag:1013];
    blue.layer.masksToBounds = YES;
    blue.layer.cornerRadius = 7.5;
    blue.backgroundColor = [UIColor blueColor];
    
    blueLab = [backview viewWithTag:1014];
    // blueLab.text = @"";
    //  greenLab.textColor = [UIColor grayColor];
    blueLab.font = [UIFont systemFontOfSize:15];
    
    
    bluelLabTo = [backview viewWithTag:1015];
    bluelLabTo.text = @"开原街  距离我0.9钱蜜蜜";
    bluelLabTo.textColor = [UIColor grayColor];
    bluelLabTo.font = [UIFont systemFontOfSize:15];
    
    
    noLab = [backview viewWithTag:1016];
    
    
    
    
    noBtn = [backview viewWithTag:1017];
    [noBtn addTarget:self action:@selector(nobtn) forControlEvents:UIControlEventTouchUpInside];
    [noBtn setTitle:@"不想干了" forState:UIControlStateNormal];
    noBtn.layer.cornerRadius = 6;
    noBtn.backgroundColor = [myselfway stringTOColor:@"0x249CD3"];
    

    
    
    time = [backview viewWithTag:2000];
    
    time.layer.borderColor = [myselfway stringTOColor:@"0x249CD3"].CGColor;
    time.layer.borderWidth = 1;
    time.font = [UIFont systemFontOfSize:15];
    time.text = @"2017年10月4号开工";
    time.textAlignment = NSTextAlignmentCenter;
    time.textColor = [myselfway stringTOColor:@"0x249CD3"];
    
    
}





//加载百度地图
- (void)initMapView
{
    
    self.mapView = [[BMKMapView alloc] init];
    
    self.mapView.delegate = self;
    
    self.mapView.showsUserLocation = YES;
    
    self.mapView.zoomLevel = 15;
    
    [_mapView setMapType:BMKMapTypeStandard];
    
    //设置地图上是否显示比例尺
    //   self.mapView.showMapScaleBar = NO;
    
    //设置地图比例尺在地图上的位置
    self.mapView.mapScaleBarPosition = CGPointMake(200, 100);
    
    //开启路况
    [_mapView setTrafficEnabled:YES];
    
    //添加到view上
    [self.view addSubview:self.mapView];
    
    
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.mas_equalTo(self.view).offset(64);
         make.left.mas_equalTo(self.view).offset(0);
         make.right.mas_equalTo(self.view).offset(0);
         make.bottom.mas_equalTo(backview).offset(-240);
     }];
    
    
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    
    // annotationV.image = [UIImage imageNamed:@"5ud.png"];//大头针的显示图片
    CLLocationCoordinate2D coor;
    coor.latitude = [Ymap doubleValue];
    coor.longitude = [Xmap doubleValue];
    
    annotation.coordinate = coor;
    
    self.mapView.centerCoordinate = annotation.coordinate;
    
    [self.mapView addAnnotation:annotation];
    
    
    
    
}




- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]])
    {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    
    return nil;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.mapView viewWillAppear];
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil; // 不用时，置nil
}






//头像按钮， 进入工人详情
- (void)detailBtn
{
    
    PartyBinfoViewController *temp = [[PartyBinfoViewController alloc] init];
    
    temp.u_id = guzhuID;
    
    [self.navigationController pushViewController:temp animated:YES];
    
    
//    PartyInfoViewController *temp = [[PartyInfoViewController alloc] init];
//    
//    [self.navigationController pushViewController:temp animated:YES];
}




//拨打电话按钮
- (void)callBtn
{
    
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@",phone];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}




//不想干了按钮
- (void)nobtn
{
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"请与雇主先进行沟通再进行此项操作" message:@"当日辞职，雇主不需要支付您当日工资\n建议今日工作完毕后，明天再辞职" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"再考虑考虑" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *yAction = [UIAlertAction actionWithTitle:@"我不干了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        
        PartyBdismissViewController *temp = [[PartyBdismissViewController alloc] init];

        AWorKeDataModel *model = [dataArray objectAtIndex:0];
        
    //  AListDataModel *info = [model.ordersArray objectAtIndex:0];
        
        temp.u_id = guzhuID;
        temp.t_id = model.t_id;
        temp.s_id = model.tew_skills;
        temp.tew_id = model.tew_id;
        
        temp.icon = iconStr;
        temp.name = name.text;
        temp.sex = sex1;
        temp.workerName = skillsName;
        temp.haoping = haopingNUm;
        
        [self.navigationController pushViewController:temp animated:YES];
        
//        [noBtn setTitle:@"已发送辞职通知" forState:UIControlStateNormal];
//
//        noBtn.backgroundColor = [UIColor grayColor];
//
//        noBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//
//        noBtn.userInteractionEnabled = NO;
        
        
    }];
    
    
    [alertcontroller addAction:action];
    [alertcontroller addAction:yAction];
    
    [self presentViewController:alertcontroller animated:YES completion:nil];
    
}


//- (void)infoYse
//{
//    [SVProgressHUD dismiss];
//}




- (void)getdata
{
    //t_id   传过来的   self.t_id
    NSString *url = [NSString stringWithFormat:@"%@Tasks/index?action=info&t_id=%@", baseUrl, self.t_id];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSDictionary *dic = [dictionary objectForKey:@"data"];
             
             ABigDataModel *data = [[ABigDataModel alloc] init];
             
             data.t_id = [dic objectForKey:@"t_id"];
             data.t_title = [dic objectForKey:@"t_title"];
             data.t_info = [dic objectForKey:@"t_info"];
             data.t_amount = [dic objectForKey:@"t_amount"];
             data.t_duration = [dic objectForKey:@"t_duration"];
             data.t_edit_amount = [dic objectForKey:@"t_edit_amount"];
             data.t_amount_edit_times = [dic objectForKey:@"t_amount_edit_times"];
             data.t_posit_x = [dic objectForKey:@"t_posit_x"];
             data.t_posit_y = [dic objectForKey:@"t_posit_y"];
             data.t_author = [dic objectForKey:@"t_author"];
             data.t_in_time = [dic objectForKey:@"t_in_time"];
             data.t_last_edit_time = [dic objectForKey:@"t_last_edit_time"];
             data.t_last_editor = [dic objectForKey:@"t_last_editor"];
             data.t_status = [dic objectForKey:@"t_status"];
             data.t_phone = [dic objectForKey:@"t_phone"];
             data.t_phone_status = [dic objectForKey:@"t_phone_status"];
             data.t_type = [dic objectForKey:@"t_type"];
             data.t_storage = [dic objectForKey:@"t_storage"];
             data.bd_id = [dic objectForKey:@"bd_id"];
             data.t_desc = [dic objectForKey:@"t_desc"];
             data.t_workers = [dic objectForKey:@"t_workers"];
             data.t_adree = [dic objectForKey:@"tew_address"];
             data.u_mobile = [dic objectForKey:@"u_mobile"];
             data.u_img = [dic objectForKey:@"u_img"];
             data.u_sex = [dic objectForKey:@"u_sex"];
             data.u_true_name = [dic objectForKey:@"u_true_name"];
             data.relation = [dic objectForKey:@"relation"];
             data.relation_type = [dic objectForKey:@"relation_type"];
             
             data.u_high_opinions = [dic objectForKey:@"u_high_opinions"];
             
             haopingNUm = data.u_high_opinions;
             
             guzhuID = data.t_author;
             Xmap = data.t_posit_x;
             Ymap = data.t_posit_y;
             phone = data.t_phone;
             
             
             iconStr = data.u_img;
             sex1 = data.u_sex;
             
             
             NSURL *url = [NSURL URLWithString:data.u_img];
             [icon sd_setBackgroundImageWithURL:url forState:UIControlStateNormal];
             
             name.text = data.u_true_name;
             
             if ([data.u_sex isEqualToString:@"0"])
             {
                 sex.image = [UIImage imageNamed:@"job_woman"];
             }
             else if ([data.u_sex isEqualToString:@"1"])
             {
                 sex.image = [UIImage imageNamed:@"job_man"];
             }
             
             
             [self initMapView];
             
             
             for (int i = 0; i < data.t_workers.count; i++)
             {
                 
                 AWorKeDataModel *info = [[AWorKeDataModel alloc] init];
                 
                 NSDictionary *dic1 = [data.t_workers objectAtIndex:i];
                 
                 info.tew_id = [dic1 objectForKey:@"tew_id"];
                 info.t_id = [dic1 objectForKey:@"t_id"];
                 info.tew_skills = [dic1 objectForKey:@"tew_skills"];
                 info.tew_worker_num = [dic1 objectForKey:@"tew_worker_num"];
                 info.tew_price = [dic1 objectForKey:@"tew_price"];
                 info.tew_start_time = [dic1 objectForKey:@"tew_start_time"];
                 info.tew_end_time = [dic1 objectForKey:@"tew_end_time"];
                 info.r_province = [dic1 objectForKey:@"r_province"];
                 info.r_city = [dic1 objectForKey:@"r_city"];
                 info.r_area = [dic1 objectForKey:@"r_area"];
                 info.tew_address = [dic1 objectForKey:@"tew_address"];
                 info.tew_lock = [dic1 objectForKey:@"tew_lock"];
                 info.remaining = [dic1 objectForKey:@"remaining"];
                 info.orders = [dic1 objectForKey:@"orders"];
                 info.ordersArray = [NSMutableArray array];
                 
                 info.ordersArray = [NSMutableArray array];
                 
                 for (int q = 0; q < info.orders.count; q++)
                 {
                     
                     AListDataModel *listModel = [[AListDataModel alloc] init];
                     
                     NSDictionary *ListDic = [info.orders objectAtIndex:q];
                     
                     listModel.o_id = [ListDic objectForKey:@"o_id"];
                     listModel.t_id = [ListDic objectForKey:@"t_id"];
                     listModel.u_id = [ListDic objectForKey:@"u_id"];
                     listModel.o_worker = [ListDic objectForKey:@"o_worker"];
                     listModel.o_amount = [ListDic objectForKey:@"o_amount"];
                     listModel.o_in_time = [ListDic objectForKey:@"o_in_time"];
                     listModel.o_last_edit_time = [ListDic objectForKey:@"o_last_edit_time"];
                     listModel.o_status = [ListDic objectForKey:@"o_status"];
                     listModel.tew_id = [ListDic objectForKey:@"tew_id"];
                     listModel.s_id = [ListDic objectForKey:@"s_id"];
                     listModel.o_confirm = [ListDic objectForKey:@"o_confirm"];
                     listModel.unbind_time = [ListDic objectForKey:@"unbind_time"];
                     listModel.o_pay = [ListDic objectForKey:@"o_pay"];
                     listModel.o_pay_time = [ListDic objectForKey:@"o_pay_time"];
                     listModel.o_sponsor = [ListDic objectForKey:@"o_sponsor"];
                     
                     listModel.u_name = [ListDic objectForKey:@"u_name"];
                     listModel.u_mobile = [ListDic objectForKey:@"u_mobile"];
                     listModel.u_sex = [ListDic objectForKey:@"u_sex"];
                     listModel.u_online = [ListDic objectForKey:@"u_online"];
                     listModel.u_status = [ListDic objectForKey:@"u_status"];
                     listModel.u_task_status = [ListDic objectForKey:@"u_task_status"];
                     listModel.u_start = [ListDic objectForKey:@"u_start"];
                     listModel.u_credit = [ListDic objectForKey:@"u_credit"];
                     listModel.u_jobs_num = [ListDic objectForKey:@"u_jobs_num"];
                     listModel.u_recommend = [ListDic objectForKey:@"u_recommend"];
                     listModel.u_worked_num = [ListDic objectForKey:@"u_worked_num"];
                     listModel.u_high_opinions = [ListDic objectForKey:@"u_high_opinions"];
                     listModel.u_low_opinions = [ListDic objectForKey:@"u_low_opinions"];
                     listModel.u_middle_opinions = [ListDic objectForKey:@"u_middle_opinions"];
                     listModel.u_dissensions = [ListDic objectForKey:@"u_dissensions"];
                     listModel.u_true_name = [ListDic objectForKey:@"u_true_name"];
                     listModel.u_img = [ListDic objectForKey:@"u_img"];
                     
                     
                     
                     //找到自己的订单，加在任务里
                     if ([listModel.o_worker isEqualToString:user_ID])
                     {
                         [info.ordersArray addObject:listModel];
                         [dataArray addObject:info];
                     }
                     
                     
                 }
                 
                 
                 
                 
                 
                 
                 
             }
             
             
             // 防止崩溃
             if (dataArray.count > 0)
             {
                 [self initDataUi];
             }
             
             
         }
         
     }
         failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}



//制作ui数据
- (void)initDataUi
{
    AWorKeDataModel *model = [dataArray objectAtIndex:0];
    
    AListDataModel *info = [model.ordersArray objectAtIndex:0];
    
    blueLab.text = model.tew_address;
    
    NSString *start = [myselfway timeWithTimeIntervalString:model.tew_start_time];
    NSString *end = [myselfway timeWithTimeIntervalString:model.tew_end_time];
    
    greenLab.text = [NSString stringWithFormat:@"工期:%@ 一 %@", start, end];
    
    organerLab.text = [NSString stringWithFormat:@"%@元/天", info.o_amount];
    
    
    for (int j = 0; j < skillsArr.count; j++)
    {
        AworkerListData *val = [skillsArr objectAtIndex:j];
        
        if ([val.s_id isEqualToString:model.tew_skills])
        {
            skillsName = val.s_name;
        }
        
    }
    
    greenLab.font = [UIFont systemFontOfSize:11];
    
    redLab.text = [NSString stringWithFormat:@"招%@%@人", skillsName, model.tew_worker_num];
    
    
}









- (void)getdataSkills
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@", baseUrl, @"Skills/index"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         
         if ([[dictionary objectForKey:@"code"] integerValue] == 200)
         {
             NSArray *arr = [dictionary objectForKey:@"data"];
             
             for (int i = 0; i < arr.count; i++)
             {
                 NSDictionary *dic = [arr objectAtIndex:i];
                 
                 AworkerListData *data = [[AworkerListData alloc] init];
                 
                 data.s_id = [dic objectForKey:@"s_id"];
                 data.s_desc = [dic objectForKey:@"s_desc"];
                 data.s_info = [dic objectForKey:@"s_info"];
                 data.s_name = [dic objectForKey:@"s_name"];
                 data.s_status = [dic objectForKey:@"s_status"];
                 
                 [skillsArr addObject:data];
                 
                 
             }
             
             
             
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
     }];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}









@end
