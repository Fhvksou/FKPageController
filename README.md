# OnePiece
自己学写封装的代码
仿淘宝社区滚动条
使用：
  
    FirstViewController * firstVc = [[FirstViewController alloc]init];
    SecondViewController * secondVc = [[SecondViewController alloc]init];
    ThirdViewController * thirdVc = [[ThirdViewController alloc]init];
    FourthViewController * forthVc = [[FourthViewController alloc]init];
    FifthViewController * fifthVc = [[FifthViewController alloc]init];
    
    PageViewController * viewVc = [[PageViewController alloc]initWithTitleArray:@[@"我的社区",@"穿搭秀",@"全球好货",@"欢乐购",@"去求购"] 
                                                                    andVcArray:@[firstVc,secondVc,thirdVc,forthVc,fifthVc]];

2个数组个数必须相等
不超过6个
