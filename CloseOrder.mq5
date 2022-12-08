#property copyright "Farhan Rashid"

#include <Trade\Trade.mqh>


int barsTotal;
static int gapped=50000;

int OnInit()
  {
   barsTotal = iBars(_Symbol,PERIOD_CURRENT);


   return(INIT_SUCCEEDED);
  }


void OnDeinit(const int reason)
  {


  }


void OnTick()
  {

      MqlTradeRequest myrequest;
      MqlTradeResult myresult;
      ZeroMemory(myrequest);
      ZeroMemory(myresult);
      myrequest.action = TRADE_ACTION_DEAL;
      myrequest.type = ORDER_TYPE_BUY;
      myrequest.symbol = _Symbol;
      myrequest.volume = 0.1;
      myrequest.type_filling = ORDER_FILLING_FOK;
      myrequest.price = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      myrequest.deviation = ULONG_MAX;
      myrequest.sl = iClose(_Symbol,PERIOD_M1,1);
      myrequest.tp = iClose(_Symbol,PERIOD_H1,32) ;
  
      
      if(gapped==0){
      
      Sleep(500);
      
      OrderSend(myrequest,myresult);
      
      
   } else{
   Sleep(1000);
   gapped--;
   
   
   }
   
   
       
   //int j= MathRand();
   
   if(gapped<0) {
   
   CloseBuyOrder();
   
   
   } else {
   Sleep(3000);
   //ZeroMemory(j);
   }
   
   
   
     
  }


void CloseBuyOrder()
  {
   CTrade trade;
   int i = PositionsTotal()-1;
   while(i>=0)
     {
      if(trade.PositionClose(PositionGetSymbol(i)))
         i--;
     }
     
     if(trade.ResultRetcode()==10008)
              {

               
               Print("Buy order sold at %lf", iClose(_Symbol,PERIOD_CURRENT,1));
              }
            else
              {
               Print("ERROR NOT CLOSED AT POSITION %lf", iClose(_Symbol,PERIOD_CURRENT,1));
              }
     
  }
  
  
  
  