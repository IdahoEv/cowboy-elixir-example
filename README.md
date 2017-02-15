Cowboy Elixir Example
===================

Examples of using the [Cowboy web server](http://ninenines.eu/docs/) with [Elixir](http://elixir-lang.org/).  I wrote these because as a newcomer to Elixir I  found the documenation for Cowboy to be inscrutable and difficult: commands often take deep data structures as arguments and those structures are sparsely documented at best.  Also, all the up-to-date examples were in Erlang, rather than Elixir.

My goal here is to show simple usage of the main features of Cowboy, with plenty of documentation, to save others the time I spent puzzling this out.

This is tested to work with:
* Elixir 1.4.x, 1.3.x, 1.2.x, 1.0.x, and  0.15.1 (with edit to dependencies)
* Cowboy 2.0.x

For Cowboy 1.0.x, see the [`cowboy_1`](https://github.com/IdahoEv/cowboy-elixir-example/tree/cowboy_1) branch.

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
* Opening a websocket and pushing a message to the client periodically
* (Planned) Accepting a GET request and replying with a JSON object
* (Planned) Update to Cowboy 2

Contributors:
-------------

* [Marconi Moreto Jr.](https://github.com/marconi)
* [Evan Dorn](https://github.com/idahoev)

Contributing:
-------------

Pull requests are welcomed.  Since this is an example designed for folks new to both Elixir and Cowboy,
make sure all code is very thoroughly documented, please. :)

License:
--------

This code is released under the MIT license.  See LICENSE.
