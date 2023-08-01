//+------------------------------------------------------------------+
//|                                             My_Robot_Periods.mqh |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict


#include <MyLib\Variables_.mqh>
#include <MyLib\Interface_.mqh>
#include <MyLib\ObjPaint_.mqh>
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|Init_iMA
//|
//+------------------------------------------------------------------+
void Init_iMA()
   {for (int i=0;i<=4;i++)
      {iMA5_5[i].SetupInd(i,1,PERIOD_M5,5);

      }
    iMA5_TickWork();
   }
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|iMA5_5CheckTrend
//+------------------------------------------------------------------+
void iMA5_TickWork()
   {iMA5_5[0].SetupInd(0,1,PERIOD_M5,5);
    if (iMA5_5[0].LastEvent_==100) 
      {if (iMA5_5ButtonGraf[0].State_== true){iMA5_5[0].DelOldLineCross();iMA5_5[0].DrawLineCross();}
       for (int i=1;i<5;i++)
         {iMA5_5[i].SetupInd(i,1,PERIOD_M5,5);
          if (iMA5_5ButtonGraf[i].State_== true){iMA5_5[i].DelOldLineCross();iMA5_5[i].DrawLineCross();}
         }
       if (iMA5_5Button[0].State_ == true)for(int i=0;i<5;i++)iMA5_5ButtonGraf[i].ColorButton(iMA5_5[i].TypeTrend_); 
      }
 
   }
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|iMA_Class - class
//+------------------------------------------------------------------+
struct iMA_Struct
   {
    private:          
         
      double    iMAOpClRaz_003_0(int shift_,string symbol_,int timeFrame_,int maPeriod_,int maShift_,int maMethod_);
      void      LoadDataCrossiMa2(string typeTrend_, int numCrossCadle_);
      void      LoadDataCrossiMa1(string typeTrend_, int numCrossCadle_);      
      
    public:
                iMA_Struct(void);      
               ~iMA_Struct(void);
            
      int       StartCadle_;      //Свеча с которой начать расчет      
      int       Period_;          //Период для расчета iMA      
      int       NumCross_;        //Номер пересечения         
      int       TimeFrame_;       //иследуемый период         
      string    OldTypeTrend_;    //Переменая для проверки смены тренда         
      bool      Initializated_;   //Инициализация объекта
      bool      ActiveVisable_;   //Включена кнопка отображения
      bool      ActiveSignal_;    //Включена кнопка Сигнала
      string    TypeTrend_;       //Либо UP Либо DW
      datetime  TimeOpen_;        //Время открытия
      double    PriceOpen_;       //Цена открытия 
      int       NumOpenCadle_;    //Номер Свечи начала тренда
      datetime  TimeClose_;       //Время закрытия
      double    PriceClose_;      //Цена закрытия 
      int       NumCloseCadle_;   //Номер Свечи конца тренда
      double    PriceMax_;
      double    PriceMin_;
      
      int       BodyCadle_;       //Номер свечи открытия - Номер закрытия закрытия 
      float     BodyPrice_;       //Цена открытия - цена закрытия
      string    NameVLine_;       //Имя вертикально линии открытия 
      string    NameHLine_;       //Имя горизонтальной линии открытия 
      string    OldNameVLine_;    //Предыдущее имя
      string    OldNameHLine_;    //Предыдущее имя  
      int       LastEvent_;       //Последнее событие iMA
         
      void      DelLineCross();
      void      DrawLineCross();
      void      DelOldLineCross();      
      void      CheckTrend(int numCross_);
      void      CheckEvent(int numEvent_);
      void      SetActiveSignal(bool activeSignal_); 
      void      SetActiveVisable(bool activeVisable_);
      void      SetupInd(int numCross_,int startCadle_,int timeFrame_,int period_);    
      void      CalculationData(int numCross_,int startCadle_,int timeframe_,int period_);    
   };

iMA_Struct iMA5_5 [5];
iMA_Struct iMA5_15[5];
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|IND_iMA
//|Конструктор
//+------------------------------------------------------------------+
iMA_Struct::iMA_Struct()
   {Initializated_ = false;
    ActiveVisable_ = false;
    ActiveSignal_  = false;
    PriceMax_      = 0;
    PriceMin_      = 999;
    //WasEvent_      = false;
   }
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|IND_iMA
//|Деструктор
//+------------------------------------------------------------------+
iMA_Struct::~iMA_Struct(){}
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|SetActiveVisable
//+------------------------------------------------------------------+
void iMA_Struct::SetActiveVisable(const bool activeVisable_) {ActiveVisable_ = activeVisable_;}
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|SetActiveSignal
//+------------------------------------------------------------------+
void iMA_Struct::SetActiveSignal(const bool activeSignal_) {ActiveSignal_ = activeSignal_;}
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|DrawLineCross
//+------------------------------------------------------------------+
void iMA_Struct::DrawLineCross(){OneCrossOnScreen(TimeFrame_,TypeTrend_,NameVLine_,TimeOpen_,NameHLine_,PriceOpen_);}
void iMA_Struct::DelLineCross(){DelOneCrossOnScreen(NameVLine_,NameHLine_);}
void iMA_Struct::DelOldLineCross(){DelOneCrossOnScreen(OldNameVLine_,OldNameHLine_);}

//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|IND_iMA
//|SetupInd_001
//+------------------------------------------------------------------+
void iMA_Struct::SetupInd(const int numCross_,
                          const int startCadle_,
                          const int timeFrame_,
                          const int period_) 
   {LastEvent_=0;
    //инициализация входных данных не изменяются вообщеееее
    if (Initializated_ == false){NumCross_ = numCross_;StartCadle_ = startCadle_;TimeFrame_ = timeFrame_;Period_ = period_;}
    //расчет по входным данным   
    CalculationData(NumCross_,StartCadle_,TimeFrame_,Period_);
    if (Initializated_ == false)Initializated_ = true;
    //если произошло какое то событие
    //if (WasEvent_ == true )CheckEvent();
   }
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//| iMAOpClRaz
//| Пересечение iMA линий iMA(открытия) и iMA(закрытия)
//| в момент времени
//| Возвращаемое число положительно -  UP
//| Возвращаемое число отрицательное - DW                                                                               
//+------------------------------------------------------------------+
double iMA_Struct::iMAOpClRaz_003_0(const int    shift_,             // смещение 
                                    const string symbol_,            // Валютная Пара
                                    const int    timeFrame_,         // Период
                                    const int    maPeriod_,          // Период линий iMA           
                                    const int    maShift_,           // смещение по вертикали
                                    const int    maMethod_)          // метод расчета средней (MODE_SMA, MODE_EMA, MODE_SMMA, MODE_LWMA)
   {double Op = (float)iMA(Symbol(),timeFrame_,maPeriod_,maShift_,maMethod_,PRICE_OPEN,shift_);
    double Cl = (float)iMA(Symbol(),timeFrame_,maPeriod_,maShift_,maMethod_,PRICE_CLOSE,shift_); 
    double iMAOpCl = Cl - Op;     
    return (iMAOpCl);
   }

//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|IND_iMA
//|NumCadleCrossiMA_002//Свеча с которой начать расчет//иследуемый временой период (M1, M5, M15, M30 и т.д.)//Период для расчета iMA (5 свечей в основном)
//+------------------------------------------------------------------+
void iMA_Struct::CalculationData(const int numCross_,       //Номер пересечения
                                 const int startCadle_,     //Свеча с которой начать расчет
                                 const int timeFrame_,      //иследуемый временой период (M1, M5, M15, M30 и т.д.)
                                 const int period_)         //Период для расчета iMA (5 свечей в основном)
   {int i = startCadle_;int a = 0;bool numCadleCross_ = false;       // инициализация начальных переменных 
    //  i = Свеча с которой начать расчет, a = номер пересечения ,numCadleCross_ = выполнять пока не выполнятся условия
    while(numCadleCross_ == false)  // Работа закончится только тогда когда найдем пересечения
      {double cadle0_ = iMAOpClRaz_003_0(i,Symbol(),timeFrame_,period_,0,MODE_LWMA);       
       double cadle1_ = iMAOpClRaz_003_0(i+1,Symbol(),timeFrame_,period_,0,MODE_LWMA);
       // Смена тренда на Up
       if (cadle0_>0 && cadle1_<=0) 
         {if (a == numCross_-1 && numCross_!=0)LoadDataCrossiMa1("UP",i); // не нулевой тренд / Oтсекаем нулевое пересечение / свеча закрытия тренда / 
          if (a == numCross_) LoadDataCrossiMa2("UP",i);                  // нулевой тренд           
          a++;          
         }
       // Смена тренда на Dw  
       if (cadle0_<0 && cadle1_>=0) 
         {if (a == numCross_-1 && numCross_!=0)LoadDataCrossiMa1("DW",i); // не нулевой тренд / Oтсекаем нулевое пересечение / свеча закрытия тренда / 
          if (a == numCross_) LoadDataCrossiMa2("DW",i);                  // нулевой тренд           
          a++;
         }
       i++;
       if(a>numCross_) numCadleCross_ = true;
       if(i==100) numCadleCross_ = true;             
      }
   }
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//| LoadDataCrossiMa1                                                                                                    
//| Конец тренда  / не нулевой тренд                    
//+------------------------------------------------------------------+
void iMA_Struct::LoadDataCrossiMa1(const string typeTrend_,          // Либо UP Либо DW
                                   const int    numCrossCadle_)      // Номер свечи где происходит пересечение, смена тренда         
   {if (Initializated_ == false || NumCloseCadle_ != numCrossCadle_ )// Если не проиницилизована и номер свечи пересечения не совпадает
      {NumCloseCadle_= numCrossCadle_;                               // Закрытие тренда не нулевого
       TimeClose_    = iTime(Symbol(),TimeFrame_,NumCloseCadle_);
       PriceClose_   = iOpen(Symbol(),TimeFrame_,NumCloseCadle_);
       //if (typeTrend_=="UP") if (PriceMax_<PriceClose_)PriceMax_=PriceClose_;
       //if (typeTrend_=="DW") if (PriceMin_>PriceClose_)PriceMax_=PriceClose_;
      }    
   }
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//| LoadDataCrossiMA_003_2                                                                                                    
//| Начало тренда                      
//+------------------------------------------------------------------+
void iMA_Struct::LoadDataCrossiMa2(const string typeTrend_,          // Либо UP Либо DW
                                   const int    numCrossCadle_)      // Номер свечи где происходит пересечение, смена тренда    
    {if (Initializated_ == false || TypeTrend_ != typeTrend_)        // Если не проиницилизована и смена тренда
      {TypeTrend_   = typeTrend_;                                    // Открытие тренда
       NumOpenCadle_= numCrossCadle_;
       TimeOpen_    = iTime(Symbol(),TimeFrame_,NumOpenCadle_-1);
       PriceOpen_   = iOpen(Symbol(),TimeFrame_,NumOpenCadle_-1); 
       if (Initializated_ == true)
          {OldNameVLine_ = NameVLine_;
           OldNameHLine_ = NameHLine_;
          }     
       NameVLine_   = string(Symbol())+" iMa "+string(NumCross_) +" Vline "+ TypeTrend_ +" "+string(Period_)+ " " + string(TimeOpen_);
       NameHLine_   = string(Symbol())+" iMa "+string(NumCross_) +" Hline "+ TypeTrend_+" "+string(Period_)+ " " + string(PriceOpen_); 
       if (NumCross_ !=0)
         {BodyCadle_ = ((int)MathCeil((NumCloseCadle_ - NumOpenCadle_)/60));
          if (TypeTrend_ == "UP") BodyPrice_ = float(PriceClose_ - PriceOpen_);
          if (TypeTrend_ == "DW") BodyPrice_ = float(PriceOpen_ - PriceClose_);  
         }  
       if (Initializated_ == true && NumCross_ == 0) CheckEvent(100);                   
      }    
    if (NumCross_ ==0)
      {BodyCadle_ = ((int)MathCeil((TimeCurrent() - TimeOpen_)/60));   
       if (TypeTrend_ == "UP") BodyPrice_ = float(Bid - PriceOpen_);
       if (TypeTrend_ == "DW") BodyPrice_ = float(PriceOpen_ - Bid);
      } 
   }
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//| CheckEvent                                                                                                    
//| Начало тренда                      
//+------------------------------------------------------------------+
void iMA_Struct::CheckEvent(const int numEvent_)
   {if (numEvent_ == 100)
      {if (iMA5_5Button[1].State_ == true)
         {Alert(Symbol() + " Смена тренда " + string(TimeFrame_) + " Период раcсчета " + (string)Period_+ " на " + string(TypeTrend_));
         }
      }
    LastEvent_ = numEvent_;
   }
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|iMA5_5CheckTrend
//+------------------------------------------------------------------+
void iMA_Struct::CheckTrend(const int numCross_= 0)
   {//SetupInd_001(numCross_,1,TimeFrame_,Period_);
    //if (Initializated_==true && OldTypeTrend_==NULL) OldTypeTrend_=TypeTrend_;
    //if (Initializated_==true && OldTypeTrend_!=NULL && OldTypeTrend_!=TypeTrend_)
    //  {if (numCross_== 0)
    //     {if (ActiveSignal_==true) Alert(Symbol() + " Смена тренда " + string(TimeFrame_) + " Период раcсчета " + (string)Period_+ " на " + string(TypeTrend_));
    //      for (int i=1;i<=4;i++) 
    //        {iMA5_5[i].SetupInd_001(i,1,TimeFrame_,Period_);
    //        }
    //     }
    //   if (ActiveVisable_ == true)
    //     {DelOneCrossOnScreen(OldNameVLine_,OldNameHLine_);
    //      OneCrossOnScreen(TimeFrame_,TypeTrend_,NameVLine_,TimeOpen_,NameHLine_,PriceOpen_);  
    //     }
    //   OldTypeTrend_=TypeTrend_; 
    //  }
   }
       //if(NumCross_ == 0) iMACross5_5[NumCross_].iMATime_Between = NumCadle_-1;                                         // - iMACross5_5[NumCross_-1].iMATime_Life;
       //if(NumCross_ >0) iMACross5_5[NumCross_].iMATime_Between = (NumCadle_-1) - iMACross5_5[NumCross_-1].iMATime_Life ;// - iMACross5_5[NumCross_-1].iMATime_Life;
       //iMACross5_5[NumCross_].iMASpread     = (int)MarketInfo(Symbol(),MODE_SPREAD); 
       //iMACross5_5[NumCross_].iMAName_V     = string(iMACross5_5[NumCross_].iMAOpCl_Time)+"_iMA5_5";
       //iMACross5_5[NumCross_].iMAName_H     = string(iMACross5_5[NumCross_].iMAOpen_Price)+"_iMA5_5";
       //if (Trend_ == "UP" && NumCross_== 0) iMACross5_5[NumCross_].iMABody = float(Bid - iMACross5_5[NumCross_].iMAOpen_Price);
       //if (Trend_ == "DW" && NumCross_== 0) iMACross5_5[NumCross_].iMABody = float(iMACross5_5[NumCross_].iMAOpen_Price - Bid);
       //if (Trend_ == "UP" && NumCross_ > 0) iMACross5_5[NumCross_].iMABody = float(iMACross5_5[NumCross_-1].iMAOpen_Price - iMACross5_5[NumCross_].iMAOpen_Price);
       //if (Trend_ == "DW" && NumCross_ > 0) iMACross5_5[NumCross_].iMABody = float(iMACross5_5[NumCross_].iMAOpen_Price - iMACross5_5[NumCross_-1].iMAOpen_Price);
    
    
//          iMA_OffsetCross5_5();
//          iMA_FillingStruct(Trend_,NumCadle_,NumCross_,Timeframe_,Time_);
//          iMACurrent_Trend = iMACross5_5[NumCross_].iMAOpCl_Trend;
//          for (int i=0;i<=4;i++) iMA5_5ColorButton(NumCross_+i);
//          
//          if (iMA5_5_Button7St == true) 
//            {if (iMACross5_5[NumCross_].iMAOpCl_Trend == "UP") Alert("New UP Trend M5_5"); 
//             if (iMACross5_5[NumCross_].iMAOpCl_Trend == "DW") Alert("New DW Trend M5_5");
//            }
//          
//          if (iMA5_5_Button2St == true)iMA_OneLineOnScreen(Timeframe_,NumCross_); 
//          if (iMA5_5_Button3St == true)iMA_OneLineOnScreen(Timeframe_,NumCross_+1); 
//          if (iMA5_5_Button4St == true)iMA_OneLineOnScreen(Timeframe_,NumCross_+2); 
//          if (iMA5_5_Button5St == true)iMA_OneLineOnScreen(Timeframe_,NumCross_+3); 
//          if (iMA5_5_Button6St == true)iMA_OneLineOnScreen(Timeframe_,NumCross_+4); 
//         } 
//       
//       //Alert("sfgfw");
//       //if (iMACross5_5[NumCross_].iMAOpCl_Trend != NULL && Trend_ == iMACurrent_Trend)
//       //  {iMA_FillingStruct(Trend_,NumCadle_,NumCross_,Timeframe_,Time_);
//       //   for (int i=0;i<=4;i++)
//       //     {if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button"+string(2+i),OBJPROP_STATE)== true) 
//       //        {InfoOnScreen_2Label(iMA5_5_ButtonInfo(i));
///       //        }
//       //     }
//       //  }      
//       //Print("------------------------------------------");
//      } 
//    //фактически первый запуск и проверка на ошибки  
//    if (NumCross_ >0)
//      {if (NumCross_<5 && iMACross5_5[NumCross_].iMAOpCl_Trend == NULL)
//         {iMA_FillingStruct(Trend_,NumCadle_,NumCross_,Timeframe_,Time_); 
//          iMA5_5ColorButton(NumCross_);
//         }
//       if (NumCross_>5 && iMACross5_5[NumCross_].iMAOpCl_Trend == NULL) iMA_FillingStruct(Trend_,NumCadle_,NumCross_,Timeframe_,Time_); 
//      }
//   }  / 
    
    
    //iMACross5_5[NumCross_].iMATime_Life  = NumCadle_-1;
    //if(NumCross_ == 0) iMACross5_5[NumCross_].iMATime_Between = NumCadle_-1;                                         // - iMACross5_5[NumCross_-1].iMATime_Life;
    //if(NumCross_ >0) iMACross5_5[NumCross_].iMATime_Between = (NumCadle_-1) - iMACross5_5[NumCross_-1].iMATime_Life ;// - iMACross5_5[NumCross_-1].iMATime_Life;
    //iMACross5_5[NumCross_].iMASpread     = (int)MarketInfo(Symbol(),MODE_SPREAD); 
    //iMACross5_5[NumCross_].iMAName_V     = string(iMACross5_5[NumCross_].iMAOpCl_Time)+"_iMA5_5";
    // iMACross5_5[NumCross_].iMAName_H     = string(iMACross5_5[NumCross_].iMAOpen_Price)+"_iMA5_5";
    //if (Trend_ == "UP" && NumCross_== 0) iMACross5_5[NumCross_].iMABody = float(Bid - iMACross5_5[NumCross_].iMAOpen_Price);
    //if (Trend_ == "DW" && NumCross_== 0) iMACross5_5[NumCross_].iMABody = float(iMACross5_5[NumCross_].iMAOpen_Price - Bid);
    //if (Trend_ == "UP" && NumCross_ > 0) iMACross5_5[NumCross_].iMABody = float(iMACross5_5[NumCross_-1].iMAOpen_Price - iMACross5_5[NumCross_].iMAOpen_Price);
    //if (Trend_ == "DW" && NumCross_ > 0) iMACross5_5[NumCross_].iMABody = float(iMACross5_5[NumCross_].iMAOpen_Price - iMACross5_5[NumCross_-1].iMAOpen_Price);
    //     {iMA_FillingStruct(Trend_,NumCadle_,NumCross_,Timeframe_,Time_); 
    //      iMACurrent_Trend = iMACross5_5[NumCross_].iMAOpCl_Trend;
    //      iMA5_5ColorButton(NumCross_);
    //     }
    //   if (iMACross5_5[NumCross_].iMAOpCl_Trend != NULL && Trend_ != iMACurrent_Trend)
    //     {if (iMA5_5_Button2St == true)iMA_DelOneLine(Timeframe_,NumCross_); 
    //      if (iMA5_5_Button3St == true)iMA_DelOneLine(Timeframe_,NumCross_+1); 
    //      if (iMA5_5_Button4St == true)iMA_DelOneLine(Timeframe_,NumCross_+2); 
    //      if (iMA5_5_Button5St == true)iMA_DelOneLine(Timeframe_,NumCross_+3); 
    //      if (iMA5_5_Button6St == true)iMA_DelOneLine(Timeframe_,NumCross_+4); 
    //      
    //      iMA_OffsetCross5_5();
    //      iMA_FillingStruct(Trend_,NumCadle_,NumCross_,Timeframe_,Time_);
    //      iMACurrent_Trend = iMACross5_5[NumCross_].iMAOpCl_Trend;
    //      for (int i=0;i<=4;i++) iMA5_5ColorButton(NumCross_+i);
    //      
    //      if (iMA5_5_Button7St == true) 
    //        {if (iMACross5_5[NumCross_].iMAOpCl_Trend == "UP") Alert("New UP Trend M5_5"); 
    //         if (iMACross5_5[NumCross_].iMAOpCl_Trend == "DW") Alert("New DW Trend M5_5");
    //        }
    //      
    //      if (iMA5_5_Button2St == true)iMA_OneLineOnScreen(Timeframe_,NumCross_); 
    //      if (iMA5_5_Button3St == true)iMA_OneLineOnScreen(Timeframe_,NumCross_+1); 
    //      if (iMA5_5_Button4St == true)iMA_OneLineOnScreen(Timeframe_,NumCross_+2); 
    //      if (iMA5_5_Button5St == true)iMA_OneLineOnScreen(Timeframe_,NumCross_+3); 
    //      if (iMA5_5_Button6St == true)iMA_OneLineOnScreen(Timeframe_,NumCross_+4); 
    //     } 
       
       //Alert("sfgfw");
       //if (iMACross5_5[NumCross_].iMAOpCl_Trend != NULL && Trend_ == iMACurrent_Trend)
       //  {iMA_FillingStruct(Trend_,NumCadle_,NumCross_,Timeframe_,Time_);
       //   for (int i=0;i<=4;i++)
       //     {if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button"+string(2+i),OBJPROP_STATE)== true) 
       //        {InfoOnScreen_2Label(iMA5_5_ButtonInfo(i));
       //        }
       //     }
       //  }      
       //Print("------------------------------------------");
    //  } 
    //фактически первый запуск и проверка на ошибки  
    //if (NumCross_ >0)
    //  {if (NumCross_<5 && iMACross5_5[NumCross_].iMAOpCl_Trend == NULL)
    //     {iMA_FillingStruct(Trend_,NumCadle_,NumCross_,Timeframe_,Time_); 
    //      iMA5_5ColorButton(NumCross_);
    //     }
    //   if (NumCross_>5 && iMACross5_5[NumCross_].iMAOpCl_Trend == NULL) iMA_FillingStruct(Trend_,NumCadle_,NumCross_,Timeframe_,Time_); 
    //  }
   //}  


 
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//| MyiMA                                                             
//|                         
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//bool MyiMA_ = false;
//
//void MyiMA( int  Timeframe_      = PERIOD_M15, // иследуемый период 
//            int  Period_         = 15, // Период для расчета iMA
//            int  startCadle      = 0, // Свеча с которой начать расчет
//            int  NumCross_       = 5) // количество пересечений 
//   {int i = startCadle; // Свеча с которой начать расчет
//    int a = 0; // Номер пересечения
//    MyiMA_ = false; //
//    while(MyiMA_ == false)
//      {double Cadle0 = iMAOpClRaz(i,Symbol(),Timeframe_,Period_);
//       double Cadle1 = iMAOpClRaz(i+1,Symbol(),Timeframe_,Period_);
//       if (Cadle0>0 && Cadle1<0)                                      // Смена тренда на Up
//         {LoadDataiMAPeriod(Timeframe_,Period_,"UP",i,a);
//          
//          //IND_iMA iMA5_+i;
//          a++;
//         }
//       if (Cadle0<0 && Cadle1>0)                                      // Смена тренда на Dw
//         {LoadDataiMAPeriod(Timeframe_,Period_,"DW",i,a);a++;
//         }
//       i++;
//       if(a>=NumCross_) MyiMA_ = true;
//       if(i==1000) MyiMA_ = true;    
//      }        
//   }


//+------------------------------------------------------------------+
//| iMAOpClRaz
//| Пересечение iMA линий iMA(открытия) и iMA(закрытия)
//| в момент времени
//| Возвращаемое число положительно -  UP
//| Возвращаемое число отрицательное - DW                                                                               
//+------------------------------------------------------------------+
//double iMAOpCl;///
//
//double iMAOpClRaz(const int     shift          = 0,                    // смещение 
//                  const string  symbol         = "EURUSD",             // Валютная Пара
//                  const int     timeframe      = PERIOD_M15,           // Период
//                  const int     ma_period      = 5,                    // Период линий iMA           
//                  const int     ma_shift       = 0,                    // смещение по вертикали
//                  const int     ma_method      = MODE_LWMA,
//                  const int     applied_price  = PRICE_WEIGHTED)
//                             
//   {double Op = (float)iMA(Symbol(),timeframe,ma_period,ma_shift,ma_method,PRICE_OPEN,shift);
//    double Cl = (float)iMA(Symbol(),timeframe,ma_period,ma_shift,ma_method,PRICE_CLOSE,shift); 
//    iMAOpCl = Cl - Op;     
//    return (iMAOpCl);
//   }

//+------------------------------------------------------------------+
//| LoadDataiMAPeriod15                                                             
//|                      
//+------------------------------------------------------------------+
//void LoadDataiMAPeriod(int     Timeframe_  = PERIOD_M5,              // расчитываемый период
//                       int     iMAPeriod_  = 15,                     // средняя расчета iMA
//                       string  Trend_      = "",                     // Либо UP Либо DW
//                       int     NumCadle_   = 0,                      // Номер свечи где происходит пересечение
//                       int     NumCross_   = 0)                      // Номер пересечения 
//   {if (Timeframe_ == PERIOD_M5 && iMAPeriod_ == 5) LoadDataiMA5Period5(Trend_,NumCadle_,NumCross_,Timeframe_,iMAPeriod_);
//    //if (Timeframe_ == PERIOD_M5 && iMAPeriod_ == 15) LoadDataiMA5Period15(Trend_,NumCadle_,NumCross_,Timeframe_,iMAPeriod_);  
//   }
//+------------------------------------------------------------------+
//| iMA_OneLineOnScreen                                         iMA5_5
//| создает вертикальную и горизонтальную на точке пересечения iMA5_5                                                      
//| проверяет объекты на наличие и создает по номеру пересечения          
//+------------------------------------------------------------------+
//void iMA_OneLineOnScreen(int        Timeframe_  = PERIOD_M5,  
//                         int        NumCross_   = 0)
//   {if (Timeframe_ == PERIOD_M5)
//      {if(iMACross5_5[NumCross_].iMAOpCl_Trend == "UP")
//         {if (ObjectFind(Symbol()+"_VLineUP_"+iMACross5_5[NumCross_].iMAName_V)==-1)
//            MyVLineUP_Time(iMACross5_5[NumCross_].iMAOpCl_Time,0,PERIOD_M5,iMACross5_5[NumCross_].iMAName_V);
//          else Print("Объект "+Symbol()+"_VLineUP_"+iMACross5_5[NumCross_].iMAName_V+" существует!!!");
//          if (ObjectFind(Symbol()+"_HLineUP_"+iMACross5_5[NumCross_].iMAName_H)==-1)
//            MyHlineUP_Price(iMACross5_5[NumCross_].iMAOpen_Price,0,PERIOD_M5,iMACross5_5[NumCross_].iMAName_H);
//          else Print("Объект "+Symbol()+"_HLineUP_"+iMACross5_5[NumCross_].iMAName_H+" существует!!!");
//         }
//       if(iMACross5_5[NumCross_].iMAOpCl_Trend == "DW")
//         {if (ObjectFind(Symbol()+"_VLineDW_"+iMACross5_5[NumCross_].iMAName_V)==-1)
//            MyVLineDW_Time(iMACross5_5[NumCross_].iMAOpCl_Time,0,PERIOD_M5,iMACross5_5[NumCross_].iMAName_V );
//          else Print("Объект "+Symbol()+"_VLineDW_"+iMACross5_5[NumCross_].iMAName_V+" существует!!!");
//          if (ObjectFind(Symbol()+"_HLineDW_"+iMACross5_5[NumCross_].iMAName_H)==-1)
//            MyHlineDW_Price(iMACross5_5[NumCross_].iMAOpen_Price,0,PERIOD_M5,iMACross5_5[NumCross_].iMAName_H);
//          else Print("Объект "+Symbol()+"_HLineDW_"+iMACross5_5[NumCross_].iMAName_H+" существует!!!");
//          
//         }
//      }   
//   }  

//+------------------------------------------------------------------+
//| iMA_FillingStruct                                                             
//|                 
//+------------------------------------------------------------------+
//void iMA_FillingStruct (string        Trend_     = "",                // Либо UP Либо DW
//                        int           NumCadle_  = 0,                 // Номер свечи где происходит пересечение
//                        int           NumCross_  = 0,                 // Номер пересечения
//                        int           Timeframe_ = PERIOD_M5,         // Временной период
//                        datetime      Time_      = 0)                 // Номер пересечения)
//   {if (Timeframe_ == PERIOD_M5)
//      {iMACross5_5[NumCross_].iMAOpCl_Trend = Trend_;
//       iMACross5_5[NumCross_].iMANum_Cross  = NumCross_;
//       iMACross5_5[NumCross_].iMAOpCl_Time  = Time_;
//       iMACross5_5[NumCross_].iMAOpen_Price = iOpen(Symbol(),Timeframe_,NumCadle_-1);
//       iMACross5_5[NumCross_].iMATime_Life  = NumCadle_-1;
//       if(NumCross_ == 0) iMACross5_5[NumCross_].iMATime_Between = NumCadle_-1;                                         // - iMACross5_5[NumCross_-1].iMATime_Life;
//       if(NumCross_ >0) iMACross5_5[NumCross_].iMATime_Between = (NumCadle_-1) - iMACross5_5[NumCross_-1].iMATime_Life ;// - iMACross5_5[NumCross_-1].iMATime_Life;
//       iMACross5_5[NumCross_].iMASpread     = (int)MarketInfo(Symbol(),MODE_SPREAD); 
//       iMACross5_5[NumCross_].iMAName_V     = string(iMACross5_5[NumCross_].iMAOpCl_Time)+"_iMA5_5";
//       iMACross5_5[NumCross_].iMAName_H     = string(iMACross5_5[NumCross_].iMAOpen_Price)+"_iMA5_5";
//       if (Trend_ == "UP" && NumCross_== 0) iMACross5_5[NumCross_].iMABody = float(Bid - iMACross5_5[NumCross_].iMAOpen_Price);
//       if (Trend_ == "DW" && NumCross_== 0) iMACross5_5[NumCross_].iMABody = float(iMACross5_5[NumCross_].iMAOpen_Price - Bid);
//       if (Trend_ == "UP" && NumCross_ > 0) iMACross5_5[NumCross_].iMABody = float(iMACross5_5[NumCross_-1].iMAOpen_Price - iMACross5_5[NumCross_].iMAOpen_Price);
//       if (Trend_ == "DW" && NumCross_ > 0) iMACross5_5[NumCross_].iMABody = float(iMACross5_5[NumCross_].iMAOpen_Price - iMACross5_5[NumCross_-1].iMAOpen_Price);
//      }
//   }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| LoadDataiMA5Period5                                         iMA5_5                                                            
//| обработка при 0 через заданный кол-во тиков                      
//+------------------------------------------------------------------+
//
//void LoadDataiMA5Period5(string        Trend_     = "",            // Либо UP Либо DW
//                         int           NumCadle_  = 0,             // Номер свечи где происходит пересечение
//                         int           NumCross_  = 0,             // Номер пересечения
//                         const int     Timeframe_ = PERIOD_M5,     // Временной период
//                         const int     iMAPeriod_ = 5)             // Средняя
//   {datetime Time_ = (iTime(Symbol(),Timeframe_,NumCadle_-1));
//    //Alert("1");
//    //Alert(NumCross_,NumCadle_);
//    if (NumCross_ ==0)
//      {if (iMACross5_5[NumCross_].iMAOpCl_Trend == NULL) 
//         {iMA_FillingStruct(Trend_,NumCadle_,NumCross_,Timeframe_,Time_); 
//          iMACurrent_Trend = iMACross5_5[NumCross_].iMAOpCl_Trend;
//          iMA5_5ColorButton(NumCross_);
//         }
//       if (iMACross5_5[NumCross_].iMAOpCl_Trend != NULL && Trend_ != iMACurrent_Trend)
//         {if (iMA5_5_Button2St == true)iMA_DelOneLine(Timeframe_,NumCross_); 
//          if (iMA5_5_Button3St == true)iMA_DelOneLine(Timeframe_,NumCross_+1); 
//          if (iMA5_5_Button4St == true)iMA_DelOneLine(Timeframe_,NumCross_+2); 
//          if (iMA5_5_Button5St == true)iMA_DelOneLine(Timeframe_,NumCross_+3); 
//          if (iMA5_5_Button6St == true)iMA_DelOneLine(Timeframe_,NumCross_+4); 
//          
//          iMA_OffsetCross5_5();
//          iMA_FillingStruct(Trend_,NumCadle_,NumCross_,Timeframe_,Time_);
//          iMACurrent_Trend = iMACross5_5[NumCross_].iMAOpCl_Trend;
//          for (int i=0;i<=4;i++) iMA5_5ColorButton(NumCross_+i);
//          
//          if (iMA5_5_Button7St == true) 
//            {if (iMACross5_5[NumCross_].iMAOpCl_Trend == "UP") Alert("New UP Trend M5_5"); 
//             if (iMACross5_5[NumCross_].iMAOpCl_Trend == "DW") Alert("New DW Trend M5_5");
//            }
//          
//          if (iMA5_5_Button2St == true)iMA_OneLineOnScreen(Timeframe_,NumCross_); 
//          if (iMA5_5_Button3St == true)iMA_OneLineOnScreen(Timeframe_,NumCross_+1); 
//          if (iMA5_5_Button4St == true)iMA_OneLineOnScreen(Timeframe_,NumCross_+2); 
//          if (iMA5_5_Button5St == true)iMA_OneLineOnScreen(Timeframe_,NumCross_+3); 
//          if (iMA5_5_Button6St == true)iMA_OneLineOnScreen(Timeframe_,NumCross_+4); 
//         } 
//       
//       //Alert("sfgfw");
//       //if (iMACross5_5[NumCross_].iMAOpCl_Trend != NULL && Trend_ == iMACurrent_Trend)
//       //  {iMA_FillingStruct(Trend_,NumCadle_,NumCross_,Timeframe_,Time_);
//       //   for (int i=0;i<=4;i++)
//       //     {if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button"+string(2+i),OBJPROP_STATE)== true) 
//       //        {InfoOnScreen_2Label(iMA5_5_ButtonInfo(i));
///       //        }
//       //     }
//       //  }      
//       //Print("------------------------------------------");
//      } 
//    //фактически первый запуск и проверка на ошибки  
//    if (NumCross_ >0)
//      {if (NumCross_<5 && iMACross5_5[NumCross_].iMAOpCl_Trend == NULL)
//         {iMA_FillingStruct(Trend_,NumCadle_,NumCross_,Timeframe_,Time_); 
//          iMA5_5ColorButton(NumCross_);
//         }
//       if (NumCross_>5 && iMACross5_5[NumCross_].iMAOpCl_Trend == NULL) iMA_FillingStruct(Trend_,NumCadle_,NumCross_,Timeframe_,Time_); 
//      }
//   }  / 
//
//+------------------------------------------------------------------+
//| iMA_OffsetCross5_5                                                             
//| смещение структуры на 1                     
//+------------------------------------------------------------------+
//void iMA_OffsetCross5_5 ()
//   {for(int i=(NumCrossiMA5_5-2);i>=0;i--)
//     {iMACross5_5[i+1].iMAOpCl_Trend   = iMACross5_5[i].iMAOpCl_Trend;
//      iMACross5_5[i+1].iMAOpCl_Time    = iMACross5_5[i].iMAOpCl_Time;
//      iMACross5_5[i+1].iMAOpen_Price   = iMACross5_5[i].iMAOpen_Price;
//      iMACross5_5[i+1].iMATime_Life    = iMACross5_5[i].iMATime_Life;
//      iMACross5_5[i+1].iMATime_Between = iMACross5_5[i].iMATime_Between;
//      iMACross5_5[i+1].iMABody         = iMACross5_5[i].iMABody;
//      iMACross5_5[i+1].iMASpread       = iMACross5_5[i].iMASpread;
//      iMACross5_5[i+1].iMAName_V       = iMACross5_5[i].iMAName_V;
//      iMACross5_5[i+1].iMAName_H       = iMACross5_5[i].iMAName_H;         
//     }
//   }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| iMA5_5_Button2Info                                                       
//|            
//+------------------------------------------------------------------+
//string iMA5_5_ButtonInfo(int    Num_   =   0 )
//   {string Text_;
//    if (iMACross5_5[Num_].iMAOpCl_Trend != NULL)
//      {Text_ = 
//       (string)iMACross5_5[Num_].iMANum_Cross    + "  " +
//       (string)iMACross5_5[Num_].iMAOpCl_Trend   + "  " + 
//       (string)iMACross5_5[Num_].iMATime_Life    + "  " +
//       (string)iMACross5_5[Num_].iMATime_Between + "  " +
//       (string)iMACross5_5[Num_].iMABody         + "  " +
//       (string)iMACross5_5[Num_].iMAOpen_Price
//       ;
//      }    
//    return(Text_);
//   }
//
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+   
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| iMA5_5_Button2                                                       
//|            
//+------------------------------------------------------------------+
//int  iMA5_5_Button2_;

//void iMA5_5_Button2(int       Num_   =   0)
//   {if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button"+string(2+Num_),OBJPROP_STATE)== true)
//      {if (Num_ == 0)iMA5_5_Button2St = true;
//       if (Num_ == 1)iMA5_5_Button3St = true;
//       if (Num_ == 2)iMA5_5_Button4St = true;
//       if (Num_ == 3)iMA5_5_Button5St = true;
//       if (Num_ == 4)iMA5_5_Button6St = true;
//       InfoOnScreen_2Label(InfoOnScreenLeft_Label_All_,"_iMA5_5Start_Button"+string(2+Num_),iMA5_5_ButtonInfo(Num_));
///       //InfoOnScreen_2Label(Num_,,iMA5_5_ButtonInfo(Num_));                    //Вывод информации слева 0 элемента iMA5
 //      //iMA5_5_Button2_ = InfoOnScreen_2Label_;
//       InfoOnScreenLeft_Label_All_++;
//       InfoOnScreen();
       ///iMA_OneLineOnScreen(PERIOD_M5,Num_);
       //ObjectSetString(0,Symbol()+"_InfoOnScreen_Label4",OBJPROP_TEXT,(string)InfoOnScreen_2Label_);
       
//      }
//    if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button"+string(2+Num_),OBJPROP_STATE)== false)
//      {if (Num_ == 0)iMA5_5_Button2St = false;
//       if (Num_ == 1)iMA5_5_Button3St = false;
//       if (Num_ == 2)iMA5_5_Button4St = false;
//       if (Num_ == 3)iMA5_5_Button5St = false;
///       if (Num_ == 4)iMA5_5_Button6St = false;
//       InfoOnScreenLeft_2LabelDel("_iMA5_5Start_Button"+string(2+Num_));
       //iMA5_5_Button2_= 999;
//       InfoOnScreenLeft_Label_All_--;
       //InfoOnScreenLeft_2LabelOffset2(InfoOnScreenLeft_Label_All_);
//       InfoOnScreen();
       //iMA_DelOneLine(PERIOD_M5,Num_);
       //ObjectSetString(0,Symbol()+"_InfoOnScreen_Label4",OBJPROP_TEXT,(string)InfoOnScreen_2Label_);
//      }
//   } 
//+------------------------------------------------------------------+
//| iMA5_5_Button2                                                       
//|            
//+------------------------------------------------------------------+
//bool iMA5_5_Button3_;
//
//void iMA5_5_Button3()
//   {if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button7",OBJPROP_STATE)==true) 
//      {iMA5_5_Button7St = true;
//       ObjectSetInteger(0,Symbol()+"_iMA5_5Start_Button7",OBJPROP_COLOR,clrYellow);
//      }
//    if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button7",OBJPROP_STATE)==false)
//      {iMA5_5_Button7St = false;
//       ObjectSetInteger(0,Symbol()+"_iMA5_5Start_Button7",OBJPROP_COLOR,clrBlack);
//      }
//   }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| iMA5_5_Button3                                                       
//|            
//+------------------------------------------------------------------+
//int iMA5_5_Button3_;
//
//void iMA5_5_Button3()
//   {if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button3",OBJPROP_STATE)== true)
//      {iMA5_5_Button3St = true;
//       //InfoOnScreen_2Label(iMA5_5_ButtonInfo(1));
//       //iMA5_5_Button3_ = InfoOnScreen_2Label_;
///      InfoOnScreenLeft_Label_All_++;
//       InfoOnScreen();
//       iMA_OneLineOnScreen(PERIOD_M5,1);
//       //ObjectSetString(0,Symbol()+"_InfoOnScreen_Label4",OBJPROP_TEXT,(string)InfoOnScreen_2Label_);       
//      }
//    if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button3",OBJPROP_STATE)== false)
//      {iMA5_5_Button3St = false;
//       //InfoOnScreen_2LabelDel(iMA5_5_Button3_);
//       //iMA5_5_Button2_= 999;
//       InfoOnScreenLeft_Label_All_--;
//       InfoOnScreen();
//      iMA_DelOneLine(PERIOD_M5,1);
       //ObjectSetString(0,Symbol()+"_InfoOnScreen_Label4",OBJPROP_TEXT,(string)InfoOnScreen_2Label_);
//      }
//   }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| iMA5_5_Button3                                                       
//|            
//+------------------------------------------------------------------+
//int iMA5_5_Button4_;
//
//void iMA5_5_Button4()
//   {if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button4",OBJPROP_STATE)== true)
//      {iMA5_5_Button4St = true;
//       //InfoOnScreen_2Label(iMA5_5_ButtonInfo(2));
//       //iMA5_5_Button4_ = InfoOnScreen_2Label_;
//       InfoOnScreenLeft_Label_All_++;
//       InfoOnScreen();
//       iMA_OneLineOnScreen(PERIOD_M5,2);
       //ObjectSetString(0,Symbol()+"_InfoOnScreen_Label4",OBJPROP_TEXT,(string)InfoOnScreen_2Label_);
//       
//      }
//    if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button4",OBJPROP_STATE)== false)
//      {iMA5_5_Button4St = false;
       //InfoOnScreen_2LabelDel(iMA5_5_Button4_);
       //iMA5_5_Button2_= 999;
//       InfoOnScreenLeft_Label_All_--;
//       InfoOnScreen();
//       iMA_DelOneLine(PERIOD_M5,2);
       //ObjectSetString(0,Symbol()+"_InfoOnScreen_Label4",OBJPROP_TEXT,(string)InfoOnScreen_2Label_);
//      }
//   } 
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| iMA5_5_Button5                                                       
//|            
//+------------------------------------------------------------------+
//int iMA5_5_Button5_;
//
//void iMA5_5_Button5()
//   {if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button5",OBJPROP_STATE)== true)
//      {iMA5_5_Button5St = true;
//       //InfoOnScreen_2Label(iMA5_5_ButtonInfo(3));
//       //iMA5_5_Button5_ = InfoOnScreen_2Label_;
//       InfoOnScreenLeft_Label_All_++;
//       InfoOnScreen();
//       iMA_OneLineOnScreen(PERIOD_M5,3);
//       //ObjectSetString(0,Symbol()+"_InfoOnScreen_Label4",OBJPROP_TEXT,(string)InfoOnScreen_2Label_);
//      
//      }
//    if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button5",OBJPROP_STATE)== false)
//      {iMA5_5_Button5St = false;
//       //InfoOnScreen_2LabelDel(iMA5_5_Button5_);
//       //iMA5_5_Button2_= 999;
//       InfoOnScreenLeft_2LabelDel();
//       InfoOnScreenLeft_Label_All_--;
//       InfoOnScreen();
//       iMA_DelOneLine(PERIOD_M5,3);
//       //ObjectSetString(0,Symbol()+"_InfoOnScreen_Label4",OBJPROP_TEXT,(string)InfoOnScreen_2Label_);
//      }
//   } 
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| iMA5_5_Button5                                                       
//|            
//+------------------------------------------------------------------+
//int iMA5_5_Button6_;
//
//
//void iMA5_5_Button6()
//   {if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button6",OBJPROP_STATE)== true)
//      {iMA5_5_Button6St = true;
//       //InfoOnScreen_2Label(iMA5_5_ButtonInfo(4));
//       //iMA5_5_Button6_ = InfoOnScreen_2Label_;
//       InfoOnScreenLeft_Label_All_++;
//       InfoOnScreen();
//       iMA_OneLineOnScreen(PERIOD_M5,4);
//       //ObjectSetString(0,Symbol()+"_InfoOnScreen_Label4",OBJPROP_TEXT,(string)InfoOnScreen_2Label_);
//       
//      }
//    if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button6",OBJPROP_STATE)== false)
//      {iMA5_5_Button6St = false;
//       //InfoOnScreen_2LabelDel(iMA5_5_Button6_);
//       //iMA5_5_Button2_= 999;
//       InfoOnScreenLeft_Label_All_--;
//       InfoOnScreen();
//       iMA_DelOneLine(PERIOD_M5,4);
//       //ObjectSetString(0,Symbol()+"_InfoOnScreen_Label4",OBJPROP_TEXT,(string)InfoOnScreen_2Label_);
//      }
//   } 
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| iMA5_5_Button5Info                                                       
//|            
//+------------------------------------------------------------------+
//string iMA5_5_Button5Info()
//   {string Text_;
//    if (iMACross5_5[3].iMAOpCl_Trend != NULL)
//      {Text_ = iMACross5_5[3].iMAOpCl_Trend + "  " + 
//       (string)iMACross5_5[3].iMATime_Life  + "  " +
// /      (string)iMACross5_5[3].iMABody       + "  " +
//       (string)iMACross5_5[3].iMAOpen_Price
//       ;
//      }
//    return(Text_);
//   }



               //Alert(iMACross5_5[NumCross_+i].iMAOpCl_Trend);
       //if (iMACurrent_Trend == NULL)iMACurrent_Trend = iMACross5_5[NumCross_].iMAOpCl_Trend;
       //Если нулевой элемент
       //if (iMACross5_5[NumCross_].iMAOpCl_Trend != iMACurrent_Trend) 
       //  {for (int i=0;i<=4;i++)
       //     {if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button"+string(2+i),OBJPROP_STATE)== true) 
       //        {iMA_DelOneLine(Timeframe_,NumCross_+i); 
       //        }
       //     }
       //   iMA_OffsetCross5_5(); 
       //   //Заполнение 0 элемента
       //   iMA_FillingStruct(Trend_,NumCadle_,NumCross_,Timeframe_,Time_);                           
       //   iMACurrent_Trend =  iMACross5_5[NumCross_].iMAOpCl_Trend;
       //   Alert("Test");         
       //  }   
       //if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button1",OBJPROP_STATE)== true)
       //  {iMA5_5_Button1_Filling_Label();          
       //  }
       //Alert("Test");
       //if (Trend_ == "UP")
       //  {//Print(Trend_," ",iMACross5_5[NumCross_].iMAOpCl_Trend," ",iMACross5_5[NumCross_+1].iMAOpCl_Trend);
       //   if (iMACross5_5[NumCross_].iMAOpCl_Trend != "UP" &&
       //       iMACross5_5[NumCross_+1].iMAOpCl_Trend != "DW"
       //      )
       //     {
             
               
             
             //ObjectSetInteger(0,Symbol()+"_iMA5_5Start_Button2",OBJPROP_COLOR,clrLime);
             //ObjectSetInteger(0,Symbol()+"_iMA5_5Start_Button3",OBJPROP_COLOR,clrRed);
             //ObjectSetInteger(0,Symbol()+"_iMA5_5Start_Button4",OBJPROP_COLOR,clrLime);
             //ObjectSetInteger(0,Symbol()+"_iMA5_5Start_Button5",OBJPROP_COLOR,clrRed);
             //ObjectSetInteger(0,Symbol()+"_iMA5_5Start_Button6",OBJPROP_COLOR,clrLime);
        //    }
        // }
       //if (Trend_ == "DW")
       //  {//Print(Trend_," ",iMACross5_5[NumCross_].iMAOpCl_Trend," ",iMACross5_5[NumCross_+1].iMAOpCl_Trend);
       //   if (iMACross5_5[NumCross_].iMAOpCl_Trend != "DW" &&
       //       iMACross5_5[NumCross_+1].iMAOpCl_Trend != "UP"
       //      )
       //     {if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button2",OBJPROP_STATE)== true) iMA_DelOneLine(Timeframe_,NumCross_); 
       //      if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button3",OBJPROP_STATE)== true) iMA_DelOneLine(Timeframe_,NumCross_+1); 
       //      if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button4",OBJPROP_STATE)== true) iMA_DelOneLine(Timeframe_,NumCross_+2); 
       //      if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button5",OBJPROP_STATE)== true) iMA_DelOneLine(Timeframe_,NumCross_+3); 
       //      if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button6",OBJPROP_STATE)== true) iMA_DelOneLine(Timeframe_,NumCross_+4);  
       //      if (iMACross5_5[NumCross_].iMAOpCl_Trend != NULL) iMA_OffsetCross5_5();   
       //      iMA_FillingStruct(Trend_,NumCadle_,NumCross_,Timeframe_,Time_);
       //      if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button2",OBJPROP_STATE)== true) iMA_OneLineOnScreen(Timeframe_,NumCross_);
       //      if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button3",OBJPROP_STATE)== true) iMA_OneLineOnScreen(Timeframe_,NumCross_+1);
       //      if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button4",OBJPROP_STATE)== true) iMA_OneLineOnScreen(Timeframe_,NumCross_+2);
       //      if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button5",OBJPROP_STATE)== true) iMA_OneLineOnScreen(Timeframe_,NumCross_+3);
       //      if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button6",OBJPROP_STATE)== true) iMA_OneLineOnScreen(Timeframe_,NumCross_+4);
       //      
       //      ObjectSetInteger(0,Symbol()+"_iMA5_5Start_Button2",OBJPROP_COLOR,clrRed);
       //      ObjectSetInteger(0,Symbol()+"_iMA5_5Start_Button3",OBJPROP_COLOR,clrLime);
       //      ObjectSetInteger(0,Symbol()+"_iMA5_5Start_Button4",OBJPROP_COLOR,clrRed);
       //      ObjectSetInteger(0,Symbol()+"_iMA5_5Start_Button5",OBJPROP_COLOR,clrLime);
       //      ObjectSetInteger(0,Symbol()+"_iMA5_5Start_Button6",OBJPROP_COLOR,clrRed);
       //      //Alert(NumCross_,Trend_);
             //ObjectSetInteger(0,Symbol()+"_iMA5_5Start_Button1",OBJPROP_COLOR,clrRed);
             
             //Alert(NumCross_," ",Trend_); 
       //     }
       //  }
       //Alert(iMACross5_5[NumCross_].iMAOpCl_Trend);  
      //}



//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+

   
   
   
   
   
   
   
   
   
   
   
   
   
//+------------------------------------------------------------------+
//| iMA5_5_Button                                                       
//|            
//+------------------------------------------------------------------+
//void iMA5_5_Button1()
//   {if (ObjectGetInteger(0,Symbol()+"_iMA_Start_Button1",OBJPROP_STATE)== true)
//      {int x = 180;
//       int y = 25;
//       int a = 25;                                                      // Высота 
//       int b = 360;                                                     // Ширина
//       RectLabelCreate(0,Symbol()+"_iMA5_5_RectLabel",0,x+b,y,b,a);
//       LabelCreate(0,Symbol()+"_iMA5_5_Label1",0,x+105,y+5,"PriceOpen");
//       LabelCreate(0,Symbol()+"_iMA5_5_Label2",0,x+50, y+5,"0.000000");
//       LabelCreate(0,Symbol()+"_iMA5_5_Label3",0,x+170,y+5,"TimeLife");
//       LabelCreate(0,Symbol()+"_iMA5_5_Label4",0,x+125,y+5,"000");
//       LabelCreate(0,Symbol()+"_iMA5_5_Label5",0,x+255,y+5,"Force");
//       LabelCreate(0,Symbol()+"_iMA5_5_Label6",0,x+220,y+5,"000");
//       LabelCreate(0,Symbol()+"_iMA5_5_Label7",0,x+275,y+5,"00");
//       ButtonCreate(0,Symbol()+"_iMA5_5_Button1",0,x+350,y,"10");
//       ObjectSetInteger(0,Symbol()+"_iMA5_5_Button1",OBJPROP_XSIZE,65);
//       ButtonCreate(0,Symbol()+"_iMA5_5_Button2",0,x+295,y,"X");
//       ObjectSetInteger(0,Symbol()+"_iMA5_5_Button2",OBJPROP_XSIZE,15);
       //iMA5_5_Button1_Filling_Label();
//      }
//    if (ObjectGetInteger(0,Symbol()+"_iMA5_5Start_Button1",OBJPROP_STATE)== false)
//      {//iMA5_5_Button1Del();
       //iMA5_5_Button2Del();
       //iMA5_5_Button3Del();
//      }
//   }
//+------------------------------------------------------------------+
//| iMA5_5_Button_OnScreen                                                       
//|           
//+------------------------------------------------------------------+
//void iMA5_5_Button1_Filling_Label()
//   {ObjectSetString(0,Symbol()+"_iMA5_5_Label2",OBJPROP_TEXT,string(iMACross5_5[0].iMAOpen_Price));
//   ObjectSetString(0,Symbol()+"_iMA5_5_Label4",OBJPROP_TEXT,string(iMACross5_5[0].iMATime_Life)); 
//    ObjectSetString(0,Symbol()+"_iMA5_5_Label6",OBJPROP_TEXT,string((float)iMACross5_5[0].iMAForce)); 
//    ObjectSetString(0,Symbol()+"_iMA5_5_Label7",OBJPROP_TEXT,iMACross5_5[0].iMAOpCl_Trend);  
//    //Alert(MyiMA5Cross5[0].iMAOpCl_Time);  
//   }
//   //+------------------------------------------------------------------+
//| iMA5_5_ButtonDel                                                       
//|            
//+------------------------------------------------------------------+
//void iMA5_5_Button1Del()
//   {ObjectDelete(Symbol()+"_iMA5_5_RectLabel");
//    ObjectDelete(Symbol()+"_iMA5_5_Label1");
//    ObjectDelete(Symbol()+"_iMA5_5_Label2");
//    ObjectDelete(Symbol()+"_iMA5_5_Label3");
//    ObjectDelete(Symbol()+"_iMA5_5_Label4"); 
//    ObjectDelete(Symbol()+"_iMA5_5_Label5");
//    ObjectDelete(Symbol()+"_iMA5_5_Label6");
//    ObjectDelete(Symbol()+"_iMA5_5_Label7");
//    ObjectDelete(Symbol()+"_iMA5_5_Button1");
//    ObjectDelete(Symbol()+"_iMA5_5_Button2");     
//   }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| iMA5_5_Button                                                       
//|            
//+------------------------------------------------------------------+
//void iMA5_5_Button3()
//   {if (ObjectGetInteger(0,Symbol()+"_iMA5_5_Button1",OBJPROP_STATE)== true)
//      {int x = 180;
//       int y = 50;
//       int a = 360;                                                     // Высота 
//       int b = 280;                                                     // Ширина
//       int c = 180;                                                    
//       int e = 25;
//       RectLabelCreate(0,Symbol()+"_iMA5_5_RectLabe2",0,x+b,y,b,a);
//       iMA5_5_Button3_Label_Create();  
//       //iMA5_5_Button3_Filling_Label();   
//      }   
//    if (ObjectGetInteger(0,Symbol()+"_iMA5_5_Button1",OBJPROP_STATE)== false)
//      {iMA5_5_Button2Del();
//      }    
//   }
//+------------------------------------------------------------------+
//| iMA5_5_Button3_Filling_Label                                                             
//|                    
//+------------------------------------------------------------------+   
//void iMA5_5_Button3_Filling_Label()
//   {for (int i=0;i<=9;i++)
//      {ObjectSetString(0,Symbol()+"_iMA5_5_Label"+string(i*10+11),OBJPROP_TEXT,string(iMACross5_5[i+1].iMAOpen_Price));
//       ObjectSetString(0,Symbol()+"_iMA5_5_Label"+string(i*10+13),OBJPROP_TEXT,string(iMACross5_5[i+1].iMATime_Life)); 
//       ObjectSetString(0,Symbol()+"_iMA5_5_Label"+string(i*10+15),OBJPROP_TEXT,string((float)iMACross5_5[i+1].iMAForce)); 
//       ObjectSetString(0,Symbol()+"_iMA5_5_Label"+string(i*10+16),OBJPROP_TEXT,iMACross5_5[i+1].iMAOpCl_Trend);
//      }
//   }   
//+------------------------------------------------------------------+
//| iMA5_5_Button3_Label_Create                                                             
//|                    
//+------------------------------------------------------------------+
//void iMA5_5_Button3_Label_Create()
//   {int x = 180;
//    int y = 50;
//    int a = 15;
//    for(int i=0;i<=9;i++)
//      {LabelCreate(0,Symbol()+"_iMA5_5_Label"+string(i*10+10),0,x+105,y+5+a*i,"PriceOpen");
//       LabelCreate(0,Symbol()+"_iMA5_5_Label"+string(i*10+11),0,x+50, y+5+a*i,"0.000000");
//       LabelCreate(0,Symbol()+"_iMA5_5_Label"+string(i*10+12),0,x+170,y+5+a*i,"TimeLife");
//       LabelCreate(0,Symbol()+"_iMA5_5_Label"+string(i*10+13),0,x+125,y+5+a*i,"000");
//       LabelCreate(0,Symbol()+"_iMA5_5_Label"+string(i*10+14),0,x+255,y+5+a*i,"Force");
//       LabelCreate(0,Symbol()+"_iMA5_5_Label"+string(i*10+15),0,x+220,y+5+a*i,"000");
//       LabelCreate(0,Symbol()+"_iMA5_5_Label"+string(i*10+16),0,x+275,y+5+a*i,"00");
//      }
//   }
 //+------------------------------------------------------------------+
//| iMA5_5_ButtonDel                                                       
//|            
//+------------------------------------------------------------------+
//void iMA5_5_Button2Del()
//   {ObjectDelete(Symbol()+"_iMA5_5_RectLabe2");
//    
//    for (int i=0;i<=9;i++)
//      {ObjectDelete(Symbol()+"_iMA5_5_Label"+string(i*10+10));
//       ObjectDelete(Symbol()+"_iMA5_5_Label"+string(i*10+11));
//       ObjectDelete(Symbol()+"_iMA5_5_Label"+string(i*10+12));
//       ObjectDelete(Symbol()+"_iMA5_5_Label"+string(i*10+13));
//       ObjectDelete(Symbol()+"_iMA5_5_Label"+string(i*10+14));
//       ObjectDelete(Symbol()+"_iMA5_5_Label"+string(i*10+15));
//       ObjectDelete(Symbol()+"_iMA5_5_Label"+string(i*10+16));
//      }
//   }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| iMA5_5_Button4                                                       
//|            
//+------------------------------------------------------------------+
//string iMA5_5_NameLineV[100];
//string iMA5_5_NameLineH[100];


//void iMA5_5_Button4()
//   {if (ObjectGetInteger(0,Symbol()+"_iMA5_5_Button2",OBJPROP_STATE)== true)
//      {//Alert("1");
       //for (int i=1;i<=NumCrossiMA5_5-1;i++)
       //  {if(MyiMA5Cross5[i].iMAOpCl_Trend == "UP")
       //     {MyVLineUP_Time(MyiMA5Cross5[i].iMAOpCl_Time,0,PERIOD_M5,string(MyiMA5Cross5[i].iMAOpCl_Time)+"_iMA5_5");
       //      MyHlineUP_Price(MyiMA5Cross5[i].iMAOpen_Price,0,PERIOD_M5,string(MyiMA5Cross5[i].iMAOpen_Price)+"_iMA5_5"+(string)i);
       //      iMA5_5_NameLineV[i] =Symbol()+"_VLineUP_"+ string(MyiMA5Cross5[i].iMAOpCl_Time)+"_iMA5_5";
       //      iMA5_5_NameLineH[i] =Symbol()+"_HLineUP_"+ string(MyiMA5Cross5[i].iMAOpen_Price)+"_iMA5_5"+(string)i;
       //     }
       //   if(MyiMA5Cross5[i].iMAOpCl_Trend == "DW")
       //     {MyVLineDW_Time(MyiMA5Cross5[i].iMAOpCl_Time,0,PERIOD_M5,string(MyiMA5Cross5[i].iMAOpCl_Time)+"_iMA5_5");
       //      MyHlineDW_Price(MyiMA5Cross5[i].iMAOpen_Price,0,PERIOD_M5,string(MyiMA5Cross5[i].iMAOpen_Price)+"_iMA5_5"+(string)i);
       //      iMA5_5_NameLineV[i] =Symbol()+"_VLineDW_"+ string(MyiMA5Cross5[i].iMAOpCl_Time)+"_iMA5_5";
       //      iMA5_5_NameLineH[i] =Symbol()+"_HLineDW_"+ string(MyiMA5Cross5[i].iMAOpen_Price)+"_iMA5_5"+(string)i;
       //     }  
       //  }
//      }    
//    if (ObjectGetInteger(0,Symbol()+"_iMA5_5_Button2",OBJPROP_STATE)== false)
//      {iMA5_5_Button3Del();
//      }
//   }
 //+------------------------------------------------------------------+
//| iMA5_5_ButtonDel                                                       
//|            
//+------------------------------------------------------------------+
//void iMA5_5_Button3Del()
//   {for (int i=1;i<=NumCrossiMA5_5-1;i++)
//      {ObjectDelete(iMA5_5_NameLineV[i]);
//       ObjectDelete(iMA5_5_NameLineH[i]);
//      }
//   }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| iMA5_15_Button2                                                       
//|            
//+------------------------------------------------------------------+
//void iMA5_15_Button2()
//   {if (ObjectGetInteger(0,Symbol()+"_iMA5_15Start_Button2",OBJPROP_STATE)== true)
//      iMA5_15_Line_OnScreen();
//    if (ObjectGetInteger(0,Symbol()+"_iMA5_15Start_Button2",OBJPROP_STATE)== false)
//      iMA5_15_LineDel();
//   }
//+------------------------------------------------------------------+
//| iMA5_15_Line_OnScreen                                                       
//|           
//+------------------------------------------------------------------+
//void iMA5_15_Line_OnScreen()
//   {//if(MyiMA5Cross15[0].iMAOpCl_Trend == "UP")
    //  {if (ObjectFind(Symbol()+"_VLineUP_"+string(MyiMA5Cross15[0].iMAOpCl_Time)+"_iMA5_15")==-1)
    //     MyVLineUP_Time(MyiMA5Cross15[0].iMAOpCl_Time,0,PERIOD_M5,string(MyiMA5Cross15[0].iMAOpCl_Time)+"_iMA5_15");
    //   if (ObjectFind(Symbol()+"_HLineUP_"+string(MyiMA5Cross5[0].iMAOpen_Price)+"_iMA5_15")==-1)
    //     MyHlineUP_Price(MyiMA5Cross15[0].iMAOpen_Price,0,PERIOD_M5,string(MyiMA5Cross15[0].iMAOpen_Price)+"_iMA5_15");
    //  }
    //if(MyiMA5Cross15[0].iMAOpCl_Trend == "DW")
    //  {if (ObjectFind(Symbol()+"_VLineDW_"+string(MyiMA5Cross15[0].iMAOpCl_Time)+"_iMA5_15")==-1)
    //     MyVLineDW_Time(MyiMA5Cross15[0].iMAOpCl_Time,0,PERIOD_M5,string(MyiMA5Cross15[0].iMAOpCl_Time)+"_iMA5_15");
    //   if (ObjectFind(Symbol()+"_HLineDW_"+string(MyiMA5Cross15[0].iMAOpen_Price)+"_iMA5_15")==-1)
    //     MyHlineDW_Price(MyiMA5Cross15[0].iMAOpen_Price,0,PERIOD_M5,string(MyiMA5Cross15[0].iMAOpen_Price)+"_iMA5_15");
    //  }
//   } 
//+------------------------------------------------------------------+
//| iMA5_15_LineDel                                                       
//|            
//+------------------------------------------------------------------+
//void iMA5_15_LineDel(int    Num_ = 0)
//   {//ObjectDelete(Symbol()+"_VLineUP_"+string(MyiMA5Cross15[0].iMAOpCl_Time)+"_iMA5_15");
    //ObjectDelete(Symbol()+"_VLineDW_"+string(MyiMA5Cross15[0].iMAOpCl_Time)+"_iMA5_15");
    //ObjectDelete(Symbol()+"_HLineUP_"+string(MyiMA5Cross15[0].iMAOpen_Price)+"_iMA5_15");
    //ObjectDelete(Symbol()+"_HLineDW_"+string(MyiMA5Cross15[0].iMAOpen_Price)+"_iMA5_15");
    //Alert(MyiMA5Cross5[0].iMAOpCl_Time);
//   }
//+------------------------------------------------------------------+
//| LoadDataiMA5Period5                                                             
//|                      
//+------------------------------------------------------------------+
//void LoadDataiMA5Period15(string        Trend_     = "",             // Либо UP Либо DW
//                          int           NumCadle_  = 0,              // Номер свечи где происходит пересечение
//                          int           NumCross_  = 0,              // Номер пересечения
//                          const int     Timeframe_ = PERIOD_M5,      // Временной период
//                          const int     iMAPeriod_ = 5)              // Средняя
//   {//datetime Time_ = (iTime(Symbol(),Timeframe_,NumCadle_-1));
    //Alert(NumCross_,NumCadle_);
    //if (NumCross_ ==0)
    //  {//if (ObjectGetInteger(0,Symbol()+"_iMA5_15Start_Button1",OBJPROP_STATE)== true)
       //  {iMA5_5_Button1_Filling_Label();          
       //  }
    //   if (Trend_ == "UP")
    //     {ObjectSetInteger(0,Symbol()+"_iMA5_15Start_Button1",OBJPROP_COLOR,clrLime);
    //      ObjectSetInteger(0,Symbol()+"_iMA5_15Start_Button2",OBJPROP_COLOR,clrLime);
    //      if (MyiMA5Cross15[NumCross_].iMAOpCl_Trend != "UP" &&
    //          MyiMA5Cross15[NumCross_+1].iMAOpCl_Trend != "DW"
    //         )
    //        {if (MyiMA5Cross15[NumCross_].iMAOpCl_Trend != NULL) OffsetiMA5Cross15(); 
    //         if (ObjectGetInteger(0,Symbol()+"_iMA5_15Start_Button2",OBJPROP_STATE)== true) 
    //           {iMA5_15_LineDel(); 
    //            FillingStruct5_15(Trend_,NumCadle_,NumCross_,Timeframe_,Time_);  
    //            iMA5_15_Line_OnScreen();
    //           }
    //        }
    //     }
    //   if (Trend_ == "DW")
    //     {ObjectSetInteger(0,Symbol()+"_iMA5_15Start_Button1",OBJPROP_COLOR,clrRed);
    //      ObjectSetInteger(0,Symbol()+"_iMA5_15Start_Button2",OBJPROP_COLOR,clrRed);
    //      if (MyiMA5Cross15[NumCross_].iMAOpCl_Trend != "DW" &&
    //          MyiMA5Cross15[NumCross_+1].iMAOpCl_Trend != "UP"
    //         )
    //        {if (MyiMA5Cross15[NumCross_].iMAOpCl_Trend != NULL) OffsetiMA5Cross15();  
    //         if (ObjectGetInteger(0,Symbol()+"_iMA5_15Start_Button2",OBJPROP_STATE)== true) 
    //           {iMA5_15_LineDel(); 
    //            FillingStruct5_15(Trend_,NumCadle_,NumCross_,Timeframe_,Time_);  
    //            iMA5_15_Line_OnScreen();
    //           }
    //        }
    //     }
    //  }
   // FillingStruct5_15(Trend_,NumCadle_,NumCross_,Timeframe_,Time_);  
//   }
//+------------------------------------------------------------------+
//| OffsetiMA5Cross5                                                             
//| смещение структуры на 1                     
//+------------------------------------------------------------------+
//void OffsetiMA5Cross15 ()
//   {//for(int i=0;i<=NumCrossiMA5_5-1;i++)
    // {MyiMA5Cross15[i+1].iMAOpCl_Trend = MyiMA5Cross15[i].iMAOpCl_Trend;
    //  MyiMA5Cross15[i+1].iMAOpCl_Time  = MyiMA5Cross15[i].iMAOpCl_Time;
    //  MyiMA5Cross15[i+1].iMAOpen_Price = MyiMA5Cross15[i].iMAOpen_Price;
    //  
    // }
//   }
//+------------------------------------------------------------------+
//| FillingStruct                                                             
//|                 
//+------------------------------------------------------------------+
//void FillingStruct5_15 (string        Trend_     = "",                // Либо UP Либо DW
//                        int           NumCadle_  = 0,                 // Номер свечи где происходит пересечение
//                        int           NumCross_  = 0,                 // Номер пересечения
//                        const int     Timeframe_ = PERIOD_M5,         // Временной период
//                        datetime      Time_      = 0)                 // Номер пересечения)
//   {//MyiMA5Cross15[NumCross_].iMAOpCl_Trend = Trend_;
    //MyiMA5Cross15[NumCross_].iMAOpCl_Time  = Time_;
    //MyiMA5Cross15[NumCross_].iMAOpen_Price = iOpen(Symbol(),Timeframe_,NumCadle_-1);
    //MyiMA5Cross15[NumCross_].iMATime_Life  = NumCadle_;
    //MyiMA5Cross15[NumCross_].iMASpread     = (int)MarketInfo(Symbol(),MODE_SPREAD); 
    //if (Trend_ == "UP") MyiMA5Cross15[NumCross_].iMAForce = Bid - MyiMA5Cross15[NumCross_].iMAOpen_Price;
    //if (Trend_ == "DW") MyiMA5Cross15[NumCross_].iMAForce = MyiMA5Cross15[NumCross_].iMAOpen_Price - Ask;
//   } 
    //  {if (NumCross_== 0) {for (int i=1;i<=4;i++) {iMA5_5[i].SetupInd_001(i,1,PERIOD_M5,5);}}
    //     {if (ActiveSignal_==true){Alert("Смена тренда  Период "+ (string)TimeFrame_);}
    //     }         
    //   if (ActiveVisable_ == true)
    //     {DelOneCrossOnScreen_002(OldNameVline_,OldNameHline_);
    //      OneCrossOnScreen_002(NameVLine_,NameHLine_);
    //     }
       //iMA5_5ColorButton1(); 
       //iMA5_5Button[NumCross_].ColorButton(TypeTrend_); 
    //   OldTypeTrend_= TypeTrend_;
    //  }
        //if (iMA5_5[])0
    //if (iMA5_5[0].SetupInd_001(0,1,PERIOD_M5,5)== true)Alert("Test");
    //iMA5_15[0].CheckTrend();
    //if (NumCross_==0) 
       //  {for (int i=1;i<5;i++)
       //     {iMA5_5[i].SetupInd(i,1,PERIOD_M5,5);
       //      if (iMA5_5Button[0].State_ == true)iMA5_5ButtonGraf[i].ColorButton(iMA5_5[i].TypeTrend_);
       //     }
       //  }