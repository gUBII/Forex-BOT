bool CloseOrder(int ticket, double lots, int slippage, int tries, int pause)
{
   bool result=false;
   double ask , bid;
   
   if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
   {
      RefreshRates();
      ask = NormalizeDouble(MarketInfo(OrderSymbol(),MODE_ASK),MarketInfo(OrderSymbol(),MODE_DIGITS));
      bid = NormalizeDouble(MarketInfo(OrderSymbol(),MODE_BID),MarketInfo(OrderSymbol(),MODE_DIGITS));
      
      if(OrderType()==OP_BUY)
      {
         for(int c = 0 ; c < tries ; c++)
         {
            if(lots==0) result = OrderClose(OrderTicket(),OrderLots(),bid,slippage,Violet);
            else result = OrderClose(OrderTicket(),lots,bid,slippage,Violet);
            if(result==true) break; 
            else
            {
               Sleep(pause);
               RefreshRates();
               ask = NormalizeDouble(MarketInfo(OrderSymbol(),MODE_ASK),MarketInfo(OrderSymbol(),MODE_DIGITS));
               bid = NormalizeDouble(MarketInfo(OrderSymbol(),MODE_BID),MarketInfo(OrderSymbol(),MODE_DIGITS));      
               continue;
            }
         }
      }
      if(OrderType()==OP_SELL)
      {
         for(c = 0 ; c < tries ; c++)
         {
            if(lots==0) result = OrderClose(OrderTicket(),OrderLots(),ask,slippage,Violet);
            else result = OrderClose(OrderTicket(),lots,ask,slippage,Violet);
            if(result==true) break; 
            else
            {
               Sleep(pause);
               RefreshRates();
               ask = NormalizeDouble(MarketInfo(OrderSymbol(),MODE_ASK),MarketInfo(OrderSymbol(),MODE_DIGITS));
               bid = NormalizeDouble(MarketInfo(OrderSymbol(),MODE_BID),MarketInfo(OrderSymbol(),MODE_DIGITS));  
               continue;
            }
         }
      }
   }
   return(result);
}
