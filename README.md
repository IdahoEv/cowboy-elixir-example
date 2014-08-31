CowboyElixirExample
===================

Examples of using the cowboy web server framework in Elixir.  I wrote these because the only other good example I could find was out of date - it had been written before Hex became a thing, and didn't work with current versions of Elixir.

This one is tested to work with:
* Elixir 0.15.1
* Cowboy 1.0.0

Usage:
------------------

Make sure you have elixir >= 0.15.1 installed.  Clone the repo, and change directory to it.  Run the following commands:

    mix deps.get
    mix deps.compile
    iex -S mix

Then open a browser to localhost:8080.

Examples included:
------------------

* Serving static files
* Dynamic HTML (coming soon)
* Accepting a GET request and replying with a JSON object  (coming soon)
* Opening a websocket and pushing a reply to the client periodically (coming soon)


Contributing:
-------------

Pull requests are welcomed.  Since this is an example designed for folks new to both Elixir and Cowboy,
make sure all code is very thoroughly documented, please. :-)

License:
--------

This code is released under the MIT license.  See LICENSE.
