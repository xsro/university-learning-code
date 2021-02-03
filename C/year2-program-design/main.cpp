#include<stdio.h>
#include<time.h>
#include<stdlib.h>
#include<string.h>
#include<conio.h>
//宏定义
#define N_seat 3 
#define N_station 6 
#define N_rail 10
#define N_rec 12
#define N_user 10
#define YEAR   2019
#define N_password 20
#define N_train 1000
//定义结构体
typedef struct User  //用户或管理员信息 
{
	char name[20];//账号名 
	char password[N_password];//密码 
	char realname[20];//真实姓名 
	int number;//身份证号 
	int identity;  //身份，使用1表示普通用户，2表示管理员，3表示VIP 0表示非法用户 ,4表示游客； 
}User; 
typedef struct time  //日期时间 结构体 
{
	int year;
	int month;
	int day;
	int hour;
	int minute;
}Time;
typedef struct station//存储站点信息 
{
	char name[40];//站点名字 
	int a;//列车到站时间 
	int b;//列车离开站点的时间 
	int price[N_seat]; //各种类型座位的价格 
}Station;
typedef struct rail
{
	char type;//类型 
    int  number;//线路编号 
    int n_station;//经过的站点总数 
	int n_seat;//支持的座位类型总数 
	struct station sta[N_station];//站点信息 
	int tt;//总票数 
}Rail;
typedef struct train{
	int no; //运行编号 
	char type;//类型 
	int number;//路线编号 
	int t;//始发时间 
	int bt;//已经订购的票数 
	int tt;//总票数 
//	int ticket[N_seat];
//	int total[N_seat];
}Train;
typedef struct record//记录乘车信息的结构体 
{
	char name[40];//乘客的身份证件号码 
	int No;//线路 
	int station1;//出发站 
	int station2; //到达站点 
	int t1;//火车到达出发地时间 
	int t2;	//火车到达目的地时间 
	char sta1[20];
	char sta2[20];
}Rec;
//结构体处理函数 
Time timeGet(int i)//i为0时获取当前时间，为1时从键盘获取时间 ,2仅仅输入年月日 ,3获取当前年月日 ，4输入日时分 
{
	Time a;
	time_t timep; 
	struct tm *p;
	time (&timep);  
    p=gmtime(&timep);
	if(i==0)
	{
	 a.minute=p->tm_min;
	 a.hour=8+p->tm_hour;
	 a.month=1+p->tm_mon;
	 a.year=1900+p->tm_year;
	 a.day=p->tm_mday;	
	}
	 if(i==1)
	 {
	 	printf("\t请按照x年x月x日 x时x分的形式输入对应的数字\n\t");scanf("%d%d%d%d%d",&a.year,&a.month,&a.day,&a.hour,&a.minute);
	 }
	 if(i==2) 
	 {
	 	a.minute=0;a.hour=0;
		printf("\t请按照x年x月x日 的形式输入对应的数字\n\t");
		scanf("%d%d%d",&a.year,&a.month,&a.day);
	 }
	 if(i==3)
	 {
	 	a.minute=0;a.hour=0;
	 	a.month=1+p->tm_mon;
		a.year=1900+p->tm_year;
		a.day=p->tm_mday;	
	 }
	 if(i==4)
	 {
	 	a.year=YEAR;a.month=1;
	 	printf("\t请按照x日 x时x分的形式输入对应的数字\n\t");scanf("%d%d%d",&a.day,&a.hour,&a.minute);
	 }
	 return a;
}
int time2min(Time t)
{
	long m;
	int i,d=0,a,ai,b[13]={0,31,28,31,30,31,30,31,31,30,31,30,31};
	a=t.year;
	if((a%4==0&&a%100!=0)||(a%400==0)) b[2]=29;
	for (i=YEAR;i<t.year;i++)
	{
			if((i%4==0&&i%100!=0)||(i%400==0)) d+=366;
			else d+=365;
	}
	for(i=1;i<t.month;i++) d+=b[i];
	m=((d-1+t.day)*24+t.hour)*60+t.minute;
	return m; 
}
Time time_min2(int m)//min=(((y*365+m*30)+d)*24+h)*60+min
{
	Time a;
	int d,b=0,c=0;
	int i,j,md[13]={0,31,28,31,30,31,30,31,31,30,31,30,31};
	a.minute=m%60;
	a.hour=m/60%24;
	d=m/60/24;
	for(j=0;;j++)
	{
		i=YEAR+j;
		if((i%4==0&&i%100!=0)||(i%400==0)) b=366;
		else b=365;
		if(c<=d&&c+b>=d)break;
		c+=b;
	}
	a.year=i;
	if((i%4==0&&i%100!=0)||(i%400==0))md[2]=29;
	d-=c;//在一年中的日子数 
	c=0;b=0;
	for(j=1;j<=12;j++)
	{
		b=md[j];
		if(c<=d&&c+b>d)break;
		c+=b;
	}
	a.month=j;
	a.day=d+1-c;
	return a;	
}
int autotrain(Rail r,int sum,Train t[],int info[])//自动开班 
{
	int m;Train tr;int i,j,k;
	m=info[3];k=info[3]-1;
	for(i=m;i<m+sum;i++)
	{
		tr.type=r.type;
		tr.number=r.number;
		tr.no=k+1;
		tr.t=time2min(timeGet(3))+(i-m)*1440;
		tr.tt=r.tt;
		tr.bt=0;
		for(j=0;j<m;j++)
		{
			if(t[j].type==tr.type&&t[j].number==tr.number&&t[j].t==tr.t)break;
		}
		if(j==m)t[++k]=tr;
	}
	info[3]=k;
	return k;
}
void timePrint(Time a)
{
	if(a.minute==0)printf("%d年%d月%d日 %d:00\t",a.year,a.month,a.day,a.hour);//输出时间 
	else if(a.minute<10)printf("%d年%d月%d日 %d:0%d\t",a.year,a.month,a.day,a.hour,a.minute);
	else printf("%d年%d月%d日 %d:%d\t",a.year,a.month,a.day,a.hour,a.minute);
}
void timePrint2(Time a)
{
	if(a.day==1)
	{
		if(a.minute==0)printf("当天 %d:00\t",a.hour);//输出时间 
		else if(a.minute<10)printf("当天 %d:0%d\t",a.hour,a.minute);
		else printf("当天 %d:%d\t",a.hour,a.minute);
	 } 
	 else
	 {
	 	if(a.minute==0)printf("第%d天 %d:00\t",a.day,a.hour);//输出时间 
		else if(a.minute<10)printf("第%d天 %d:0%d\t",a.day,a.hour,a.minute);
		else printf("第%d天 %d:%d\t",a.day,a.hour,a.minute);
	 }
	 return;	
}
void print_rail(Rail a,int from,int to)
{
	int i;int y[3]={0,0,0};
	if(from==0&&to==0)
	{
		printf("--------------------------------------------------------------------------------------------------\n");
		printf("%c%d\t",a.type,a.number );
		printf("%s——%s\n",a.sta[0].name,a.sta[a.n_station-1].name);
		printf("\n  经停信息：\n");
		printf("\t站点\t到站时间\t\t离站时间\n");
		for (i=0;i<a.n_station;i++)
		{
			
			printf("\t%d %s\t",i+1,a.sta[i].name);
			timePrint2(time_min2(a.sta[i].a)) ;
			timePrint2(time_min2(a.sta[i].a+a.sta[i].b)) ;
			printf("中停%d 分钟\n",a.sta[i].b);
		//	printf("一等￥%d二等￥%d站票￥%d\n",y[0],y[1],y[2]);
		}	
	}
	if(from<to&&to<=a.n_station)
	{
		for(i=from;i<=to;i++)
		{
			y[0]+=a.sta[i].price[0];
			y[1]+=a.sta[i].price[1];
			y[2]+=a.sta[i].price[2];
		}
		printf("%c%d | ",a.type,a.number);
		timePrint2(time_min2(a.sta[from].a));printf("到达%s\t",a.sta[to].name); 
		timePrint2(time_min2(a.sta[from].a));printf("到达%s\t",a.sta[to].name); 
		printf("一等￥%d二等￥%d站票￥%d",y[0],y[1],y[2]);
		printf("\n");
	}	
	return ;
}
int print_user(User a)
{
	printf("%s\t%s\t%s\t%d\t%d\n",a.name,a.password,a.realname,a.number,a.identity);
}
void print_rec(Rec a)
{
	printf("用户%s订购了%d号火车的车票\t",a.name,a.No );
	timePrint(time_min2(a.t1));
	printf("到达%d号站%s\t",a.station1,a.sta1);
	timePrint(time_min2(a.t2)); 
	printf("到达%d号站%s\n",a.station2,a.sta2); 
}
void print_train(Train t)
{
	printf("%d\t%c%d列车",t.no,t.type,t.number);
	timePrint(time_min2(t.t));
	printf("发车 余票%d\n",t.tt-t.bt);
	return;
}
void Filewrite(Rail a[],User b[],Rec c[],Train d[],int info[])
{
	FILE*fp;
	{
			fp=fopen(".\\程序文件\\rail.dat","wb");//写入班次信息 
			if(fp==NULL)
			{
				printf("load rail.dat ERROR!\n");
				printf("按任意键退出程序\n");
				exit(1);
			}
			fwrite(a,sizeof(Rail),info[0],fp);
			fclose(fp);
			fp=fopen(".\\程序文件\\user.dat","wb");//写入用户信息 
			if(fp==NULL)
			{
				printf("open user.dat ERROR!\n");
				printf("按任意键退出程序\n");
				exit(1);
			}
			fwrite(b,sizeof(User),info[1],fp);
			fclose(fp);
			fp=fopen(".\\程序文件\\rec.dat","wb");//写入记录信息 
			if(fp==NULL)
			{
				printf("open rec.dat ERROR!\n");
				printf("按任意键退出程序\n");
				exit(1);
			}
			fwrite(c,sizeof(Rec),info[2],fp);
			fclose(fp);
			fp=fopen(".\\程序文件\\train.dat","wb");//写入时刻表信息 
			if(fp==NULL)
			{
				printf("open train.dat ERROR!\n");
				printf("按任意键退出程序\n");
				exit(1);
			}
			fwrite(d,sizeof(train),info[3],fp);
			fclose(fp);
			fp=fopen(".\\程序文件\\info.txt","w");//写入记录 
			if(fp==NULL)
			{
				printf("write info.txt ERROR!\n");
				printf("按任意键退出程序\n");
				exit(1);
			}
			fprintf(fp,"%d %d %d %d",info[0],info[1],info[2],info[3]);
			fclose(fp);
		}	
}
void readdata(Rail a[],User b[],Rec c[],Train d[],int info[])
{
	FILE*fp;
	{
			fp=fopen(".\\程序文件\\info.txt","r");//读取重要信息 
			if(fp==NULL)
			{
				printf("write info.txt ERROR!\n");
				printf("按任意键退出程序\n");
				exit(1);
			}
			fscanf(fp,"%d %d %d %d",&info[0],&info[1],&info[2],&info[3]);
			fclose(fp);
			
			fp=fopen(".\\程序文件\\rail.dat","rb");//读取班次信息 
			if(fp==NULL)
			{
				printf("load rail.dat ERROR!\n");
				printf("按任意键退出程序\n");
				exit(1);
			}
			fread(a,sizeof(Rail),info[0],fp);
			fclose(fp);
			fp=fopen(".\\程序文件\\user.dat","rb");//读取用户信息 
			if(fp==NULL)
			{
				printf("load user.dat ERROR!\n");
				printf("按任意键退出程序\n");
				exit(1);
			}
			fread(b,sizeof(User),info[1],fp);
			fclose(fp);
			fp=fopen(".\\程序文件\\rec.dat","rb") ;//读取记录信息 
			if(fp==NULL)
			{
				printf("load rec.dat ERROR!\n");
				printf("按任意键退出程序\n");
				exit(1);
			}
			fread(c,sizeof(Rec),info[2],fp);
			fp=fopen(".\\程序文件\\train.dat","rb");//读取时刻表信息 
			if(fp==NULL)
			{
				printf("open train.dat ERROR!\n");
				printf("按任意键退出程序\n");
				exit(1);
			}
			fread(d,sizeof(train),info[3],fp);
			fclose(fp);
		}	
}

int menu(int i) 
{	int s;
	switch(i)
	{
		case 1://欢迎界面 
			{
				time_t timer=time(NULL);
				printf("欢迎来到托马斯小火车事务部,祝您出行愉快");printf("\t\t\t\t%s",ctime(&timer));
				printf("----------------------------------------------------------------------------------------------------");
				break;
			 } 
			 case 2://管理员选择界面 
			 	{
				 	printf("MENU|");
				 	printf("0——返回上一级\t");
				 	printf("1——查询车次信息\t");
					printf("2——查询所有数据\t") ;
					printf("3——操作系统数据\t") ;
					printf("\n");
					scanf("%d",&s);
					break;
				 }
				 case 3://查询菜单 
				 {
				 	    printf("MENU查询菜单|");
				 		printf("0   结束查询\t");
				 		printf("1   按照站点查询\t");
						printf("2   按照车次查询 \t");  
						printf("3   全部车次信息\t");
						printf("请输入您的选择:\n");
						scanf("%d",&s);
						break;}
						case 4://用户登陆后的第一个界面 
							{
								printf("\nMENU|查询个人信息为——1\t查询票务信息——2 \t返回——3\n"); 
								scanf("%d",&s);
								break;
							}
							case 5://用户操作车票的界面 
								{
									
									printf("MENU操作订单|0——退出\t1——退票\t");
									printf("2——改签\n");
									printf("请选择操作\n");
									scanf("%d",&s);
									break;
								}
								case 6:
									{
										printf("\n您是否需要订购该车票\t1——订购\t0——不需要\n");
    									scanf("%d",&s);break; 
									}
									case 7:
									{
										printf("MENU操作数据|1——添加车次信息\t2——修改车次信息\t3——删除车次信息\t4——增加开班信息\n");
										scanf("%d",&s);break;
									 } 
									 case 8:
									 	{
									 		printf("是否注册VIP或者申请管理员权限 |1 注册VIP 2 申请管理员权限 其他内容视为不申请\n");
									 		scanf("%d",&s);break;
										 }
										 case 9:
										 	{
										 		printf("MENU 查询所有信息||0——返回上一级 1——查询车次信息 2——查询订票信息 3——查询用户信息 4--查询开班情况 9——关闭程序\n ");//4 info
										 		scanf("%d",&s);break;
											 }
											 case 10:
											 	{
											 			printf("\n\n\n\nn\n\n\n\n\n\n\t\t\t\t\t是否使用预置数据\n\t\t\t1——使用\n\t\t\t2——不使用\n");
														scanf("%d",&s);
												 }
    		
	}
	return s;
}
void originate(int inf[])
{	int select;FILE *fp;int i;
	int info[4]={4,5,2,0};
	Rail a[4]=	{   
		{'D',5526,5,3,{{"南京",0,10,{0,0,0}},{"扬州",40,5,{30,20,10}},{"泰州",60,5,{30,20,10}},{"海安",120,3,{30,20,10}},{"南通",150,10,{30,20,10}}}} ,    
		{'D',5521,5,3,{{"南京",500,10,{0,0,0}},{"镇江",540,5,{30,20,10}},{"常州",560,5,{30,20,10}},{"苏州",620,3,{30,20,10}},{"常熟",720,3,{30,20,10}}}}, 
		{'D',5522,5,3,{{"南京",100,10,{0,0,0}},{"常州",140,5,{30,20,10}},{"湖州",160,5,{30,20,10}},{"杭州",220,3,{30,20,10}},{"宁波",320,3,{30,20,10}}}} , 
		{'D',5524,5,3,{{"南京",100,10,{0,0,0}},{"扬州",140,5,{30,20,10}},{"泰州",160,5,{30,20,10}},{"海安",220,3,{30,20,10}},{"南通",220,3,{30,20,10}}}} 	};
	User b[5]={{"1","1","1",1,1},{"2","2","2",2,2},{"3","3","3",3,3},{"susan Jocob","123456","susan Jocob",2,2},{"孙中华","123456","孙中华",3,3}};
	Rec c[2]={{"1",1,1,2},{"2",2,1,3}};
	Train d[1000];
	for (i=0;i<info[0];i++)autotrain(a[i],20,d,info);
	select=menu(10);
	do{
		if(select==1)
		{
			Filewrite(a,b,c,d,info);	
			inf[0]=info[0];
			inf[1]=info[1];
			inf[2]=info[2];
			inf[3]=info[3];
		} 
		else if(select==2)
		{
			printf("请将文件放入程序所在目录\n文件包括：\n\tinfo.txt\n\t rail.dat\t user.dat\n\t rec.dat\n train.dat\n");
			getchar();getchar();
		}
		else {
			puts("请重新输入");
		}
	} while(select!=1&&select!=2);
	return;
}

//登陆模块 
User Register(User us[],int*nU)//注册函数 
	{
		User u;char ch;char yourkey[20],admin[20]="NJUPT",VIP[20]="njupt";
		int a,b,s;char str[20],str2[N_password],str3[20],str4[20];int j;
		printf("是否选择注册？\n");
		printf("退出请输入0 注册请输入1 \n");
		scanf("%d",&a);
		if (a==1) 
		{
		printf("开始注册!\n");
		printf("\t请输入您的身份证号码:");
		scanf("%d",&u.number);
		printf("\t请输入您的真实名字");
		scanf("%s",str2);
		strcpy(u.realname,str2);
		printf("\t请输入您用于登录的用户名");
		scanf("%s",str4);
		strcpy(u.name,str4);	 
		printf("\t请输入您的密码:");
		scanf("%s",str3);
		strcpy(u.password,str3);
		u.identity=1;
		s=menu(8); 
		if(s==1||s==2)
		{
			printf("请输入相关密钥,请务必一次性输入正确\n");
			char yourkey[20];
	    	j=0;
	        while((ch=getch())!='\r')
				{
					putchar('*');
					yourkey[j]=ch;
					j++;					
				}
				yourkey[j]='\0';
	    
	   	 	if(!strcmp(yourkey,admin))
	   	 	{
	    	printf("已经获取管理员权限\n");
	    	u.identity=2;
			}
			else if(!strcmp(yourkey,VIP))
			{
			printf("已经获取贵宾权限\n");
	    	u.identity=3;
			}
			else 
			{
				printf("权限获取失败\n\n") ; 
			} }
		}
	    if (a==0)
	    exit(1);
	    if(a==2) 
	    {
	    	u.identity=4;
		}
		printf("确认信息\n") ;
		getchar();
		us[*nU]=u;
		*nU=*nU+1;
		print_user(us[*nU-1]);
	return u;
}
User login(User user[],int*p)//登陆函数 
{
	int i,j,k,num;char inName[20];User u;
	int l=1;char ch; 
	 {
	system("cls");menu(1);
	printf("\n\t你是否注册过账号？(是 或 否 其他输入内容将视为以游客身份登陆)\n");
	char judge[5];
	scanf("%s",judge);
	system("cls");
	if(strcmp("否",judge)==0)
	{
	    Register(user,p);
	}
	if(strcmp("否",judge)==0||strcmp("是",judge)==0) 
	{ 
	num=*p;
	getchar();
	printf("开始登录!\n");
	printf("请输入您用户名:");
	scanf("%s",inName);
	for(i=0;i<num;i++)
	{
		if(strcmp(user[i].name,inName)==0)
		{
			break;
		}
	}
	if(i==num)
	{
		printf("未找到您的用户名!\n");
		Register(user,p);
	}
	else
	{
		getchar();
		printf("\n请输入密码,您有三次输入密码的机会:");
		for(k=0;k<3;k++)
		{
			char yourkey[20];
	    	j=0;
	        while((ch=getch())!='\r')
				{
					putchar('*');
					yourkey[j]=ch;
					j++;					
				}
				yourkey[j]='\0';
			l=strcmp(yourkey,user[i].password);
			if(l==0) {
			u=user[i];
			break;
			} 
			
			else
			{
				printf("输入错误，请重试!\n");
			}
		}
		if(k==3)
		{
			printf("登录失败!\n");
			u.identity=0;//非法用户 
		}
	}}
	else{
		u.identity=4;//游客 
	} 
}
return u;
}
Rail query(Train t[],Rail ra[],int info[])                //查询车次函数
{
	int choice;int ij=0,cho,flag=1;int bookornot; //flag 1原来的值 2deleced已经赋值 
	Rail selected;
	int n=info[0];
	char a[10],b[10];
	int i,j,k=1,l,s;
	int s1,s2;
	Rail se[N_rail];
	do
	{
		choice=menu(3);
		if(choice==3)				         	//全部查询--- flag=0;	
		{
			for (i=0;i<info[0];i++)print_rail(ra[i],0,0);
			flag=0;						
		}
		if(choice==1)							  //按站点查询	flag=2;	
		{
				
				printf("\t请输入您的出发地和目的地,支持通配符*模糊查询\n\t");
				scanf("%s",a);printf("\t到\n\t");scanf("%s",b);printf("\n ");
				printf("\t查询结果：\n");
				for (i=0;i<info[0];i++)
					{
						for (j=0;j<ra[i].n_station;j++)	
						{
							if(!strcmp(ra[i].sta[j].name,a)||!strcmp(a,"*"))
							{
								
									for(l=0;l<ra[i].n_station;l++)
									{
										if(!strcmp(ra[i].sta[l].name,b)||!strcmp(b,"*"))
										{
											if(l>j&&strcmp(ra[i].sta[j].name,ra[i].sta[l].name))
											{
											//printf(" 第%d条 %c%d | ",k,ra[i].type,ra[i].number);
											//timePrint2(time_min2(ra[i].sta[j].a));printf("到达%s\t",ra[i].sta[j].name); 
											//timePrint2(time_min2(ra[i].sta[l].a));printf("到达%s\t",ra[i].sta[l].name); 
											//printf("\n");
											printf("No.%d ",k);
											print_rail(ra[i],j,l);
											se[k-1]=ra[i];
											k++;	
											}
											
										}
									}	
							}
						}	
					}
					if(k==1)
					{
						selected.number=0;
						printf("\t无信息\n"); 
					}
					else
					{
					printf("请选择您需要查看的车票\n");
					scanf("%d",&s) ;
					print_rail(se[s-1],0,0) ;
					selected= se[s-1];
				}			 
		}
		if(choice==2)						     	//按线路编号查询   flag=2;	
		{
			int choice3=0,bookornot;
			char yourtype;
			int yournumber;
			int judge2=0;int ij;
			printf("请输入列车的路线号(如:D5526的5526):");
			scanf("%d",&yournumber);
			getchar() ;
			for(;choice3<n;choice3++)
			{
				if(yournumber==(ra+choice3)->number/*&&yourtype==ra[choice3].type*/)
				{
					ra[ij++]=ra[choice3];
					printf("第%d条\n",ij);print_rail(ra[choice3],0,0);
				}
				else
				{
					judge2++;
				}
			}getchar();
				if(judge2==n)
			{
				printf("没有您要寻找的车辆\n");
				selected.number=0; 
			}
			else if(ij==1) 
			{
				selected=ra[0];
			}
			else{
				printf("选择需要的列车\n");
				scanf("%d",&cho);
				selected=ra[cho-1];
			}
			}
		if(choice==0)   break;                      //返回上一级
	}while(choice);
	return selected;
}
int query_all(Rail rail[],User user[],Rec record[],Train train[],int info[])//管理员查询 查询座位情况
{
	int s;int i;
	do{
		printf("\n共有%d条班次数据 %d条用户数据 %d条票务数据 %d条开班情况数据\n",info[0],info[1],info[2],info[3]);
	
	s=menu(9);
	switch(s)
	{
			case 1:printf("路线信息\n");for (i=0;i<info[0];i++)print_rail(rail[i],0,0);break;
			case 3:printf("用户信息\n");for (i=0;i<info[1];i++)print_user(user[i]);break;
			case 2:printf("票务信息\n");for (i=0;i<info[2];i++)print_rec(record[i]);break;
			case 4:printf("开班信息\n");for (i=1;i<info[3];i++)print_train(train[i]);break;
	}
	if(s==0) break;
}while(s!=0);
	return s;
}
int operate(Rail ra[],Train t[],int info[])
{
	int se;Rail r;int i;char str[20];int a, j;int s1,s2;
	se=menu(7);Station sta;
	switch(se)
	{
		case 1:
			{
				printf("请输入车次的编号以及经过的站点总数\t如：D5526 5\n");
				r.type=getchar();
				scanf("%c",&r.type);
				scanf("%d %d",&r.number,&r.n_station);
				for (i=0;i<r.n_station;i++)
				{
					printf("请输入第%d个站点：\n",i+1);
					printf("\t站点名：");scanf("%s",&str);strcpy(r.sta[i].name,str);
					printf("发车时间\t") ;r.sta[i].a=time2min(timeGet(4));
					printf("中停时间（分钟）\t");scanf("%d",&r.sta[i].b);
					r.n_seat=3;
					if(i!=0){
						printf("请分别输入一等 二等 和站票票价\t");
						for(j=0;j<r.n_seat;j++)
						scanf("%d",r.sta[i].price+i);
					}	
				}
				ra[info[0]]=r;
					info[0]++;
					printf("是否为已经添加的车次自动从今天开始开班，请输入自动开班的天数，不开输入0\n");
					scanf("%d",&a) ;
					autotrain(r,a,t,info);
					break; 
			}
			case 2:
			{
				printf("请输入修改的车次编号如D5521的5521\n");
				scanf("%d",&a);
				for(i=0;i<info[0];i++)
				{
					if(ra[i].number==a)break;
				}
				if(i==info[0])printf("未找到该车次\n");
				else
				{
					print_rail(ra[i],0,0) ;
					printf("您可以增加站点(1)、减少站点(2)、或者修改站点(3)，其他功能请先删除后添加\n");
					printf("请选择需要的操作");scanf("%d",&s1);
					printf("请选择操作的站点");scanf("%d",&s2); 
					switch(s1)
					{
						case 1:
							{
								printf("\t需要添加的站点名：");scanf("%s",&str);strcpy(sta.name,str);
								printf("发车时间\t") ;sta.a=time2min(timeGet(4));
								printf("中停时间（分钟）\t");scanf("%d",&sta.b);
								printf("请分别输入一等 二等 和站票票价\t");
								for(j=0;j<r.n_seat;j++)
								scanf("%d",sta.price+i);
								for(j=ra[i].n_station;j>s2;j--)	
								{
									ra[i].sta[j]=ra[i].sta[j-1];
								}
								ra[i].sta[s2]=sta;
								ra[i].n_station++; 
								break;
							}
						case 2:
							{
								for(j=s2;j<ra[i].n_station-1;j++)	
								{
									ra[i].sta[j]=ra[i].sta[j+1];
								}
								ra[i].n_station--;
								break;
							}
						case 3:
							{
								printf("\t需要后的站点名：");scanf("%s",&str);strcpy(sta.name,str);
								printf("发车时间\t") ;sta.a=time2min(timeGet(4));
								printf("中停时间（分钟）\t");scanf("%d",&sta.b);
								printf("请分别输入一等 二等 和站票票价\t");
								for(j=0;j<r.n_seat;j++)
								scanf("%d",sta.price+i);
								ra[i].sta[s2-1]=sta;
								break;
							}
					}
				}
				break;
			 } 
			 case 3:
			 	{
			 		printf("请输入删除的车次编号如D5521的5521\n");
					scanf("%d",&a);
			 		for(i=0;i<info[0];i++)
					{
						if(ra[i].number==a)break;
					}
					if(i==info[0])printf("未找到该车次\n");
					else
					{
						for(j=i;j<info[0]-1;j++) 
						{
							ra[j]=ra[j+1];
						}
						info[0]--;
					}
					break;
				 }
				 case 4:
				 {
				 	
				  } 
	}
}
//用户模块的子函数
int timeconflict(Rec u,Rec re[],int info[])//a,b c,d 
{
	int i,j=0;
	for(i=0;i<info[2];i++)
	{
		if(!strcmp(re[i].name,u.name))
		{
		 	if(u.t1>re[i].t2||u.t2<re[i].t1)
		 		j=0;
		 		else j=1;
		}
	}
	return j;
}
int query_user(User u,Rec r[],int info[])//查询用户购票情况 
{
	int j=0,s,s1;int i,n,k=0;int a[N_rec];Rec t;int changeit=0;
	n=info[2];
	printf("您的订单信息如下\n");
	for (i=0;i<n;i++)
	{
		if(!strcmp(r[i].name,u.name))
		{
			printf("No.%d ",++k);
		    print_rec(r[i]);puts("");
			a[k-1]=i;	
		 } 
	}
	if(k==0) printf("目前无订票信息\n");
	else{
	s=menu(5);
	if(s==1)
	{
	do{
		printf("请选择退票的编号\n");
		scanf("%d",&s1);
		}while(s1>k||s1<=0);
		print_rec(r[a[s1-1]]);
		printf("是否确认退票  1——确认\n");
		scanf("%d",&j);
		if(j==1) {
			for(i=a[s1-1];i<n-1;i++)
			{
				r[i]=r[i+1];
			}
			info[2]--;
		}

	}
	if(s==2)
	{
	do{
		printf("请选择改签的编号\n");
		scanf("%d",&s1);
		}while(s1>k||s1<=0);
		print_rec(r[a[s1]]);
		printf("是否确认改签上述车票  1——确认\n");
		scanf("%d",&j);
		if(j==1) {
			for(i=a[s1];i<n-1;i++)
			{
				r[i]=r[i+1];
			}
			info[2]--;
		}
		changeit=1;
		printf("\n自动进入查询页面，您可以改签到其他车票\n");
	}
	}
	return changeit;
}
int book(Rail r,User u,Rail ra[],Train t[],Rec re[],int info[])
 {
 	Rec rcd;Train tr;Time tim;int flag=0;
	int s1,s2;int y,m,d;int i;
	if(r.number!=0)
	{
		system("cls");
	 	printf("请确认班次信息\n");
	 	print_rail(r,0,0);
	 	printf("输入您上车与下车的站点\t\t请输入站点对应编号\n");
	 	scanf("%d %d",&s1,&s2);
		while(s1>=s2||s2>r.n_station){
		 	printf("输入有误请重新输入"); 
	 		scanf("%d %d",&s1,&s2);
		 }
		 printf("相关信息如下：\n\t");
		 print_rail(r,s1-1,s2-1);
		 do{
			 printf("请输入您需要乘车的时间\t输入x年x月x日中的三个对应数字用空格隔开即可\n") ;
			 scanf("%d%d%d",&y,&m,&d) ;
			 for(i=0;i<info[3];i++)
			 {
			 	tim=time_min2(t[i].t);
			 	if(tim.year==y&&tim.month==m&&tim.day==d)break;
			 }
			 if(i!=info[3])
			 {
			 	printf("当天该列车余票为%d\n",t[i].tt-t[i].bt);
			 	strcpy(rcd.name,u.name);
			 	rcd.No=t[i].no;
			 	rcd.station1=s1;
			 	rcd.station2=s2;
			 	rcd.t1=t[i].t-r.sta[1].a+r.sta[s1-1].a;
			 	rcd.t2=t[i].t-r.sta[1].a+r.sta[s2-1].a;
			 	strcpy(rcd.sta1,r.sta[s1-1].name);
				strcpy(rcd.sta2,r.sta[s2-1].name);
				if(t[i].t-r.sta[1].a+r.sta[s1].a-30<=time2min(timeGet(0)) ) {flag=1;printf("必须提前半小时订票,请重新输入\n");}
				else if(u.identity==4) printf("游客，请登录\n");
				else if(timeconflict(rcd,re,info)){flag=1;printf("你已经订购了与该车票时间冲突的车票,请重新输入\n");}
				else if(t[i].tt<=t[i].bt){printf("余票不足\n");flag=1;	}
				else{
				re[info[2]]=rcd;
				info[2]+=1;
				printf("订票成功");
				flag=0; }
			}
			 else
			 {
			 	printf("当天无相关车次的列车,请重新输入\n");
			 	flag=1;
				 }	
		 }while(flag);
		
	}
 	return 0;
 }
//非法，用户，管理员模块 
void unlaw()
{
	printf("！！！！非法用户！！！！\n！！！！已强制退出！！！！\n"); 
	exit(0) ;
}
int ptyh(User u,rail a[],User b[],Rec c[],Train d[],int info[])
{
  	Rail ra;int s;int bookornot; int changeornot;
 //身份，使用1表示普通用户，3表示VIP 0表示非法用户 ,4表示游客； 
  	system("cls");
  	printf("欢迎");
  	if(u.identity==4)printf("游客");
	else{
	  	if(u.identity==3) printf("VIP");
	  	printf("用户%s",u.name);
	  }
	 printf("登陆系统，祝您旅途愉快\t\t\t\t") ; 
	 timePrint(timeGet(0));
	 puts("");
	 do{
    if(u.identity==1||u.identity==3)
    {
    	do{
    	s=menu(4);
    	if(s==1) changeornot=query_user(u,c,info);
        if(s==2|| changeornot==1)
		{
    		ra=query(d,a,info);
    		if(ra.number!=0)
    		{	
    		if(menu(6)==1)
    		book(ra,u,a,d,c,info);
			}
		}
	}while(s!=3);
	}
  	if(u.identity==4)query(d,a,info);
  }while(s!=3);
  s=1;
  	return s;
  }
int glry(User u,rail a[],User b[],Rec c[],Train d[],int info[])//0——返回上一级\t");	printf("1——查询班次信息\t");	printf("2——查询所有数据\t") ;	printf("3——操作系统数据\t")
 {
 	int temp;int s=0;
 	system("cls");
 	printf("欢迎管理员%s进入系统\n",u.name);
	do{
		
		temp=menu(2);
		switch(temp)
		{
			case 1:query(d,a,info);break;                           //班次查询 普通查询 
			case 2:s=query_all(a,b,c,d,info) ;break;               		 //查询 全部 
			case 3:operate(a,d,info);break;                                 //操作 
		}
	}while(temp!=0&&s!=9);
 	return 1;
  } 
                 																											#define MAIN
#ifdef MAIN
int main()
{
	Rail rail[N_rail];User user[N_user] ;Rec record[N_rec];Train train[N_train];
	int info[4];int i; 
	User us;Rail ra;int t;
	menu(1);//欢迎界面 
	originate(info);//初始化
	readdata(rail,user,record,train,info);
	int a;
	do{ 
    us=login(user,info+1);//登陆界面 
	system("cls");
	switch(us.identity)//身份，使用1表示普通用户，2表示管理员，3表示VIP 0表示非法用户 ,4表示游客； 
	{
		case 0: unlaw();break;a=0;//非法用户，退出系统 
		case 1:
		case 3:
		case 4:	
			    a=ptyh(us,rail,user,record,train,info);break;//普通用户（包括VIP、游客）使用模块 
		case 2: a=glry(us,rail,user,record,train,info);break;//管理人员使用模块 
	}
	}while(a==1) ; 
	Filewrite(rail,user,record,train,info);
	return 0;
}
#endif
#ifdef TIME 
int main()//调试时间处理函数 
{
	int i;int b;Time c;
	i=61200;
	for(i=0;i<=100000000;i+=1440)
	{
		c=time_min2(i);
		b=time2min(c);
		timePrint(c);printf("\t%d\t%d\n",i,b);
		if(b!=i){break;
		}
	}
	return 0;
}
#endif
#ifdef FILE
int main()//调试文件操作 
{

{
	Rail rail[N_rail];User user[N_user] ;Rec record[N_rec];Train train[N_train];
	int info[4];int i; 
	User us;Rail ra;int t;
	menu(1);//欢迎界面 
	originate(info);//初始化
	readdata(rail,user,record,train,info);
	printf("\n数据%d %d %d %d\n",info[0],info[1],info[2],info[3]);
	printf("路线信息\n");for (i=0;i<info[0];i++)print_rail(rail[i],0,0);
	printf("用户信息\n");for (i=0;i<info[1];i++)print_user(user[i]);
	printf("票务信息\n");for (i=0;i<info[2];i++)print_rec(record[i]);
	printf("开班信息\n");for (i=1;i<info[3];i++)print_train(train[i]);
 } 
 } 
 #endif 
                                                                                                                                 //#define YHMK
 #ifdef YHMK
 int main()//调试人员模块 
 {
 	Rail rail[N_rail];User user[N_user] ;Rec record[N_rec];Train train[N_train];
	int info[4];int i; 
	User us;Rail ra;int t;
	  us=login(user,info+1);//登陆界面 
	menu(1);//欢迎界面 
	originate(info); 
	readdata(rail,user,record,train,info);
	glry(user[1],rail,user,record,train,info);
  ptyh(user[0],rail,user,record,train,info);
 }
 #endif 
