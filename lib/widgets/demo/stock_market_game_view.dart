import 'package:flutter/material.dart';
import '../../data/beta_demo_data.dart';

/// Dedicated Stock Market Simulation & Paper Trading screen.
///
/// Features:
/// - ₹10,00,000 Virtual Capital Portfolio Card
/// - Real-time daily P&L and cash reserves
/// - Watchlist with live stock prices, exchanges, and daily change
/// - Instant Buy and Sell simulated trade execution
class StockMarketGameView extends StatefulWidget {
  final double initialBalance;
  final double initialInvested;
  final double initialDayPnL;

  const StockMarketGameView({
    super.key,
    this.initialBalance = 845000.00,
    this.initialInvested = 167450.00,
    this.initialDayPnL = 12450.00,
  });

  @override
  State<StockMarketGameView> createState() => _StockMarketGameViewState();
}

class _StockMarketGameViewState extends State<StockMarketGameView> {
  late double _virtualBalance;
  late double _investedValue;
  late double _dayPnL;
  final double _dayPnLPercent = 1.25;

  @override
  void initState() {
    super.initState();
    _virtualBalance = widget.initialBalance;
    _investedValue = widget.initialInvested;
    _dayPnL = widget.initialDayPnL;
  }

  void _executeTrade(StockEquityModel stock, bool isBuy) {
    const qty = 5;
    final totalTrade = stock.currentPrice * qty;

    if (isBuy) {
      if (_virtualBalance < totalTrade) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Insufficient virtual cash balance.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
      setState(() {
        _virtualBalance -= totalTrade;
        _investedValue += totalTrade;
        _dayPnL += (stock.dayChange * qty);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('BOUGHT $qty shares of ${stock.symbol} at ₹${stock.currentPrice}'),
          backgroundColor: const Color(0xFF00B894),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      setState(() {
        _virtualBalance += totalTrade;
        _investedValue -= totalTrade;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('SOLD $qty shares of ${stock.symbol} at ₹${stock.currentPrice}'),
          backgroundColor: const Color(0xFFFF4757),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  String _formatCurrency(int amount) {
    final str = amount.toString();
    if (str.length <= 3) return str;
    String lastThree = str.substring(str.length - 3);
    String remaining = str.substring(0, str.length - 3);
    String formatted = '';
    while (remaining.length > 2) {
      formatted = ',${remaining.substring(remaining.length - 2)}$formatted';
      remaining = remaining.substring(0, remaining.length - 2);
    }
    return '$remaining$formatted,$lastThree';
  }

  @override
  Widget build(BuildContext context) {
    final totalPortfolio = _virtualBalance + _investedValue;

    return Column(
      key: const ValueKey('stockgame_view'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Portfolio Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF111936), Color(0xFF1E2A54)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00B894).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      '₹10L SIMULATOR',
                      style: TextStyle(
                        color: Color(0xFF00B894),
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'NSE & NASDAQ Real-time',
                    style: TextStyle(color: Color(0xFF8A9FB4), fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text('Total Portfolio Value', style: TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 2),
              Text(
                '₹${_formatCurrency(totalPortfolio.round())}',
                style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.arrow_upward_rounded, color: Color(0xFF00B894), size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '+₹${_formatCurrency(_dayPnL.round())} (+${_dayPnLPercent.toStringAsFixed(2)}%) Today',
                    style: const TextStyle(color: Color(0xFF00B894), fontWeight: FontWeight.w700, fontSize: 12.5),
                  ),
                  const Spacer(),
                  Text(
                    'Cash: ₹${_formatCurrency(_virtualBalance.round())}',
                    style: const TextStyle(color: Colors.white60, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        const Text(
          'Live Market Equities Watchlist',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1B2A56),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Execute instant simulated Buy / Sell trades without financial risk',
          style: TextStyle(fontSize: 12.5, color: Color(0xFF5D7196)),
        ),
        const SizedBox(height: 12),

        ...sampleStocks.map((stock) {
          final isPositive = stock.dayChange >= 0;

          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          stock.symbol,
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1B2A56)),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            stock.exchange,
                            style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: Color(0xFF5D7196)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(stock.companyName, style: const TextStyle(fontSize: 11.5, color: Color(0xFF8A9FB4))),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${stock.currentPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1B2A56)),
                    ),
                    Text(
                      '${isPositive ? "+" : ""}${stock.changePercent.toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: isPositive ? const Color(0xFF00B894) : const Color(0xFFFF4757),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Row(
                  children: [
                    InkWell(
                      onTap: () => _executeTrade(stock, true),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00B894).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Buy',
                          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 11.5, color: Color(0xFF00B894)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    InkWell(
                      onTap: () => _executeTrade(stock, false),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF4757).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Sell',
                          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 11.5, color: Color(0xFFFF4757)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
