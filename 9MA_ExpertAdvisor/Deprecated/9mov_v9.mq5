//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+


#property copyright "Farhan Rashid"
#include <Trade\Trade.mqh>

int mov1, mov2, mov3, mov4, mov5, mov6, mov7, mov8, mov9;

double openpricebuy,openpricesell;

double pointslimit=0.00500;

bool buy=false;
bool sell=false;

int barsTotal;
static double riskpercentage=0.05;


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
   barsTotal = iBars(_Symbol,PERIOD_CURRENT);
// show it on contemporary chart
   mov1 = iMA(_Symbol, PERIOD_CURRENT,8,0,MODE_SMMA,PRICE_CLOSE);
   mov2 = iMA(_Symbol, PERIOD_CURRENT,14,0,MODE_SMMA,PRICE_CLOSE);
   mov3 = iMA(_Symbol, PERIOD_CURRENT,20,0,MODE_SMMA,PRICE_CLOSE);
   mov4 = iMA(_Symbol, PERIOD_CURRENT,26,0,MODE_SMMA,PRICE_CLOSE);
   mov5 = iMA(_Symbol, PERIOD_CURRENT,46,0,MODE_SMMA,PRICE_CLOSE);
   mov6 = iMA(_Symbol, PERIOD_CURRENT,66,0,MODE_SMMA,PRICE_CLOSE);
   mov7 = iMA(_Symbol, PERIOD_CURRENT,72,0,MODE_SMMA,PRICE_CLOSE);
   mov8 = iMA(_Symbol, PERIOD_CURRENT,78,0,MODE_SMMA,PRICE_CLOSE);
   mov9 = iMA(_Symbol, PERIOD_CURRENT,84,0,MODE_SMMA,PRICE_CLOSE);


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
   Limit=Balance*0.07;


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
      CopyBuffer(mov1, MAIN_LINE, 1, 11, amov1);
      CopyBuffer(mov2, MAIN_LINE, 1, 11, amov2);
      CopyBuffer(mov3, MAIN_LINE, 1, 11, amov3);
      CopyBuffer(mov4, MAIN_LINE, 1, 11, amov4);
      CopyBuffer(mov5, MAIN_LINE, 1, 11, amov5);
      CopyBuffer(mov6, MAIN_LINE, 1, 11, amov6);
      CopyBuffer(mov7, MAIN_LINE, 1, 11, amov7);
      CopyBuffer(mov8, MAIN_LINE, 1, 11, amov8);
      CopyBuffer(mov9, MAIN_LINE, 1, 11, amov9);
      //last two close price
      double close1 = iClose(_Symbol,PERIOD_CURRENT,1);
      double close2 = iClose(_Symbol,PERIOD_CURRENT,2);


      //mqltrade sell operation
      MqlTradeRequest myrequest;
      MqlTradeResult myresult;
      ZeroMemory(myrequest);
      myrequest.action = TRADE_ACTION_DEAL;
      myrequest.type = ORDER_TYPE_SELL;
      myrequest.symbol = _Symbol;
      myrequest.type_filling = ORDER_FILLING_FOK;
      myrequest.price = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
      myrequest.tp = 0 ;
      myrequest.deviation = ULONG_MAX;

      double stopzsell = iHigh(_Symbol,PERIOD_CURRENT,HighestCandleM5);


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






      //
      //      if(!PositionSelect(_Symbol))
      //        {
      //
      //         if((amov1[r] > amov2[r] && amov2[r] > amov3[r] && amov3[r] > amov4[r] &&  amov4[r] > amov5[r] && amov5[r] > amov6[r] && amov6[r] > amov7[r] && amov7[r] > amov8[r] && amov8[r] > amov9[r])
      //            || (amov1[25] > amov2[25] && amov2[25] > amov3[25] && amov3[25] > amov4[25] &&  amov4[25] > amov5[25] && amov5[25] < amov6[25] && amov6[25] < amov7[25] && amov7[25] < amov8[25] && amov8[25] < amov9[25]))
      //           {
      //            if(amov1[25] < amov2[25] && amov2[25] < amov3[25] && amov3[25] < amov4[25] &&  amov4[25] < amov5[25] && amov5[25] > amov6[25] && amov6[25] > amov7[25] && amov7[25] > amov8[25] && amov8[25] > amov9[25])
      //              {
      //               if((amov1[15] > amov2[15] && amov2[15] > amov3[15] && amov3[15] > amov4[15] &&  amov4[15] > amov5[15] && amov5[15] > amov6[15] && amov6[15] > amov7[15] && amov7[15] > amov8[15] && amov8[15] > amov9[15])
      //                  && (amov1[5] > amov2[5] && amov2[5] > amov3[5] && amov3[5] > amov4[5] &&  amov4[5] > amov5[5] && amov5[5] > amov6[5] && amov6[5] > amov7[5] && amov7[5] > amov8[5] && amov8[5] > amov9[5]))
      //                 {
      //                  myrequest.volume = volumeGen(AccountInfoDouble(ACCOUNT_BALANCE), riskpercentage, iOpen(_Symbol,PERIOD_CURRENT,1), stopzsell, SymbolInfoDouble(_Symbol,SYMBOL_TRADE_CONTRACT_SIZE), myrequest.price);
      //                  OrderSend(myrequest,myresult);
      //                  openpricesell=myrequest.price;
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
      //                     openpricebuy=myrequest1.price;
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


      bool EquiliBool= false;
      bool BuySignal= false;
      bool SellSignal= false;

      int r = 10;
      int p = 1;



      if(EquiliBool==false)
        {

         if((amov1[r] > amov2[r] && amov2[r] > amov3[r] && amov3[r] > amov4[r] &&  amov4[r] > amov5[r] && amov5[r] > amov6[r] && amov6[r] > amov7[r] && amov7[r] > amov8[r] && amov8[r] > amov9[r])
            && (amov1[p] > amov2[p] && amov2[p] > amov3[p] && amov3[p] > amov4[p] &&  amov4[p] > amov5[p] && amov5[p] > amov6[p] && amov6[p] > amov7[p] && amov7[p] > amov8[p] && amov8[p] > amov9[p]))
           {
            EquiliBool=true;
            SellSignal=true;

           }
         else
            if((amov1[r] < amov2[r] && amov2[r] < amov3[r] && amov3[r] < amov4[r] &&  amov4[r] < amov5[r] && amov5[r] < amov6[r] && amov6[r] < amov7[r] && amov7[r] < amov8[r] && amov8[r] < amov9[r])
               && (amov1[p] < amov2[p] && amov2[p] < amov3[p] && amov3[p] < amov4[p] &&  amov4[p] < amov5[p] && amov5[p] < amov6[p] && amov6[p] < amov7[p] && amov7[p] < amov8[p] && amov8[p] < amov9[p]))
              {
               EquiliBool=true;
               BuySignal=true;

              }
            else
              {



              }


        }

      bool Buy2Signal=false;

      if(BuySignal==true)
        {

         if(amov1[r] > amov2[r] && amov2[r] > amov3[r] && amov3[r] > amov4[r] &&  amov4[r] > amov5[r] && amov5[r] < amov6[r] && amov6[r] < amov7[r] && amov7[r] < amov8[r] && amov8[r] < amov9[r])
           {
            myrequest.volume = volumeGen(AccountInfoDouble(ACCOUNT_BALANCE), riskpercentage, iOpen(_Symbol,PERIOD_CURRENT,1), stopzsell, SymbolInfoDouble(_Symbol,SYMBOL_TRADE_CONTRACT_SIZE), myrequest.price);
            OrderSend(myrequest1,myresult1);
            openpricebuy=myrequest1.price;
            SellSignal=false;
            EquiliBool=false;
            Buy2Signal=true;

           }
         else
           {


           }
           
           if(Buy2Signal==true){
           
            if(myrequest1.price < amov5[r]){
            
            myrequest.volume = volumeGen(AccountInfoDouble(ACCOUNT_BALANCE), riskpercentage, iOpen(_Symbol,PERIOD_CURRENT,1), stopzsell, SymbolInfoDouble(_Symbol,SYMBOL_TRADE_CONTRACT_SIZE), myrequest.price);
            OrderSend(myrequest1,myresult1);
            openpricebuy=myrequest.price;
            SellSignal=false;
            EquiliBool=false;
            Buy2Signal=true;
            
            
            }
           
           
           } else {
           
           
           }
           
           
           





        }

      bool Sell2Signal=false;

      if(SellSignal==true)
        {

         if(amov1[r] < amov2[r] && amov2[r] < amov3[r] && amov3[r] < amov4[r] &&  amov4[r] < amov5[r] && amov5[r] > amov6[r] && amov6[r] > amov7[25] && amov7[r] > amov8[r] && amov8[r] > amov9[r])
           {
            myrequest.volume = volumeGen(AccountInfoDouble(ACCOUNT_BALANCE), riskpercentage, iOpen(_Symbol,PERIOD_CURRENT,1), stopzsell, SymbolInfoDouble(_Symbol,SYMBOL_TRADE_CONTRACT_SIZE), myrequest.price);
            OrderSend(myrequest,myresult);
            openpricesell=myrequest.price;
            SellSignal=false;
            EquiliBool=false;
            Sell2Signal=true;

           }
         else
           {


           }



        }


      if(Sell2Signal==true)
        {

         if(myrequest.price>amov5[r])
           {
            OrderSend(myrequest,myresult);
            Sell2Signal=false;
            EquiliBool=false;   
           }
         else
           {


           }


        }
     











      if(PositionSelect(_Symbol))
        {

         if(BuySignal==true || Buy2Signal==true && SellSignal==false)
           {

            double openp = openpricebuy;
            double bidp = SymbolInfoDouble(_Symbol,SYMBOL_BID);

            double dif;

            dif= openp-bidp;

            if(dif>pointslimit)
              {
               CloseOrder();
               buy=false;

              }
            else
              {


              }
            if(Equity<(Balance-Limit))
              {
               CloseOrder();
               buy=false;

              }
            else
              {
              }

            if(amov8[15]<amov5[15] && amov5[13]<amov8[13])
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

               double opent = openpricesell;
               double bidt = SymbolInfoDouble(_Symbol,SYMBOL_BID);

               double dift;
               dift= opent-bidt;

               if(1-dift>(1+pointslimit))
                 {

                  CloseOrder();
                  sell=false;

                 }
               else
                 {

                 }
               if(Equity<(Balance-Limit))
                 {

                  CloseOrder();
                  sell=false;

                 }
               else
                 {
                 }

               if(amov8[15]>amov5[15] && amov5[13]>amov8[13])
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
              ,"\nMA5:", DoubleToString(amov5[1],_Digits)
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
