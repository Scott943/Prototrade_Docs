
Quickstart
======================================

1. Ensure Python 3.8 or higher is installed (use :code:`python3 --version` to check)
2. Use ``pip install prototrade -U`` to install the latest version of the package. 
3. Create a new python file (e.g. ``script.py``) and paste in the `boilerplate strategy <https://scott943.github.io/Prototrade_Docs/_modules/example_strategies/minimal_boilerplate.html#main>`_ .
3. Ensure you have an API username and API key from `Alpaca <https://alpaca.markets/>`\ *
4. Place in your API username and API Key within the initaliser for the :py:class:`StrategyRegistry <prototrade.strategy_registry.StrategyRegistry>` class. 
5. Use ``python3 script.py`` to run the boilerplate code. 

\* Alpaca offers a paid subscription alongside a free plan. The only market available with the free plan is `'iex'`.
With the paid subscription, you can change the market parameter to `'sip'` to receive quotes across all US markets.

Look at the tutorial below and the :py:mod:`Example Strategies <example_strategies>` section for more examples of how the framework operates.

Creating a Strategy Function
----------------------------

Below are the key components needed for creating a strategy, following the same format as the `boilerplate strategy <https://scott943.github.io/Prototrade_Docs/_modules/example_strategies/minimal_boilerplate.html#main>`_ .

* Import the :py:class:`StrategyRegistry <prototrade.strategy_registry.StrategyRegistry>` from :py:mod:`prototrade.strategy_registry` at the top of your python script.
* Define a function that takes an :py:class:`Exchange <prototrade.exchange.exchange.Exchange>` object as its first argument. The :py:class:`Exchange <prototrade.exchange.exchange.Exchange>` parameter is how a strategy can retrieve the latest quotes for subscribed stocks and place orders for symbols. 
* The strategy function can also take as many other arguments as you desire.
* Subscribe to desired symbols (stocks) using the :py:meth:`subscribe <prototrade.exchange.exchange.Exchange.subscribe>` member function of the :py:class:`Exchange <prototrade.exchange.exchange.Exchange>` object. 
* Create a while loop that repeatedly checks whether the exchange is running with the member function :py:meth:`is_running <prototrade.exchange.exchange.Exchange.is_running>`

Retrieving Stock data
---------------------

* To (un)subscribe to particular symbols, use the :py:meth:`subscribe <prototrade.exchange.exchange.Exchange.subscribe>` and :py:meth:`unsubscribe <prototrade.exchange.exchange.Exchange.unsubscribe>` functions from the :py:class:`Exchange <prototrade.exchange.exchange.Exchange>` object.
* Use :py:meth:`get_subscribed_quotes <prototrade.exchange.exchange.Exchange.get_subscribed_quotes>` to get the latest quotes for all the stocks that are subscribed to.
* To access historical data use the :py:attr:`Historical <prototrade.exchange.exchange.Exchange.historical>` property in the :py:class:`Exchange <prototrade.exchange.exchange.Exchange>` class.

Placing Orders
--------------

* To submit orders, use the :py:meth:`create_order <prototrade.exchange.exchange.Exchange.create_order>` member function.
* Orders can be cancelled with the :py:meth:`cancel_order <prototrade.exchange.exchange.Exchange.cancel_order>` member function.
* See the :py:class:`Exchange <prototrade.exchange.exchange.Exchange>` for more available functions.

Registering Strategies for Execution
------------------------------------

* Ensure the :py:class:`StrategyRegistry <prototrade.strategy_registry.StrategyRegistry>` class has been imported
* In the script's :code:`main()` function, create an instance of the :py:class:`StrategyRegistry <prototrade.strategy_registry.StrategyRegistry>` class
* Use the member function, :py:meth:`register_strategy <prototrade.strategy_registry.StrategyRegistry.register_strategy>` to register a function/strategy to the framework
* When all strategies are registered, use the member function, :py:meth:`run_strategies <prototrade.strategy_registry.StrategyRegistry.run_strategies>` to start the simulated execution of the strategies.

Creating Graphs
--------

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
   
To graph PnL, you can use the :py:meth:`subscribe <prototrade.exchange.exchange.Exchange.get_pnl_over_time>` method.
N.B. this function is expensive, so try to not use this every while loop.

The following excerpt is taken from the `plotting pnl <https://scott943.github.io/Prototrade_Docs/_modules/example_strategies/plot_pnl.html#main>`_ example strategy.
