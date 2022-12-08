
#property copyright "Farhan Rashid"



int handleFastMa, handleMiddleMa, handleSlowMa;
int barsTotal;


int OnInit()
  {
   barsTotal = iBars(_Symbol,PERIOD_CURRENT);

   handleFastMa = iMA(NULL, PERIOD_CURRENT,10,0,MODE_SMA,PRICE_CLOSE);
   handleMiddleMa = iMA(NULL, PERIOD_CURRENT,50,0,MODE_SMA,PRICE_CLOSE);
   handleSlowMa = iMA(NULL, PERIOD_CURRENT,100,0,MODE_SMA,PRICE_CLOSE);

   return(INIT_SUCCEEDED);
  }


void OnDeinit(const int reason)
  {


  }


void OnTick()
  {

   int bars = iBars(_Symbol,PERIOD_CURRENT);
   if(barsTotal < bars)
     {
      barsTotal = bars;

      double fastMa[];
      double MiddleMa[];
      double slowMa[];

      CopyBuffer(handleFastMa, MAIN_LINE,1,2,fastMa);
      CopyBuffer(handleMiddleMa, MAIN_LINE,1,2,MiddleMa);
      CopyBuffer(handleSlowMa, MAIN_LINE,1,2,slowMa);


      double close1 = iClose(_Symbol,PERIOD_CURRENT,1);
      double close2 = iClose(_Symbol,PERIOD_CURRENT,2);

      if(fastMa[1]> MiddleMa[1] && MiddleMa[1]> slowMa[1])
        {
         if(close1 > fastMa[1]
            && close2 < fastMa[0])
           {
            Print("Sell de, dam kombe :D ");
           }
        }

      if(fastMa[1] < MiddleMa[1] && MiddleMa[1] < slowMa[1])
        {
         if(close1 < fastMa[1]
            && close2 > fastMa[0])
           {
            Print("Buy de... dam barbe !! :D ");
           }
        }



      Comment("FastMa[0]:", DoubleToString(fastMa[0],_Digits)
              ,"| FastMa[1]:",DoubleToString(fastMa[1],_Digits)
              ,"\nmiddleMa[0]:", DoubleToString(MiddleMa[0],_Digits)
              ,"| MiddleMa[1]:",DoubleToString(MiddleMa[1],_Digits)
              ,"\nSlowma[0]:", DoubleToString(slowMa[0],_Digits)
              ,"|SlowMa[1]:",DoubleToString(slowMa[1],_Digits)
              ,"\nClose1:", DoubleToString(close1,_Digits)
              ,"|Close2:",DoubleToString(close2,_Digits));

     }
  }
