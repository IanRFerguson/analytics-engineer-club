# dbt Packages

* Packages are just dbt projects ... e.g., dbt-utils, codegen, etc.
  * Can contain macros, tests

* Packages fall into one of two categories...
  * Macros / tests packages
  * Packages that contain models for SAS datasets

## Installing packages

* Create a `packages.yml` file in your project
* `hub.getdbt.com` ... find your package and copy / paste into your YAML
* `dbt deps` installs the source code for each package
* You should see the source code in your `dbt_modules` subdirectory

## Tradeoffs

* The actual model logic gets obfuscated since it's git ignored
* Packages can contain logic to handle multiple warehoues, which makes it harder to reason about the code
* Customizing packages is difficult and hard to navigate