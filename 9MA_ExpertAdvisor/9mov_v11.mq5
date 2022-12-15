//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+


#property copyright "Farhan Rashid"
#include <Trade\Trade.mqh>

int mov1, mov2, mov3, mov4, mov5, mov6, mov7, mov8, mov9;


static bool bulb1, bulb2, bulb3, bulb4, bulb6, bulb7, bulb8, bulb9;


//double varB,varS;

double meristop=0.00500;

//bool buy=false;
//bool sell=false;

int barsTotal;
static double riskpercentage=0.02;


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
   barsTotal = iBars(_Symbol,PERIOD_CURRENT);
// show it on contemporary chart
   mov1 = iMA(_Symbol, PERIOD_CURRENT,2,0,MODE_SMMA,PRICE_CLOSE);
   mov2 = iMA(_Symbol, PERIOD_CURRENT,14,0,MODE_SMMA,PRICE_CLOSE);
   mov3 = iMA(_Symbol, PERIOD_CURRENT,20,0,MODE_SMMA,PRICE_CLOSE);
   mov4 = iMA(_Symbol, PERIOD_CURRENT,26,0,MODE_SMMA,PRICE_CLOSE);
   mov5 = iMA(_Symbol, PERIOD_CURRENT,46,0,MODE_SMMA,PRICE_CLOSE);
   mov6 = iMA(_Symbol, PERIOD_CURRENT,66,0,MODE_SMMA,PRICE_CLOSE);
   mov7 = iMA(_Symbol, PERIOD_CURRENT,72,0,MODE_SMMA,PRICE_CLOSE);
   mov8 = iMA(_Symbol, PERIOD_CURRENT,78,0,MODE_SMMA,PRICE_CLOSE);
   mov9 = iMA(_Symbol, PERIOD_CURRENT,100,0,MODE_SMMA,PRICE_CLOSE);


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

   double Equity;
   double Balance;
   double Limit;

   int HighestCandleM5,LowestCandleM5;
   double High[],Low[];
   ArraySetAsSeries(High,true);
   ArraySetAsSeries(Low,true);

   CopyHigh(_Symbol,PERIOD_CURRENT,0,11,High);
   CopyLow(_Symbol,PERIOD_CURRENT,0,11,Low);

   HighestCandleM5 = ArrayMaximum(High,0,6);
   LowestCandleM5 = ArrayMinimum(Low,0,6);

   Equity=AccountInfoDouble(ACCOUNT_EQUITY);
   Balance=AccountInfoDouble(ACCOUNT_BALANCE);
   //Limit=Balance*0.05;


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
      CopyBuffer(mov1, MAIN_LINE, 1, 2, amov1);
      CopyBuffer(mov2, MAIN_LINE, 1, 2, amov2);
      CopyBuffer(mov3, MAIN_LINE, 1, 2, amov3);
      CopyBuffer(mov4, MAIN_LINE, 1, 2, amov4);
      CopyBuffer(mov5, MAIN_LINE, 1, 2, amov5);
      CopyBuffer(mov6, MAIN_LINE, 1, 2, amov6);
      CopyBuffer(mov7, MAIN_LINE, 1, 2, amov7);
      CopyBuffer(mov8, MAIN_LINE, 1, 2, amov8);
      CopyBuffer(mov9, MAIN_LINE, 1, 2, amov9);
      //last two close price
      double close1 = iClose(_Symbol,PERIOD_CURRENT,1);
      double close2 = iClose(_Symbol,PERIOD_CURRENT,2);


      //mqltrade sell operation
//            MqlTradeRequest myrequest;
//            MqlTradeResult myresult;
//            ZeroMemory(myrequest);
//            myrequest.action = TRADE_ACTION_DEAL;
//            myrequest.type = ORDER_TYPE_SELL;
//            myrequest.symbol = _Symbol;
//            myrequest.type_filling = ORDER_FILLING_FOK;
//            myrequest.price = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
//            myrequest.tp = 0 ;
//            myrequest.deviation = ULONG_MAX;
//      
//            double stopzsell = iHigh(_Symbol,PERIOD_CURRENT,HighestCandleM5);



      //mqltrade buy operation (still working)

      MqlTradeRequest myrequest1;
      MqlTradeResult myresult1;
      ZeroMemory(myrequest1);
      ZeroMemory(myresult1);
      myrequest1.action = TRADE_ACTION_DEAL;
      myrequest1.type = ORDER_TYPE_BUY;
      myrequest1.symbol = _Symbol;
      myrequest1.type_filling = ORDER_FILLING_FOK;
      myrequest1.price = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      myrequest1.tp = 0 ;
      myrequest1.deviation = ULONG_MAX;

      double stopzbuy = iLow(_Symbol,PERIOD_CURRENT,LowestCandleM5);






      //bulb 1
      if(amov1[1] > amov5[1])
        {
         bulb1=true;
        }
      else
         if(amov1[1] < amov5[1])
           {
            bulb1=false;
           }
         else
           {
            printf("Reached bulb1 fatal point");
           }


      //bulb2
      if(amov2[1] > amov5[1])
        {
         bulb2=true;
        }
      else
         if(amov2[1] < amov5[1])
           {
            bulb2=false;
           }
         else
           {
            printf("Reached bulb2 fatal point");
           }

      //bulb 3
      if(amov3[1]>amov5[1])
        {
         bulb3=true;
        }
      else
         if(amov3[1]<amov5[1])
           {
            bulb3=false;
           }
         else
           {
            printf("Reached bulb3 fatal point");
           }




      //bulb4
      if(amov4[1]>amov5[1])
        {
         bulb4=true;
        }
      else
         if(amov4[1]<amov5[1])
           {
            bulb4=false;
           }
         else
           {
            printf("Reached bulb4 fatal point");
           }


      //bulb6

      if(amov6[1]<amov5[1])
        {
         bulb6=true;
        }
      else
         if(amov6[1]>amov5[1])
           {
            bulb6=false;
           }
         else
           {
            printf("Reached bulb6 fatal point");
           }

      //bulb7

      if(amov7[1]<amov5[1])
        {
         bulb7=true;
        }
      else
         if(amov7[1]>amov5[1])
           {
            bulb7=false;
           }
         else
           {
            printf("Reached bulb7 fatal point");
           }



      //bulb8

      if(amov8[1]<amov5[1])
        {
         bulb8=true;
        }
      else
         if(amov8[1]>amov5[1])
           {
            bulb8=false;
           }
         else
           {
            printf("Reached bulb8 fatal point");
           }



      if(amov9[1]<amov5[1])
        {
         bulb9=true;
        }
      else
         if(amov9[1]>amov5[1])
           {
            bulb9=false;
           }
         else
           {
            printf("Reached bulb9 fatal point");
           }




      if(!PositionSelect(_Symbol))
        {

         if(bulb1==true && bulb2==true && bulb3==true && bulb4==true && bulb6==true && bulb7==true && bulb7==true && bulb8==true && bulb9==true)
           {
             myrequest1.volume = volumeGen(AccountInfoDouble(ACCOUNT_BALANCE), riskpercentage, iOpen(_Symbol,PERIOD_CURRENT,1), stopzbuy, SymbolInfoDouble(_Symbol,SYMBOL_TRADE_CONTRACT_SIZE), myrequest1.price);
            OrderSend(myrequest1,myresult1);
            //varS=myrequest.price;

           }
         else
           {

            printf("Bulbs are not ONN ");
           }


        }



      if(PositionSelect(_Symbol))
        {

         if(bulb1==false && bulb2==false && bulb3==false && bulb4==false && bulb6==false && bulb7==false && bulb7==false && bulb8==false && bulb9==false)
           {

            CloseOrder();

           }
         else
           {

            printf("Bulbs are not OFF");

           }


        }

























      //      if(!PositionSelect(_Symbol))
      //        {
      //
      //         if((amov1[25] < amov2[25] && amov2[25] < amov3[25] && amov3[25] < amov4[25] &&  amov4[25] < amov5[25] && amov5[25] > amov6[25] && amov6[25] > amov7[25] && amov7[25] > amov8[25] && amov8[25] > amov9[25])
      //            || (amov1[25] > amov2[25] && amov2[25] > amov3[25] && amov3[25] > amov4[25] &&  amov4[25] > amov5[25] && amov5[25] < amov6[25] && amov6[25] < amov7[25] && amov7[25] < amov8[25] && amov8[25] < amov9[25]))
      //           {
      //            if(amov1[25] < amov2[25] && amov2[25] < amov3[25] && amov3[25] < amov4[25] &&  amov4[25] < amov5[25] && amov5[25] > amov6[25] && amov6[25] > amov7[25] && amov7[25] > amov8[25] && amov8[25] > amov9[25])
      //              {
      //               if((amov1[15] > amov2[15] && amov2[15] > amov3[15] && amov3[15] > amov4[15] &&  amov4[15] > amov5[15] && amov5[15] > amov6[15] && amov6[15] > amov7[15] && amov7[15] > amov8[15] && amov8[15] > amov9[15])
      //                  && (amov1[5] > amov2[5] && amov2[5] > amov3[5] && amov3[5] > amov4[5] &&  amov4[5] > amov5[5] && amov5[5] > amov6[5] && amov6[5] > amov7[5] && amov7[5] > amov8[5] && amov8[5] > amov9[5]))
      //                 {
      //                  myrequest.volume = volumeGen(AccountInfoDouble(ACCOUNT_BALANCE), riskpercentage, iOpen(_Symbol,PERIOD_CURRENT,1), stopzsell, SymbolInfoDouble(_Symbol,SYMBOL_TRADE_CONTRACT_SIZE), myrequest.price);
      //                  OrderSend(myrequest,myresult);
      //                  varS=myrequest.price;
      //                  sell=true;
      //                 }
      //               else
      //                 {
      //                 }
      //              }
      //            else
      //               if(amov1[25] > amov2[25] && amov2[25] > amov3[25] && amov3[25] > amov4[25] &&  amov4[25] > amov5[25] && amov5[25] < amov6[25] && amov6[25] < amov7[25] && amov7[25] < amov8[25] && amov8[25] < amov9[25])
      //                 {
      //                  if((amov1[15] < amov2[15] && amov2[15] < amov3[15] && amov3[15] < amov4[15] &&  amov4[15] < amov5[15] && amov5[15] < amov6[15] && amov6[15] < amov7[15] && amov7[15] < amov8[15] && amov8[1] < amov9[15])
      //                     && (amov1[5] < amov2[5] && amov2[5] < amov3[5] && amov3[5] < amov4[5] &&  amov4[5] < amov5[5] && amov5[5] < amov6[5] && amov6[5] < amov7[5] && amov7[5] < amov8[5] && amov8[5] < amov9[5]))
      //                    {
      //                     myrequest1.volume = volumeGen(AccountInfoDouble(ACCOUNT_BALANCE), riskpercentage, iOpen(_Symbol,PERIOD_CURRENT,1), stopzbuy, SymbolInfoDouble(_Symbol,SYMBOL_TRADE_CONTRACT_SIZE), myrequest1.price);
      //                     OrderSend(myrequest1,myresult1);
      //                     varB=myrequest1.price;
      //                     buy=true;
      //                    }
      //                  else
      //                    {
      //                    }
      //                 }
      //               else
      //                 {
      //
      //
      //                 }
      //
      //           }
      //
      //        }
      //      else
      //        {
      //
      //
      //
      //
      //        }
















      //      if(PositionSelect(_Symbol))
      //        {
      //
      //         if(buy==true || sell==false)
      //           {
      //
      //            double openp = varB;
      //            double bidp = SymbolInfoDouble(_Symbol,SYMBOL_BID);
      //
      //            double dif;
      //
      //            dif= openp-bidp;
      //
      //            if(dif>meristop)
      //              {
      //               CloseOrder();
      //               buy=false;
      //
      //              }
      //            else
      //              {
      //
      //
      //              }
      //            if(Equity<(Balance-Limit))
      //              {
      //               CloseOrder();
      //               buy=false;
      //
      //              }
      //            else
      //              {
      //              }
      //
      //            if(amov8[15]<amov5[15] && amov5[13]<amov8[13])
      //              {
      //
      //               CloseOrder();
      //               buy=false;
      //
      //              }
      //            else
      //              {
      //
      //
      //              }
      //
      //           }
      //         else
      //            if(sell==true || buy==false)
      //              {
      //
      //               double opent = varS;
      //               double bidt = SymbolInfoDouble(_Symbol,SYMBOL_BID);
      //
      //               double dift;
      //               dift= opent-bidt;
      //
      //               if(1-dift>(1+meristop))
      //                 {
      //
      //                  CloseOrder();
      //                  sell=false;
      //
      //                 }
      //               else
      //                 {
      //
      //                 }
      //               if(Equity<(Balance-Limit))
      //                 {
      //
      //                  CloseOrder();
      //                  sell=false;
      //
      //                 }
      //               else
      //                 {
      //                 }
      //
      //               if(amov8[15]>amov5[15] && amov5[13]>amov8[13])
      //                 {
      //
      //                  CloseOrder();
      //                  sell=false;
      //
      //                 }
      //               else
      //                 {
      //
      //
      //                 }
      //
      //              }
      //            else
      //              {
      //
      //
      //
      //              }
      //
      //
      //        }
      //      else
      //        {
      //
      //
      //        }






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
//|                                                                  |
//+------------------------------------------------------------------+
double volumeGen(double accbalance, double riskperc, double openprice, double stoploss, double contractsize, double currprice)
  {

   double vol=0;
   double deltaprice=0;
   double pdev=0;
   double riskcap=0;
   double magi=0;
   double revisecont=contractsize/10;

   riskcap = accbalance * riskperc;

   deltaprice = MathAbs(openprice - stoploss)*revisecont;


   pdev=(0.00001 / currprice) * contractsize*100;

   magi= deltaprice*pdev;

   vol= riskcap /magi;

   double roundval=round(vol*100)/100;
   return roundval;
  }




//+------------------------------------------------------------------+
//+------------------------------------------------------------------+