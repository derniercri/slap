# Slap

[![Build Status](https://travis-ci.org/derniercri/slap.svg?branch=master)](https://travis-ci.org/derniercri/slap)

Slap is a load testing tool for developers. 

__Features__

- Real time reporting
- Script scenario with Elixir

__TODO__

- Distribute between several OTP instances
- Integrate script dependencies
- Parse CLI arguments
- Documentation

![Report](https://raw.githubusercontent.com/derniercri/slap/master/doc/bar.png)
![Plot](https://raw.githubusercontent.com/derniercri/slap/master/doc/plot.png)


## Getting started

First of all you have to start the fake server that will handle the traffic.

```
cd examples/api 
mix deps.get
mix phoenix.server
```

Build Slap with the following command
```bash
mix escript.build && chmod +x slap
```

Now you can run the example scenario with the Slap binary.
```
slap examples/scene1.exs
```
