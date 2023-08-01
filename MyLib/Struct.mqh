//+------------------------------------------------------------------+
//|                                             My_Robot_Periods.mqh |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
struct iMAOpCl_                                                       //Структура описывающая Пересечение iMA
   {                                                                  
    int       iMANum_Cross;                                           //Номер пересечения
    string    iMAOpCl_Trend;                                          //Либо UP Либо DW
    datetime  iMAOpCl_Time;                                           //Время открытия
    double    iMAOpen_Price;                                          //Цена открытия 
    int       iMATime_Life;                                           //Время жизни 
    int       iMATime_Between;                                        //
    float     iMABody;                                                //Цена открытия - Цена закрытия 
    int       iMASpread;                                              //Спред на момент открытия
    string    iMAName_V;                                              //Имя вертикально линии открытия 
    string    iMAName_H;                                              //Имя горизонтальной линии открытия  
    //int       iMANumL_OnScr;              
   }; 

iMAOpCl_ iMACross5_5[100];                                             //структура пересечений iMA 5 мин 5 период
iMAOpCl_ iMACross5_15[100];                                            //структура пересечений iMA 5 мин 15 период
//+------------------------------------------------------------------+
struct InfoLeftScreen_
   {
    string    Info_Text;
    string    Info_Name;
   };

InfoLeftScreen_ InfoLeftScreen[30];
//+------------------------------------------------------------------+
struct iCadle_
   {
    double    iCadle_Open;
    double    iCadle_Close;
    double    iCadle_High;
    double    iCadle_Low;
    datetime  iCadle_Time;
    string    iCadle_Name[4];
    string    iCadle_Trend;                                          //Либо UP Либо DW
   };
   
iCadle_ iCadle_Day[6];
//+------------------------------------------------------------------+
struct iFractals_                                                     //Структура описывающая Пересечение 
   {
    double    iFractals_Price;
    datetime  iFractals_Time;
    string    iFractals_Trend;
    string    iFractals_NameV;
    string    iFractals_NameH;
   };
   
iFractals_ iFractals_5[100];
//------------------------start data----------------------------------
int     NumFractals    = 100;
int     NumCrossiMA5_5 = 100;


