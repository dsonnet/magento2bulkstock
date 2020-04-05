# Smartoys PIM connector

Custom configuration for module for Akeneo Magento2 connector.

### Installation

update `composer.json` add:

```
        {
            "type": "vcs",
            "url": "https://github.com/dsonnet/magento2bulkstock.git",
            "branch": "master"
        },

```

to `repositories` key

finally should look ~like:

```
        {
            "type": "composer",
            "url": "https://repo.magento.com/"
        },
        {
            "type": "vcs",
            "url": "https://github.com/Smartoys/AkeneoConnectorFileCollection.git",
            "branch": "master"
        },
        {
            "type": "vcs",
            "url": "https://github.com/dsonnet/magento2bulkstock.git",
            "branch": "master"
        },
        {
            "type": "composer",
            "url": "https://packagist.org"
        },

```

execute 

```composer require "smartoys/bulk-product-update @dev"```

run

```bin/magento setup:upgrade;```

then

```bin/magento setup:di:compile;```

deploy static content (see sections bellow)

### Special Akeneo connector mapping settings

At `Stores -> Configuration -> Catalog (tab) -> Akeneo Connector -> Attributes (tab)` set `Addition types` mapping settings:

`smartoys_catalog_file_collection` -> `textarea`
`pim_catalog_text_collection` -> `pim_catalog_text_collection` -> `textarea`

### Locale configuration notice

Akeneo channel specific locales should be available on Magento side: `en_GB`, `nl_BE`, `fr_BE`, `de_DE`, `es_ES`, `it_IT`, `en_US`

For front, might be done by the following command:

`bin/magento setup:static-content:deploy en_GB de_DE nl_BE fr_BE it_IT en_US`

### Connector commands

Job names used for UI correspond to backend (lowercased), and there are totally 7 import jobs:

* `category`
* `family`
* `attribute`
* `option`
* `productmodel`
* `familyvariant`
* `product`

Import could be started from backend using `akeneo_connector:import` as in the following example:

`bin/magento akeneo_connector:import --code=product`

### Special note

Magento limits media filename to 90 symbols. PIM images with longer names are ignored.
