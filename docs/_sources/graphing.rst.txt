Graphing
========

In-Built Graphing App
-----------------------
To access visualisations of strategy performance, a web app is available
on `localhost:8050 <https://localhost:8050`_ whilst the framework is running.

You can compare the PnL and the Positions held by each strategy. This tool reads
the PnL.csv and Positions.csv files for the respective strategy.

Using pandas and matplotlib
---------------------------
To plot more specific graphs for individual strategies, you can use pandas and matplotlib.

As an example of plotting graphs, we can use pandas and matplotlib:

.. code-block:: python

   import pandas as pd
   import matplotlib.pyplot as plt

To graph data for a particular stock, use the :py:attr:`Historical <prototrade.exchange.exchange.Exchange.historical>` property in the the :py:class:`Exchange <prototrade.exchange.exchange.Exchange>` class.

The following execerpt was taken from the `plotting stock prices <https://scott943.github.io/Prototrade_Docs/_modules/example_strategies/plot_pnl.html#main>`_ example strategy.

.. code-block:: python

   aapl_price_bars = exchange.historical.get_bars("AAPL", "1minute", "2021-01-13", "2021-01-13").df
   # Reformat data (drop multiindex, rename columns, reset index)
   aapl_price_bars.columns = aapl_price_bars.columns.to_flat_index()
   aapl_price_bars.reset_index(inplace=True)

   # Plot stock price data
   plot = aapl_price_bars.plot(x="timestamp", y="close")
   plot.set_xlabel("Date")
   plot.set_ylabel("Apple Close Price ($)")
   plt.savefig("aapl_bars")

.. image:: images/aapl_bars.png
   
To graph profit and loss, you can use the :py:meth:`get_pnl_over_time <prototrade.exchange.exchange.Exchange.get_pnl_over_time>` method.
N.B. this function is expensive, so try to not use this every while loop.

.. code-block:: python

   pnl_over_time = exchange.get_pnl_over_time() # returns a list of lists.  
   if pnl_over_time:
      pnl_df = pd.DataFrame(pnl_over_time, columns = ['timestamp', 'pnl']) # convert to dataframe
      plt.plot(pnl_df['timestamp'], pnl_df['pnl'])
      plt.xlabel("TimeStamp")
      plt.ylabel("Profit / Loss")
      plt.gcf().autofmt_xdate()
      plt.savefig("pnl_for_strategy")

.. image:: images/pnl_for_strategy.png

See `plotting pnl <https://scott943.github.io/Prototrade_Docs/_modules/example_strategies/plot_pnl.html#main>`_ for a complete example of creating PnL graphs.


To graph how positions change over time, use the :py:meth:`get_positions_over_time <prototrade.exchange.exchange.Exchange.get_positions_over_time>` method:

.. code-block:: python

   pos_over_time = exchange.get_positions_over_time("AAPL") # returns a list of lists. 
   if pos_over_time:
      pos_df = pd.DataFrame(pos_over_time, columns = ['timestamp', 'symbol', 'position']) # convert to dataframe
      plt.plot(pos_df['timestamp'], pos_df['position'])
      plt.xlabel("TimeStamp")
      plt.ylabel("AAPL Position Amount")
      plt.gcf().autofmt_xdate()
      plt.savefig("positions_for_strategy")

.. image:: images/positions_for_strategy.png

Like :py:meth:`get_pnl_over_time <prototrade.exchange.exchange.Exchange.get_pnl_over_time>`\ , the :py:meth:`get_positions_over_time <prototrade.exchange.exchange.Exchange.get_positions_over_time>` function
is also expensive, as it reads & parses data from a CSV file.
With a bit more effort, we can plot position data for multiple symbols on the same data. This is particularly useful
when a strategy holds positions over multiple stocks (see `plotting positions multi <https://scott943.github.io/Prototrade_Docs/_modules/example_strategies/plot_positions_multi.html#main>`_\ ).

.. code-block:: python

   pos_over_time = exchange.get_positions_over_time() # retrieves position data on all stocks
   if pos_over_time:
      pos_df = pd.DataFrame(pos_over_time, columns = ['timestamp', 'symbol', 'position']) # convert to dataframe
      fig, ax = plt.subplots()

      for symbol in pos_df['symbol'].unique():
         rows = pos_df[pos_df.symbol==symbol]
         ax.step(rows.timestamp, rows.position,label=symbol)
      
      ax.set_xlabel("TimeStamp")
      ax.set_ylabel("Position Amount")
      ax.legend(loc='best')
      plt.gcf().autofmt_xdate()
      fig.savefig("positions_for_strategy_multi")

.. image:: images/positions_for_strategy_multi.png

Evidently the strategy used to produce the graph above purchases larges amounts of ``AAPL`` stock compared to smaller amounts of ``PLTR`` and ``MSFT``.