//+------------------------------------------------------------------+
//|                                             My_Robot_Periods.mqh |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict


#include <MyLib\Struct.mqh>
#include <MyLib\Interface_.mqh>
#include <MyLib\ObjPaint_.mqh>

//+------------------------------------------------------------------+
//| iCadle_Analyze                                                       
//|            
//+------------------------------------------------------------------+
bool iCadle_FillingStruct_;

void iCadle_FillingStruct(int     Timeframe_  =   PERIOD_D1)
   {//iCadle_FillingStruct_ = false;
    if (Timeframe_ == PERIOD_D1)
      {if (iCadle_Day[0].iCadle_Time == NULL || iCadle_Day[0].iCadle_Time != iTime(Symbol(),Timeframe_,0))
         {for (int i=0; i<=5; i++)
           {iCadle_Day[i].iCadle_Time    = iTime(Symbol(),Timeframe_,i);
            iCadle_Day[i].iCadle_Open    = iOpen(Symbol(),Timeframe_,i);
            iCadle_Day[i].iCadle_Close   = iClose(Symbol(),Timeframe_,i);
            iCadle_Day[i].iCadle_High    = iHigh(Symbol(),Timeframe_,i);
            iCadle_Day[i].iCadle_Low     = iLow(Symbol(),Timeframe_,i);
            iCadle_Day[i].iCadle_Name[0] = "iCadle_Open_";
            iCadle_Day[i].iCadle_Name[1] = "iCadle_High_";
            iCadle_Day[i].iCadle_Name[2] = "iCadle_Low_";
            iCadle_Day[i].iCadle_Name[3] = "iCadle_Close_";
            if (iCadle_Day[i].iCadle_Open < iCadle_Day[i].iCadle_Close) iCadle_Day[i].iCadle_Trend = "UP";
            if (iCadle_Day[i].iCadle_Open > iCadle_Day[i].iCadle_Close) iCadle_Day[i].iCadle_Trend = "DW";
           }
         }
       if (iCadle_Day[0].iCadle_High != iHigh(Symbol(),Timeframe_,0)) 
         {
          iCadle_Day[0].iCadle_High  = iHigh(Symbol(),Timeframe_,0);
          if (iCadleDay_Button2St == true)
            {iCadle_DayOneLineDel(0,PERIOD_D1,iCadle_Day[0].iCadle_Name[1]);
             if (iCadleDay_Button7St == true) Alert("New High");
             iCadle_DayOneLineOnScreen (0,Timeframe_,iCadle_Day[0].iCadle_High,iCadle_Day[0].iCadle_Name[1],clrLime);
            }
          }
       if (iCadle_Day[0].iCadle_Low != iLow(Symbol(),Timeframe_,0))
         {
          iCadle_Day[0].iCadle_Low = iLow(Symbol(),Timeframe_,0);
          if (iCadleDay_Button2St == true)
            {iCadle_DayOneLineDel(0,PERIOD_D1,iCadle_Day[0].iCadle_Name[2]);
             if (iCadleDay_Button7St == true) Alert("New Low");
             iCadle_DayOneLineOnScreen (0,Timeframe_,iCadle_Day[0].iCadle_Low,iCadle_Day[0].iCadle_Name[2],clrRed);
            }
         }
       if (iOpen(Symbol(),Timeframe_,0) < iClose(Symbol(),Timeframe_,0)) 
         {ObjectSetInteger(0,Symbol()+"_iCadleDay_Button1",OBJPROP_COLOR,clrLime);
          ObjectSetInteger(0,Symbol()+"_iCadleDay_Button2",OBJPROP_COLOR,clrLime);
          if (iCadle_Day[0].iCadle_Trend  == "DW")
            {iCadle_Day[0].iCadle_Trend = "UP"; 
             if (iCadleDay_Button7St == true) Alert("Day in UP");
            }
         }
       if (iOpen(Symbol(),Timeframe_,0) > iClose(Symbol(),Timeframe_,0)) 
         {ObjectSetInteger(0,Symbol()+"_iCadleDay_Button1",OBJPROP_COLOR,clrRed);
          ObjectSetInteger(0,Symbol()+"_iCadleDay_Button2",OBJPROP_COLOR,clrRed);
          if (iCadle_Day[0].iCadle_Trend  == "UP")
            {iCadle_Day[0].iCadle_Trend = "DW"; 
             if (iCadleDay_Button7St == true)Alert("Day in DW");
            }          
         }
       //if () 
      }
   }
//+------------------------------------------------------------------+
//| iCadle_Analyze                                                       
//|            
//+------------------------------------------------------------------+
void iCadle_DayOnScreen(int     Num_ =  NULL)
   {//if (Num_ == NULL) Alert("Ошибка вызов функции с  0  iCadle_DayOnScreen");
    if (iCadleDay_Button2St == true) iCadle_DayLineOnScreen_All(Num_,PERIOD_D1);
    if (iCadleDay_Button3St == true) iCadle_DayLineOnScreen_All(Num_,PERIOD_D1);
    if (iCadleDay_Button4St == true) iCadle_DayLineOnScreen_All(Num_,PERIOD_D1);
    if (iCadleDay_Button5St == true) iCadle_DayLineOnScreen_All(Num_,PERIOD_D1);
    if (iCadleDay_Button6St == true) iCadle_DayLineOnScreen_All(Num_,PERIOD_D1); 
   }

//+------------------------------------------------------------------+
//| iMA5_5_Button2                                                       
//|            
//+------------------------------------------------------------------+
//int  iMA5_5_Button2_;

void iCadleDay_Button2(int       Num_   =   0)
   {if (ObjectGetInteger(0,Symbol()+"_iCadleDay_Button"+string(2+Num_),OBJPROP_STATE)== true)
      {if (Num_ == 0)iCadleDay_Button2St = true;
       if (Num_ == 1)iCadleDay_Button3St = true;
       if (Num_ == 2)iCadleDay_Button4St = true;
       if (Num_ == 3)iCadleDay_Button5St = true;
       if (Num_ == 4)iCadleDay_Button6St = true;
       iCadle_DayLineOnScreen_All(Num_,PERIOD_D1);
       //iCadle_DayOnScreen(Num_);
       //Alert("Test");
       //InfoOnScreen_2Label(InfoOnScreenLeft_Label_All_,"_iMA5_5Start_Button"+string(2+Num_),"Text"+string(InfoOnScreenLeft_Label_All_));
       //InfoOnScreen_2Label(iMA5_5_ButtonInfo(0));                    //Вывод информации слева 0 элемента iMA5
       //iMA5_5_Button2_ = InfoOnScreen_2Label_;
       //InfoOnScreenLeft_Label_All_++;
       //InfoOnScreen();
       //iMA_OneLineOnScreen(PERIOD_M5,Num_);
       //iCadle_DayOnScreen(Num_,PERIOD_D1);
       //ObjectSetString(0,Symbol()+"_InfoOnScreen_Label4",OBJPROP_TEXT,(string)InfoOnScreen_2Label_);
       
      }
    if (ObjectGetInteger(0,Symbol()+"_iCadleDay_Button"+string(2+Num_),OBJPROP_STATE)== false)
      {if (Num_ == 0)iCadleDay_Button2St = false;
       if (Num_ == 1)iCadleDay_Button3St = false;
       if (Num_ == 2)iCadleDay_Button4St = false;
       if (Num_ == 3)iCadleDay_Button5St = false;
       if (Num_ == 4)iCadleDay_Button6St = false;
       iCadle_DayLineDel_All(Num_,PERIOD_D1);
       //InfoOnScreenLeft_2LabelDel("_iMA5_5Start_Button"+string(2+Num_));
       //iMA5_5_Button2_= 999;
       //InfoOnScreenLeft_Label_All_--;
       //InfoOnScreenLeft_2LabelOffset2(InfoOnScreenLeft_Label_All_);
       //InfoOnScreen();
       //iMA_DelOneLine(PERIOD_M5,Num_);
       //ObjectSetString(0,Symbol()+"_InfoOnScreen_Label4",OBJPROP_TEXT,(string)InfoOnScreen_2Label_);
      }
   }
//+------------------------------------------------------------------+
//| iCadle_DayLineOnScreen_Open                                                       
//|            
//+------------------------------------------------------------------+
void iCadle_DayLineOnScreen_All(int    Num_      = 0,
                                int    Timeframe = PERIOD_D1)
   {iCadle_DayOneLineOnScreen (Num_,Timeframe,iCadle_Day[Num_].iCadle_Open,iCadle_Day[Num_].iCadle_Name[0],clrYellow);
    iCadle_DayOneLineOnScreen (Num_,Timeframe,iCadle_Day[Num_].iCadle_High,iCadle_Day[Num_].iCadle_Name[1],clrLime);
    iCadle_DayOneLineOnScreen (Num_,Timeframe,iCadle_Day[Num_].iCadle_Low,iCadle_Day[Num_].iCadle_Name[2],clrRed);
    //iCadle_DayOneLineOnScreen (Num_,Timeframe,iCadle_Day[Num_].iCadle_Close,iCadle_Day[Num_].iCadle_Name[3]);    
   }
//+------------------------------------------------------------------+
//| iCadle_DayOneLineOnScreen                                                       
//|            
//+------------------------------------------------------------------+
void iCadle_DayOneLineOnScreen(int    Num_        = 0,
                               int    Timeframe   = PERIOD_D1,
                               double Price_      = NULL,
                               string Main_Name_  = "Same_Name_",
                               color  Color_      = clrWhite)
   {string Name_;
    if (Timeframe == PERIOD_D1) Name_ = "D1_"+ string(Num_);
    if (ObjectFind(Main_Name_+ Name_)==-1)
      MyHlineUP_Price(Price_,1,Timeframe,Main_Name_+Name_,Color_);
    else Print("Объект "+Main_Name_+Name_+" существует!!!");
   }
//+------------------------------------------------------------------+
//| iCadle_DayLineOnScreen_Open                                                       
//|            
//+------------------------------------------------------------------+
void iCadle_DayLineDel_All(int    Num_      = 0,
                           int    Timeframe   = PERIOD_D1)
   {iCadle_DayOneLineDel (Num_,Timeframe,iCadle_Day[Num_].iCadle_Name[0]);
    iCadle_DayOneLineDel (Num_,Timeframe,iCadle_Day[Num_].iCadle_Name[1]);
    iCadle_DayOneLineDel (Num_,Timeframe,iCadle_Day[Num_].iCadle_Name[2]);
    //iCadle_DayOneLineOnScreen (Num_,Timeframe,iCadle_Day[Num_].iCadle_Close,iCadle_Day[Num_].iCadle_Name[3]);    
   }
//+------------------------------------------------------------------+
//| iCadle_DayOneLineOnScreen                                                       
//|            
//+------------------------------------------------------------------+
void iCadle_DayOneLineDel(int    Num_        = 0,
                          int    Timeframe   = PERIOD_D1,
                          string Main_Name_  = "Same_Name_")
   {string Name_;
    if (Timeframe == PERIOD_D1) Name_ = "D1_"+ string(Num_);
    if (ObjectFind(Symbol()+"_HLineUP_"+Main_Name_+Name_)!=-1)
      ObjectDelete(Symbol()+"_HLineUP_"+Main_Name_+Name_);
    else Print("Объект "+Symbol()+"_HLineUP_"+Main_Name_+Name_+"  не существует!!!");;
   }
   
//+------------------------------------------------------------------+
//| iCadleDay_Button1                                                       
//|            
//+------------------------------------------------------------------+
void iCadleDay_Button3()
   {if (ObjectGetInteger(0,Symbol()+"_iCadleDay_Button7",OBJPROP_STATE)==true) 
      {iCadleDay_Button7St = true;
       ObjectSetInteger(0,Symbol()+"_iCadleDay_Button7",OBJPROP_COLOR,clrYellow);
      }
    if (ObjectGetInteger(0,Symbol()+"_iCadleDay_Button7",OBJPROP_STATE)==false)
      {iCadleDay_Button7St = false;
       ObjectSetInteger(0,Symbol()+"_iCadleDay_Button7",OBJPROP_COLOR,clrBlack);
      }
   }
//+------------------------------------------------------------------+
//| iCadle_DayLineOnScreen_High                                                       
//|            
//+------------------------------------------------------------------+
//void iCadle_DayLineOnScreen_High(int    Num_      = 0,
//                                 int    Timeframe = PERIOD_D1)
//   {string Name_;
//    if (Timeframe == PERIOD_D1) Name_ = "D1"+ string(Num_);
//    if (ObjectFind(Symbol()+"_HLineUP_+iCadle_High_"+ Name_)==-1)
//      MyHlineUP_Price(iCadle_Day[Num_].iCadle_High,1,Timeframe,Symbol()+"_HLineUP_+iCadle_High_"+Name_,ColorUp);
//    else Print("Объект "+Symbol()+"_HLineUP_+iCadle_High_"+Name_+" существует!!!");
//   }
//+------------------------------------------------------------------+
//| iCadle_DayLineOnScreen_Low                                                       
//|            
//+------------------------------------------------------------------+
//void iCadle_DayLineOnScreen_Low(int    Num_      = 0,
//                                int    Timeframe = PERIOD_D1)
//   {string Name_;
//    if (Timeframe == PERIOD_D1) Name_ = "D1"+ string(Num_);
//    if (ObjectFind(Symbol()+"_HLineUP_+iCadle_Low_"+ Name_)==-1)
//      MyHlineUP_Price(iCadle_Day[Num_].iCadle_Low,1,Timeframe,Symbol()+"_HLineUP_+iCadle_Low_"+Name_,ColorDw);
//    else Print("Объект "+Symbol()+"_HLineUP_+iCadle_Low_"+Name_+" существует!!!");
//   }
//+------------------------------------------------------------------+
//| iCadle_DayLineOnScreen_Close                                                       
//|            
//+------------------------------------------------------------------+
//void iCadle_DayLineOnScreen_Close(int    Num_      = 0,
//                                  int    Timeframe = PERIOD_D1)
//   {string Name_;
//    if (Timeframe == PERIOD_D1) Name_ = "D1"+ string(Num_);
//    if (ObjectFind(Symbol()+"_HLineUP_+iCadle_Close_"+ Name_)==-1)
//      if (iCadle_Day[Num_].iCadle_Close > iCadle_Day[Num_].iCadle_Open)
//         MyHlineUP_Price(iCadle_Day[Num_].iCadle_Close,1,Timeframe,Symbol()+"_HLineUP_+iCadle_Close_"+Name_,ColorUp);
//      if (iCadle_Day[Num_].iCadle_Close < iCadle_Day[Num_].iCadle_Open)
//         MyHlineUP_Price(iCadle_Day[Num_].iCadle_Close,1,Timeframe,Symbol()+"_HLineUP_+iCadle_Close_"+Name_,ColorDw);
//    else Print("Объект "+Symbol()+"_HLineUP_+iCadle_Close_"+Name_+" существует!!!");
//   }
//         //Alert("Day in DW");
//          //iCadle_Day[0].iCadle_Close = iClose(Symbol(),Timeframe_,0);
          //iCadle_DayOneLineDel(0,PERIOD_D1,string(Symbol()+"_HLineUP_iCadle_High_")
          //iCadle_FillingStruct_ = true;
         //} 
       //if (iCadle_FillingStruct_ == true) iCadle_DayOnScreen();
       
          //if ()
          //iCadle_DayLineOnScreen();
         //}      

   
