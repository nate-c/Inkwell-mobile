class InvestmentObject {
 
  int shares;
  String ticker;
  int averagePrice;
  int currentPrice;

  InvestmentObject(this.shares, this.ticker, this.averagePrice, this.currentPrice);

  InvestmentObject.fromJson(Map<String, dynamic> json)
      : shares = json['shares'],
        ticker = json['ticker'],
        averagePrice = json['average_price'],
        currentPrice = json['current_price'];

  Map<String, dynamic> toJson() => {
        'shares': shares,
        'ticker': ticker,
        'average_price': averagePrice,
        'current_price': currentPrice,
        
      };
}