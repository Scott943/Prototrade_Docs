Common Errors
=============

* Ensure that the Python script is starting using format below. Without the first line below, a :code:`freeze_support` error can occur.

.. code-block:: python

   if __name__ == '__main__': 
      main() # main should contain the code for initalising the StrategyRegistry and registering strategies
   
    