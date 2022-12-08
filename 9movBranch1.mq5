//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+

#property copyright "Farhan Rashid"
#include <Trade\Trade.mqh>

int mov1, mov2, mov3, mov4, mov5, mov6, mov7, mov8, mov9;


static bool buy=false;
static bool sell=false;

int barsTotal;


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
   barsTotal = iBars(_Symbol,PERIOD_CURRENT);
// show it on contemporary chart
   mov1 = iMA(NULL, PERIOD_CURRENT,8,0,MODE_EMA,PRICE_CLOSE);
   mov2 = iMA(NULL, PERIOD_CURRENT,14,0,MODE_EMA,PRICE_CLOSE);
   mov3 = iMA(NULL, PERIOD_CURRENT,20,0,MODE_EMA,PRICE_CLOSE);
   mov4 = iMA(NULL, PERIOD_CURRENT,26,0,MODE_EMA,PRICE_CLOSE);
   mov5 = iMA(NULL, PERIOD_CURRENT,32,0,MODE_EMA,PRICE_CLOSE);
   mov6 = iMA(NULL, PERIOD_CURRENT,38,0,MODE_EMA,PRICE_CLOSE);
   mov7 = iMA(NULL, PERIOD_CURRENT,44,0,MODE_EMA,PRICE_CLOSE);
   mov8 = iMA(NULL, PERIOD_CURRENT,50,0,MODE_EMA,PRICE_CLOSE);
   mov9 = iMA(NULL, PERIOD_CURRENT,56,0,MODE_EMA,PRICE_CLOSE);


   return(INIT_SUCCEEDED);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {


  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {


   int HighestCandleM5,LowestCandleM5;
   double High[],Low[];
   ArraySetAsSeries(High,true);
   ArraySetAsSeries(Low,true);

   CopyHigh(_Symbol,PERIOD_CURRENT,0,11,High);
   CopyLow(_Symbol,PERIOD_CURRENT,0,11,Low);

   HighestCandleM5 = ArrayMaximum(High,0,11);
   LowestCandleM5 = ArrayMinimum(Low,0,11);





   int bars = iBars(_Symbol,PERIOD_CURRENT);
   if(barsTotal < bars)
     {
      barsTotal = bars;
      //array for storing moving average values
      double amov1[];
      double amov2[];
      double amov3[];
      double amov4[];
      double amov5[];
      double amov6[];
      double amov7[];
      double amov8[];
      double amov9[];

      //input stream for the moving average
      CopyBuffer(mov1, MAIN_LINE, 1, 14, amov1);
      CopyBuffer(mov2, MAIN_LINE, 1, 14, amov2);
      CopyBuffer(mov3, MAIN_LINE, 1, 14, amov3);
      CopyBuffer(mov4, MAIN_LINE, 1, 14, amov4);
      CopyBuffer(mov5, MAIN_LINE, 1, 14, amov5);
      CopyBuffer(mov6, MAIN_LINE, 1, 14, amov6);
      CopyBuffer(mov7, MAIN_LINE, 1, 14, amov7);
      CopyBuffer(mov8, MAIN_LINE, 1, 14, amov8);
      CopyBuffer(mov9, MAIN_LINE, 1, 14, amov9);
      //last two close price
      double close1 = iClose(_Symbol,PERIOD_CURRENT,1);
      double close2 = iClose(_Symbol,PERIOD_CURRENT,2);





      //mqltrade sell operation
      MqlTradeRequest myrequest;
      MqlTradeResult myresult;
      ZeroMemory(myrequest);
      ZeroMemory(myresult);
      myrequest.action = TRADE_ACTION_DEAL;
      myrequest.type = ORDER_TYPE_SELL;
      myrequest.symbol = _Symbol;
      myrequest.volume = 0.20;
      myrequest.type_filling = ORDER_FILLING_FOK;
      myrequest.price = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
      myrequest.tp = 0 ;
      myrequest.deviation = ULONG_MAX;
      //myrequest.sl = iHigh(_Symbol,PERIOD_CURRENT,HighestCandleM5);

      //mqltrade buy operation (still working)
      MqlTradeRequest myrequest1;
      MqlTradeResult myresult1;
      ZeroMemory(myrequest1);
      ZeroMemory(myresult1);
      myrequest1.action = TRADE_ACTION_DEAL;
      myrequest1.type = ORDER_TYPE_BUY;
      myrequest1.symbol = _Symbol;
      myrequest1.volume = 0.20;
      myrequest1.type_filling = ORDER_FILLING_FOK;
      myrequest1.price = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      myrequest1.tp = 0 ;
      myrequest1.deviation = ULONG_MAX;
      //myrequest1.sl = iLow(_Symbol,PERIOD_CURRENT,LowestCandleM5);


      bool btntrade,begintrade;
      int b=7;
     
//
//         if(amov1[1] < amov2[1] && amov2[1] < amov3[1] && amov3[1] < amov4[1] && amov4[1] < amov5[1] && amov5[1] < amov6[1] && amov6[1] < amov7[1] && amov7[1] < amov8[1] && amov8[1] < amov9[1]
//            || amov1[1] > amov2[1] && amov2[1] > amov3[1] && amov3[1] > amov4[1] && amov4[1] > amov5[1] && amov5[1] > amov6[1] && amov6[1] > amov7[1] && amov7[1] > amov8[1] && amov8[1] > amov9[1])
//           {
            if(!PositionSelect(_Symbol))
              {

               if(amov1[1] < amov2[1] && amov2[1] < amov3[1] && amov3[1] < amov4[1] &&  amov4[1] < amov5[1] && amov5[1] > amov6[1] && amov6[1] > amov7[1] && amov7[1] > amov8[1] && amov8[1] > amov9[1]
                  || amov1[1] > amov2[1] && amov2[1] > amov3[1] && amov3[1] > amov4[1] &&  amov4[1] > amov5[1] && amov5[1] < amov6[1] && amov6[1] < amov7[1] && amov7[1] < amov8[1] && amov8[1] < amov9[1])
                 {
                  if(amov1[1] < amov2[1] && amov2[1] < amov3[1] && amov3[1] < amov4[1] &&  amov4[1] < amov5[1] && amov5[1] > amov6[1] && amov6[1] > amov7[1] && amov7[1] > amov8[1] && amov8[1] > amov9[1])
                    {
                     
                     if(amov1[b] > amov2[b] && amov2[b] > amov3[b] && amov3[b] > amov4[b] &&  amov4[b] > amov5[b] && amov5[b] > amov6[b] && amov6[b] > amov7[b] && amov7[b] > amov8[b] && amov8[b] > amov9[b]){
                     
                     OrderSend(myrequest,myresult);
                     
                     sell=true;
                     
                     } else {
                     
                     
                     }
                     

                    }
                  else
                     if(amov1[1] > amov2[1] && amov2[1] > amov3[1] && amov3[1] > amov4[1] &&  amov4[1] > amov5[1] && amov5[1] < amov6[1] && amov6[1] < amov7[1] && amov7[1] < amov8[1] && amov8[1] < amov9[1])
                       {

                        if(amov1[b] < amov2[b] && amov2[b] < amov3[b] && amov3[b] < amov4[b] &&  amov4[b] < amov5[b] && amov5[b] < amov6[b] && amov6[b] < amov7[b] && amov7[b] < amov8[b] && amov8[b] < amov9[b]){
                        
                        OrderSend(myrequest1,myresult1);
                      
                        buy=true;
                        
                        } else {
                        
                        
                        }
                        

                       }
                     else
                       {


                       }

                 }

              }
            else
              {




              }


//           }
//         else
//           {
//
//
//
//           }

        



      if(PositionSelect(_Symbol))
        {

         if(buy==true || sell==false)
           {

            if(amov1[1]<amov3[1])
              {

               CloseOrder();
               buy=false;

              }
            else
              {


              }

           }
         else
            if(sell==true || buy==false)
              {

               if(amov1[1]>amov3[1])
                 {

                  CloseOrder();
                  sell=false;

                 }
               else
                 {


                 }

              }
            else
              {



              }


        }
      else
        {


        }





      Comment("MA1:", DoubleToString(amov1[1],_Digits)
              ,"| MA1:",DoubleToString(amov2[1],_Digits)
              ,"\nMA3:", DoubleToString(amov3[1],_Digits)
              ,"| MA4",DoubleToString(amov4[1],_Digits)
              ,"\MA5:", DoubleToString(amov5[1],_Digits)
              ,"|MA6:",DoubleToString(amov6[1],_Digits)
              ,"\nMA7:", DoubleToString(amov7[1],_Digits)
              ,"|MA8:",DoubleToString(amov8[1],_Digits)
              ,"|MA9:",DoubleToString(amov9[1],_Digits));



     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//+------------------------------------------------------------------+
//
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//
void CloseOrder()
  {
   CTrade trade;
   int i = PositionsTotal()-1;
   while(i>=0)
     {
      if(trade.PositionClose(PositionGetSymbol(i)))
         i--;
     }
  }


//+------------------------------------------------------------------+
