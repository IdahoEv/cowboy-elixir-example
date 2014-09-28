CowboyElixirExample
===================

Examples of using the [Cowboy web server](http://ninenines.eu/docs/en/cowboy/HEAD/guide/introduction/) with [Elixir](http://elixir-lang.org/).  I wrote these because the only other good example I could find was out of date - it had been written before [Hex](http://hex.pm) became a thing, and didn't work with current versions of Elixir.

This one is tested to work with:
* Elixir 1.0.0  and  0.15.1 (with edit to dependencies)
* Cowboy 1.0.0

Usage:
------------------

Make sure you have elixir >= 1.0.0 installed.  Clone the repo, and change directory to it.  Run the following commands:

    mix deps.get
    mix deps.compile
    iex -S mix

Then open a browser to localhost:8080.

Examples included:
------------------

* Serving static files
* Dynamic HTML with a custom handler
* (Coming Soon) Accepting a GET request and replying with a JSON object 
* (Coming Soon) Opening a websocket and pushing a message to the client periodically 


Contributing:
-------------

Pull requests are welcomed.  Since this is an example designed for folks new to both Elixir and Cowboy,
make sure all code is very thoroughly documented, please. :-)

License:
--------

This code is released under the MIT license.  See LICENSE.
