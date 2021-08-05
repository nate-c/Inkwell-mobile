class InvestmentObject {
 
 late int shares;
 late String ticker;
 late int averagePrice;
 late int currentPrice;

 int get _shares {
    return shares;
}

void set _shares (int shares) {
    this.shares = shares;
}

 String get _ticker {
    return ticker;
}

void set _ticker (String ticker) {
    this.ticker = ticker;
} 

int get average_price {
    return averagePrice;
}

void set average_price (int averagePrice) {
    this.averagePrice = averagePrice;
} 

int get current_price {
  return currentPrice;
}

void set current_price (int currentPrice) {
    this.currentPrice = currentPrice;
} 

InvestmentObject() : super();

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