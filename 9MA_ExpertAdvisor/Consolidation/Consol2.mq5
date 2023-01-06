//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#include <Trade\Trade.mqh>


double SL=0.5;
double TP=1.5;
double Buyopn,Sellopn;
double Allow=0.00020;
double pointstop=0.00500;
static double riskpercentage=0.15;
static double ddprcnt=0.5;

double Rmax, Rmin, Top, Bottom;
double Range;
static double FPL=0.5;

bool Conso=false;
bool RangeComplete=false;


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
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

   int HighestA, LowestA, HighestB, LowestB, HighestC, LowestC, HighestN, LowestN;
   double HighA[], LowA[], HighB[], LowB[], HighC[], LowC[], HighN[], LowN[];

   double Bid = SymbolInfoDouble(Symbol(),SYMBOL_BID);
   double Ask = SymbolInfoDouble(Symbol(),SYMBOL_ASK);

   ArraySetAsSeries(HighA,false);
   ArraySetAsSeries(LowA,false);
   ArraySetAsSeries(HighB,false);
   ArraySetAsSeries(LowB,false);
   ArraySetAsSeries(HighC,false);
   ArraySetAsSeries(LowC,false);
   ArraySetAsSeries(HighN,false);
   ArraySetAsSeries(LowN,false);

   CopyHigh(_Symbol,PERIOD_CURRENT,1,30,HighN);
   CopyLow(_Symbol,PERIOD_CURRENT,1,30,LowN);

   ArrayCopy(HighA,HighN,0,0,10);
   ArrayCopy(LowA,LowN,0,0,10);
   ArrayCopy(HighB,HighN,0,10,10);
   ArrayCopy(LowB,LowN,0,10,10);
   ArrayCopy(HighC,HighN,0,20,10);
   ArrayCopy(LowC,LowN,0,20,10);

   HighestA = ArrayMaximum(HighA,0,WHOLE_ARRAY);
   LowestA = ArrayMinimum(LowA,0,WHOLE_ARRAY);
   HighestB = ArrayMaximum(HighB,0,WHOLE_ARRAY);
   LowestB = ArrayMinimum(LowB,0,WHOLE_ARRAY);
   HighestC = ArrayMaximum(HighC,0,WHOLE_ARRAY);
   LowestC = ArrayMinimum(LowC,0,WHOLE_ARRAY);
   HighestN = ArrayMaximum(HighN,0,WHOLE_ARRAY);
   LowestN = ArrayMinimum(LowN,0,WHOLE_ARRAY);


   double maxA = HighA[HighestA];
   double maxB = HighB[HighestB];
   double maxC = HighC[HighestC];
   double maxN = HighN[HighestN];
   double minA = LowA[LowestA];
   double minB = LowB[LowestB];
   double minC = LowC[LowestC];
   double minN = LowN[LowestN];

   double RA=maxA-minA;
   double RB=maxB-minB;
   double RC=maxC-minC;
   double RN=maxN-minN;

   double Equity=AccountInfoDouble(ACCOUNT_EQUITY);
   double Balance=AccountInfoDouble(ACCOUNT_BALANCE);


   if(!PositionSelect(_Symbol))
     {
      if(Conso==false)
        {
         if(maxB>=maxC+Allow && maxB<=maxC+Allow)
           {
            if(minB>=minC-Allow && minB<=minC+Allow)
              {
               Top=(maxB+maxC)/2;
               Bottom=(minB+minC)/2;
               Range=Top-Bottom;
               Conso=true;
              }
           }
        }

      if(Conso==true)
        {
         if(RA<=Range+(Range*0.2) && RA>=Range-(Range*0.2))
           {
            RangeComplete=true;
           }
        }

      if(RangeComplete==true)
        {   
         if(Bid<Top-(RN*0.40) && Bid>Top-(RN*0.60))
           {
            double EnPriceS=Bid;
            double SLS=Top+(RN*SL);
            double TPS=EnPriceS-(TP*(SLS-EnPriceS));

            double EnPriceB=Ask;
            double SLB=Bottom-(RN*SL);
            double TPB=EnPriceB+(TP*(EnPriceB-SLB));

            //mqltrade Sell operation

            MqlTradeRequest myrequestSell;
            MqlTradeResult myresultSell;
            ZeroMemory(myrequestSell);
            ZeroMemory(myresultSell);
            myrequestSell.action = TRADE_ACTION_DEAL;
            myrequestSell.type = ORDER_TYPE_SELL;
            myrequestSell.symbol = _Symbol;
            myrequestSell.type_filling = ORDER_FILLING_FOK;
            myrequestSell.price = EnPriceS;
            myrequestSell.sl = SLS;
            myrequestSell.tp = TPS;
            myrequestSell.volume = volumeGen(AccountInfoDouble(ACCOUNT_BALANCE), riskpercentage, EnPriceS, SLS, SymbolInfoDouble(_Symbol,SYMBOL_TRADE_CONTRACT_SIZE), SymbolInfoDouble(_Symbol,SYMBOL_BID));
            myrequestSell.deviation = 5;

            OrderSend(myrequestSell,myresultSell);
            Sellopn=myrequestSell.price;

            //mqltrade Buy operation

            MqlTradeRequest myrequestBuy;
            MqlTradeResult myresultBuy;
            ZeroMemory(myrequestBuy);
            ZeroMemory(myresultBuy);
            myrequestBuy.action = TRADE_ACTION_DEAL;
            myrequestBuy.type = ORDER_TYPE_BUY;
            myrequestBuy.symbol = _Symbol;
            myrequestBuy.type_filling = ORDER_FILLING_FOK;
            myrequestBuy.price = EnPriceB;
            myrequestBuy.sl = SLB;
            myrequestBuy.tp = TPB;
            myrequestBuy.volume = volumeGen(AccountInfoDouble(ACCOUNT_BALANCE), riskpercentage, EnPriceB, SLB, SymbolInfoDouble(_Symbol,SYMBOL_TRADE_CONTRACT_SIZE), SymbolInfoDouble(_Symbol,SYMBOL_ASK));
            myrequestBuy.deviation = 5;

            OrderSend(myrequestBuy,myresultBuy);
            Buyopn=myrequestBuy.price;

           }
        }

      if(Conso==true)
        {
         if(Ask>=Top+Range || Ask<=Bottom-Range)
           {
            Conso=false;
            RangeComplete=false;
           }
         if(Bid>=Top+Range || Bid<=Bottom-Range)
           {
            Conso=false;
            RangeComplete=false;
           }
        }
     }


   if(PositionSelect(_Symbol))
     {
      if(Equity<(Balance-(Balance*ddprcnt)))
        {
         CloseOrder();
        }
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
