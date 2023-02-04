
Quickstart
======================================

1. Use ``pip install prototrade -U`` to install the latest version of the package
2. Create a new python file (e.g. ``script.py``) and paste in the `minimal boilerplate strategy <https://scott943.github.io/Prototrade_Docs/_modules/example_strategies/minimal_boilerplate.html#main>`_ .
3. Use ``python3 script.py`` to run the boilerplate code. Refer to the Key Points below for an explanation
4. Look at the :py:mod:`example strategies <example_strategies>` section for more ideas of how the framework operates.


Creating a Strategy
-------------------

Below are the key components needed for creating a strategy. See the `minimal boilerplate strategy <https://scott943.github.io/Prototrade_Docs/_modules/example_strategies/minimal_boilerplate.html#main>`_
for an example.

* Create a strategy function, following the same format as the boilerplate strategy. This should take in an :py:class:`Exchange <prototrade.exchange.exchange.Exchange>` object as its first argument. The :py:class:`Exchange <prototrade.exchange.exchange.Exchange>` parameter is how a strategy can retrieve the latest quotes for subscribed stocks and place orders for symbols. 
* The strategy function can also take in other user defined parameters.
* Subscribe to desired symbols using the :py:meth:`Exchange <prototrade.exchange.exchange.Exchange.subscribe>` member function of the :py:class:`Exchange <prototrade.exchange.exchange.Exchange>` object. 
* Create a while loop that repeatedly checks whether the exchange is running with the member function :code:`is_running`
* Use :py:meth:`get_subscribed_quotes <prototrade.exchange.exchange.Exchange.get_subscribed_quotes>` to get the latest quotes for all the stocks that are subscribed to.
* To submit orders, use the :py:meth:`create_order <prototrade.exchange.exchange.Exchange.create_order>` member function.
* Orders can be cancelled with the :py:meth:`cancel_order <prototrade.exchange.exchange.Exchange.cancel_order>` member function.
* To access historical data use the :py:attr:`Historical Property <prototrade.exchange.exchange.historical>`
* See the :py:class:`Exchange <prototrade.exchange.exchange.Exchange>` for more functions.

Registering Strategies for execution
------------------------------------

* Import the :py:class:`VirtualExchange <prototrade.virtual_exchange.VirtualExchange>`
* In a :code:`main()` function, create an instance of the :py:class:`VirtualExchange <prototrade.virtual_exchange.VirtualExchange>` class
* Use the member function, :py:meth:`register_strategy <prototrade.virtual_exchange.VirtualExchange.register_strategy>` to register a function/strategy to the framework :py:class:`VirtualExchange <prototrade.virtual_exchange.VirtualExchange>` 
* When all strategies are registered, use the member function, :py:meth:`run_strategies <prototrade.virtual_exchange.VirtualExchange.run_strategies>` to start the simulated execution of the strategies.


Common Errors
-------------

* Ensure that the Python script is starting using format below. Otherwise a :code:`freeze_support` error can occur.

::
   if __name__ == '__main__': 
      main()
   
    