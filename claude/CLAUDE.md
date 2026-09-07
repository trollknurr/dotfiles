# Project overview

You have MCP tools for python, use them first before grepping the code.
Do not add anything to `__init__.py` files.

Important: 
* try to fix things at the cause, not the symptom.
* Never remove or skip validation because "it will fail later anyway." Errors must be caught as early and as specifically as possible, at the point where the invalid state is first known. Deferring detection obscures the root cause and makes failures harder to diagnose.

# Dependecy management

Project dependecy management is under control of `uv` tools. Useful command collected in `Makefile`

## Run tests

To run tests use `uv run pytest ...`

To spin up infrastructure for tests like db, cache etc, use file `docker/compose/docker-compose-infra.yaml` and convinient command `make infra-up` and `make infra-down`

## Code quality

Formatting: `uv run make format`

Linting: `uv run make lint`


## Project structure

In the root of project there MUST be src directory and tests directory. In src directory MUST be module with the name of the project. In src directory CAN be other modules, for example ml_observability (by the time of writing this document, this package is not yet a separated repository).

All non-library modules MUST follow layout described in next section.

Module layout
Each module, that contains bussiness value (ex. dummy_service), MAY have this sub-modules:

core - module that contains re-usable code parts, such as models, ports, adapters, and services. Also it MUST hold base configuration class.
updater - all offline logic MUST be placed here, ex. train model, prepare datasets, convert models to onnx, etc.
*_service - online api logic MUST be placed here, ex. handling grpc requests for recommendations.
Each submodule MUST have configuration class, that SHOULD inherit base configuration class from core module. Each submodule CAN have one or more entrypoints.

Sub-module layout
Each sub-module MAY have this modules:

port and adapter - this modules MUST contain interfaces (ports) and their implementations (adapters). Adapter should be named as {technology_name}_{port_name}. Internal layout of this modules currently not regulated, flat is preferred. Input and output ports/adapters not separated. Adapters MUST NOT contain any business logic, only technical details (ex. how to get data from database, how to infer model, etc).
model - this module MUST holds classes, that represent business models. Models SHOULD NOT contain business logic, only data and validation rules.
service - this module MUST contain classes, that represent business services. Services MUST contain business logic. Services CAN contain technical details (ex. logging, metrics, etc), but as less as possible. Services MUST operate with models and ports.
config.py - this module MUST contain configuration class, that SHOULD inherits base configuration class from core module.
Entrypoints:

__main__.py - this file MUST contain entrypoint for the module if there is only one.
bin/ - this module MUST contain all modules with entrypoints if there are more than one.
Each entrypoint module MUST contain main function, that can be invoked from command line and imported.

Utils:

utils.py - this module MUST can be only in core module. This module SHOULD contain utility functions, that are used across the project. Utils MUST NOT contain business logic, ex: chunks generator. Utility functions SHOULD be small, focused on one task.
Architecture requirements
This part is collection of important principles, that SHOULD be followed around whole team codebase. Having unified codebase is important for better collaboration and maintenance.

All code MUST be fully typed.
Pydantic models SHOULD be used for any cross-module communication. Using bare dicts should be limited to adequate cases.
All logic MUST be placed in services, even tiny bits.


## Tests

Use pytest. Do not use classes for tests. Every test case should be divided in three parts:
* `Arrange` - setup everything you need in test
* `Act` - call function/class that you check
* `Assert` - check

One function (test case) should contain one `Arrange` block, one `Act` block, one `Assert` block.

If you added or modified test - run it
