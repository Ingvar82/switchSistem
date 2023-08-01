//+------------------------------------------------------------------+
//|                                                    Obj_Paint.mqh |
//|                        Copyright 2014, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, MetaQuotes Software Corp."
#property link      "http://www.mql5.com"
#property strict

#include <MyLib\Variables_.mqh>

//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//| OneCrossOnScreen                                         
//| создает вертикальную и горизонтальную на точке пересечения iFractal5_5                                                      
//| проверяет объекты на наличие и создает по номеру пересечения          
//+------------------------------------------------------------------+
void OneCrossOnScreen(const int      timeFrame_,
                      const string   typeTrend_,
                      const string   nameVLine_,
                      const datetime time_,
                      const string   nameHLine_,
                      const double   price_)
   {if(typeTrend_ == "UP")
      {if (ObjectFind(nameVLine_)==-1)  MyVLineUP_Time(time_,0,timeFrame_,nameVLine_);
       else Print("Объект "+nameVLine_+" существует!!!");
       if (ObjectFind(nameHLine_)==-1)  MyHlineUP_Price(price_,0,timeFrame_,nameHLine_);
       else Print("Объект "+nameHLine_+" существует!!!");
      }
    if(typeTrend_ == "DW")
      {if (ObjectFind(nameVLine_)==-1) MyVLineDW_Time(time_,0,timeFrame_,nameVLine_ );
       else Print("Объект "+nameVLine_+" существует!!!");
       if (ObjectFind(nameHLine_)==-1) MyHlineDW_Price(price_,0,timeFrame_,nameHLine_);
       else Print("Объект "+nameHLine_+" существует!!!");
      }      
   } 
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//| iFractal_DelOneLine                                                        
//| удаляет вертикальную и горизонтальную на точке пересечения                                                       
//| проверяет объекты на наличие и удаляет по номеру пересечения           
//+------------------------------------------------------------------+
void DelOneCrossOnScreen(const string nameVLine_,
                         const string nameHLine_)
   {if (ObjectFind(nameVLine_)!=-1) ObjectDelete(nameVLine_);
    else Print("Объект "+nameVLine_+" не существует!!!");
    if (ObjectFind(nameHLine_)!=-1) ObjectDelete(nameHLine_);
    else Print("Объект "+nameHLine_+" не существует!!!");
   }  
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//| Создает горизонтальную линию         Obj_Paint                                 
//+------------------------------------------------------------------+
bool HLineCreate(const long            chart_ID=0,                   // ID графика
                 const string          name="HLine",                 // имя линии
                 const int             sub_window=0,                 // номер подокна
                 const double          price=0,                      // цена линии
                 const color           clr=clrRed,                   // цвет линии
                 const int             width=1,                      // толщина линии
                 const ENUM_LINE_STYLE style=STYLE_SOLID,            // стиль линии
                 const bool            back=true,                    // на заднем плане
                 const bool            selection=false,              // выделить для перемещений
                 const bool            hidden=false,                 // скрыт в списке объектов
                 const long            z_order=0)                    // приоритет на нажатие мышью
  {ResetLastError();
   if(!ObjectCreate(chart_ID,name,OBJ_HLINE,sub_window,0,price))
   {Print(__FUNCTION__,
    ": не удалось создать горизонтальную линию! Код ошибки = ",GetLastError());
    return(false);
   }
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
   return(true);
  }  
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Создает вертикальную линию                 Obj_Paint                          |
//+------------------------------------------------------------------+
bool VLineCreate(const long            chart_ID=0,                   // ID графика
                 const string          name="VLine",                 // имя линии
                 const int             sub_window=0,                 // номер подокна
                 const datetime        time=0,                       // время линии
                 const color           clr=clrRed,                   // цвет линии
                 const int             width=1,                      // толщина линии
                 const ENUM_LINE_STYLE style=STYLE_SOLID,            // стиль линии
                 const bool            back=true,                    // на заднем плане
                 const bool            selection=false,              // выделить для перемещений
                 const bool            hidden=true,                  // скрыт в списке объектов
                 const long            z_order=0)                    // приоритет на нажатие мышью
  {ResetLastError();
   if(!ObjectCreate(chart_ID,name,OBJ_VLINE,sub_window,time,0))
     {Print(__FUNCTION__,": не удалось создать вертикальную линию! Код ошибки = ",GetLastError());
      return(false);
     }
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
   return(true);
  }
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//| Создает объект "Текст"                Obj_Paint                   
//+------------------------------------------------------------------+
bool TextCreate(const long              chart_ID=0,                  // ID графика
                const string            name="Text",                 // имя объекта
                const int               sub_window=0,                // номер подокна
                datetime                time=0,                      // время точки привязки
                double                  price=0,                     // цена точки привязки
                const string            text="Text",                 // сам текст
                const color             clr=clrWhite,                // цвет
                const string            font="Arial",                // шрифт
                const int               font_size=10,                // размер шрифта                
                const double            angle=90.0,                   // наклон текста
                const ENUM_ANCHOR_POINT anchor=ANCHOR_LOWER,         // способ привязки
                const bool              back=false,                  // на заднем плане
                const bool              selection=false,             // выделить для перемещений
                const bool              hidden=true,                 // скрыт в списке объектов
                const long              z_order=0)                   // приоритет на нажатие мышью
  {//ChangeTextEmptyPoint(time,price);
   ResetLastError();
   if(!ObjectCreate(chart_ID,name,OBJ_TEXT,sub_window,time,price))
     {Print(__FUNCTION__,
      ": не удалось создать объект \"Текст\"! Код ошибки = ",GetLastError());
      return(false);
     }
   ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
   ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
   ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle);
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
   return(true);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Создает прямоугольную метку             Obj_Paint  
//+------------------------------------------------------------------+
bool RectLabelCreate(const long             chart_ID=0,               // ID графика
                     const string           name="RectLabel",         // имя метки
                     const int              sub_window=0,             // номер подокна
                     const int              x=0,                      // координата по оси X
                     const int              y=0,                      // координата по оси Y
                     const int              width=50,                 // ширина
                     const int              height=18,                // высота
                     const ENUM_BASE_CORNER corner=CORNER_RIGHT_UPPER,// угол графика для привязки
                     const color            back_clr=clrSlateGray,    // цвет фона                     
                     const int              line_width=3,             // толщина плоской границы
                     const color            clr=clrRed,               // цвет плоской границы (Flat)
                     const ENUM_LINE_STYLE  style=STYLE_SOLID,        // стиль плоской границы
                     const ENUM_BORDER_TYPE border=BORDER_SUNKEN,     // тип границы
                     const bool             back=false,               // на заднем плане
                     const bool             selection=false,          // выделить для перемещений
                     const bool             hidden=true,              // скрыт в списке объектов
                     const long             z_order=0)                // приоритет на нажатие мышью
  {ResetLastError();
   if(!ObjectCreate(chart_ID,name,OBJ_RECTANGLE_LABEL,sub_window,0,0))
     {Print(__FUNCTION__,
      name + ": не удалось создать прямоугольную метку! Код ошибки = ",GetLastError());
      return(false);
     }
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
   ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
   ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
   ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_TYPE,border);
   ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,line_width);
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
   return(true);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Создает текстовую метку               Obj_Paint  
//+------------------------------------------------------------------+
bool LabelCreate(const long              chart_ID=0,                 // ID графика
                 const string            name="Label",               // имя метки
                 const int               sub_window=0,               // номер подокна
                 const int               x=0,                        // координата по оси X
                 const int               y=0,                        // координата по оси Y
                 const string            text="Label",               // текст
                 const ENUM_BASE_CORNER  corner=CORNER_RIGHT_UPPER,  // угол графика для привязки
                 const color             clr=clrBlack,               // цвет
                 const string            font="Arial",               // шрифт
                 const int               font_size=8,                // размер шрифта
                 const double            angle=0.0,                  // наклон текста
                 const ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER,   // способ привязки
                 const bool              back=false,                 // на заднем плане
                 const bool              selection=false,            // выделить для перемещений
                 const bool              hidden=true,                // скрыт в списке объектов
                 const long              z_order=0)                  // приоритет на нажатие мышью
  {ResetLastError();
   if(!ObjectCreate(chart_ID,name,OBJ_LABEL,sub_window,0,0))
     {Print(__FUNCTION__,
      name + ": не удалось создать текстовую метку! Код ошибки = ",GetLastError());
      return(false);
     }
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
   ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
   ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
   ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
   ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle);
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
   return(true);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Создает кнопку                           Obj_Paint  
//+------------------------------------------------------------------+
bool ButtonCreate(const long              chart_ID=0,                // ID графика
                  const string            name="Button",             // имя кнопки
                  const int               sub_window=0,              // номер подокна
                  const int               x=0,                       // координата по оси X
                  const int               y=0,                       // координата по оси Y
                  const string            text="Button",             // текст
                  const int               width=80,                  // ширина кнопки
                  const int               height=25,                 // высота кнопки
                  const bool              state=false,               // нажата/отжата
                  const ENUM_BASE_CORNER  corner=CORNER_RIGHT_UPPER, // угол графика для привязки
                  const int               font_size=10,              // размер шрифта
                  const string            font="Arial",              // шрифт
                  const color             clr=clrBlack,              // цвет текста
                  const color             back_clr=clrSlateGray,     // цвет фона
                  const color             border_clr=clrNONE,        // цвет границы
                  const bool              back=false,                // на заднем плане
                  const bool              selection=false,           // выделить для перемещений
                  const bool              hidden=true,               // скрыт в списке объектов
                  const long              z_order=0)                 // приоритет на нажатие мышью
  {ResetLastError();
   if(!ObjectCreate(chart_ID,name,OBJ_BUTTON,sub_window,0,0))
     {Print(__FUNCTION__,": не удалось создать кнопку! Код ошибки = ",GetLastError());
      return(false);
     }
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
   ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
   ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
   ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
   ObjectSetString (chart_ID,name,OBJPROP_TEXT,text);
   ObjectSetString (chart_ID,name,OBJPROP_FONT,font);
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_COLOR,border_clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
   ObjectSetInteger(chart_ID,name,OBJPROP_STATE,state);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
   return(true);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Создает объект "Поле ввода"           Obj_Paint  
//+------------------------------------------------------------------+
bool EditCreate(const long             chart_ID=0,                   // ID графика
                const string           name="Edit",                  // имя объекта
                const int              sub_window=0,                 // номер подокна
                const int              x=0,                          // координата по оси X
                const int              y=0,                          // координата по оси Y
                const string           text="Text",                  // текст
                const int              width=80,                     // ширина
                const int              height=25,                    // высота
                const string           font="Arial",                 // шрифт
                const ENUM_BASE_CORNER corner=CORNER_RIGHT_UPPER,    // угол графика для привязки
                const ENUM_ALIGN_MODE  align=ALIGN_CENTER,           // способ выравнивания
                const int              font_size=8,                  // размер шрифта
                const bool             read_only=false,              // возможность редактировать
                const color            clr=clrBlack,                 // цвет текста
                const color            back_clr=clrWhite,            // цвет фона
                const color            border_clr=clrNONE,           // цвет границы
                const bool             back=false,                   // на заднем плане
                const bool             selection=false,              // выделить для перемещений
                const bool             hidden=true,                  // скрыт в списке объектов
                const long             z_order=0)                    // приоритет на нажатие мышью
  {ResetLastError();
   if(!ObjectCreate(chart_ID,name,OBJ_EDIT,sub_window,0,0))
     {Print(__FUNCTION__,
      ": не удалось создать объект \"Поле ввода\"! Код ошибки = ",GetLastError());
      return(false);
     }
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
   ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
   ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
   ObjectSetString (chart_ID,name,OBJPROP_TEXT,text);
   ObjectSetString (chart_ID,name,OBJPROP_FONT,font);
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
   ObjectSetInteger(chart_ID,name,OBJPROP_ALIGN,align);
   ObjectSetInteger(chart_ID,name,OBJPROP_READONLY,read_only);
   ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_COLOR,border_clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
   return(true);
  }

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+  
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| MyHlineUP
//| Создает горизонтальную линию UP по ЦЕНЕ                                     
//+------------------------------------------------------------------+
void MyHlineUP_Price(const double      Price_     = 0,                // номер свечи 
                     const int         Size_      = 0,                // размер
                     const int         Timeframe_ = PERIOD_M5,        // таймфрейм отбражения линии
                     const string      Name_      = "",               // Имя
                     const color       ColorUp_   = clrDarkGreen)     
                      
   {if (Size_ == 0)
      HLineCreate(0,Name_,0,Price_,ColorUp_,1,STYLE_DOT);
    if (Size_ == 1)
      HLineCreate(0,Name_,0,Price_,ColorUp_,1,STYLE_SOLID);
   }
//+------------------------------------------------------------------+
//| MyHlineDW
//| Создает горизонтальную линию DW по ЦЕНЕ                                       
//+------------------------------------------------------------------+
void MyHlineDW_Price(const double      Price_     = 0,                // номер свечи 
                     const int         Size_      = 0,                // размер
                     const int         Timeframe_ = PERIOD_M5,        // таймфрейм отбражения линии 
                     const string      Name_      = "",               // Имя
                     const color       ColorDw_   = clrDarkRed)               
                     
   {if (Size_ == 0)
      HLineCreate(0,Name_,0,Price_,ColorDw_,1,STYLE_DOT);
    if (Size_ == 1)
      HLineCreate(0,Name_,0,Price_,ColorDw_,1,STYLE_SOLID);
   }  
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| MyVLineUP_Time
//| Создает вертикальную линию UP по Времени                                        
//+------------------------------------------------------------------+
void MyVLineUP_Time(const datetime      time_      = 0,               // номер свечи 
                    const int           size_      = 0,               // размер
                    const int           timeFrame_ = PERIOD_M5,       // таймфрейм отбражения линии
                    const string        name_      = "") 
   {if (size_ == 0)
    VLineCreate(0,name_,0,time_,ColorUp,1,STYLE_DOT);
    if (size_ == 1)
    VLineCreate(0,name_,0,time_,ColorUp,1,STYLE_SOLID);
   }
//+------------------------------------------------------------------+
//| MyVLineDW_Time
//| Создает вертикальную линию DW по Времени                                       
//+------------------------------------------------------------------+
void MyVLineDW_Time(const datetime      time_      = 0,               // номер свечи 
                    const int           size_      = 0,               // размер
                    const int           timeFrame_ = PERIOD_M5,       // таймфрейм отбражения линии  
                    const string        name_      = "")    
   {if (size_ == 0)
    VLineCreate(0,name_,0,time_,ColorDw,1,STYLE_DOT);
    if (size_ == 1)
    VLineCreate(0,name_,0,time_,ColorDw,1,STYLE_SOLID);
   }  
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+ 
//+------------------------------------------------------------------+
//| MyVLineUP_Cadle
//| Создает вертикальную линию UP по номеру свечи                                        
//+------------------------------------------------------------------+
//void MyVLineUP_Cadle(const int          Num_       = 0,                // номер свечи 
//                     const int          Size_      = 0,                // размер
//                     const int          Timeframe_ = PERIOD_M5,       // таймфрейм отбражения линии  
//                     const string       Name_      = "") 
//   {if (Size_ == 0)
//    VLineCreate(0,"VLineiMA15_50ClUp_"+string(iTime(Symbol(),Timeframe_,Num_)),0,iTime(Symbol(),Timeframe_,Num_),ColorUp,1,STYLE_DOT);
//    if (Size_ == 1)
//    VLineCreate(0,"VLineiMA15_50ClUp_"+string(iTime(Symbol(),Timeframe_,Num_)),0,iTime(Symbol(),Timeframe_,Num_),ColorUp,1,STYLE_SOLID);
//   }
//+------------------------------------------------------------------+
//| MyVLineDW_Cadle
//| Создает вертикальную линию DW по номеру свечи                                        
//+------------------------------------------------------------------+
//void MyVLineDW_Cadle(const int         Num_       = 0,                // номер свечи 
//                     const int         Size_      = 0,                // размер
//                     const int         Timeframe_ = PERIOD_M5,       // таймфрейм отбражения линии 
//                     const string      Name_      = "")     
//   {if (Size_ == 0)
//    VLineCreate(0,"VLineiMA15_50ClDw_"+string(iTime(Symbol(),Timeframe_,Num_)),0,iTime(Symbol(),Timeframe_,Num_),ColorDw,1,STYLE_DOT);
//    if (Size_ == 1)
//    VLineCreate(0,"VLineiMA15_50ClUp_"+string(iTime(Symbol(),Timeframe_,Num_)),0,iTime(Symbol(),Timeframe_,Num_),ColorDw,1,STYLE_SOLID);
//   }
//+------------------------------------------------------------------+
//| MyHlineUP
//| Создает горизонтальную линию UP по номеру свечи                                           
//+------------------------------------------------------------------+
//void MyHlineUP(   const int             Num       = 0,                // номер свечи 
//                  const int             Size_      = 0,               // размер
//                  const int             Timeframe = PERIOD_M5)       // таймфрейм отбражения линии 
//   {
//    HLineCreate(0,"HlineUP_"+string(iTime(Symbol(),Timeframe,Num)),0,iOpen(Symbol(),Timeframe,Num),ColorUp,1,STYLE_DOT);
//   }
//+------------------------------------------------------------------+
//| MyHlineDW
//| Создает горизонтальную линию DW по номеру свечи                                       
//+------------------------------------------------------------------+
//void MyHlineDW(   const int             Num       = 0,                // номер свечи 
//                  const int             Size_      = 0,               // размер
//                  const int             Timeframe = PERIOD_M5)       // таймфрейм отбражения линии 
//   {
//    HLineCreate(0,"HlineDW_"+string(iTime(Symbol(),Timeframe,Num)),0,iOpen(Symbol(),Timeframe,Num),ColorDw,1,STYLE_DOT);
//   }
  








