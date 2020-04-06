<?php
namespace Smartoys\BulkProductUpdate\Model;

use Smartoys\BulkProductUpdate\Api\ProductUpdateManagementInterface as ProductApiInterface;
use Magento\Framework\Exception\StateException;

class ProductUpdateManagement implements ProductApiInterface {

    /**
     * @param \Magento\Catalog\Api\ProductRepositoryInterface $productRepository
     */
    public function __construct(
        \Magento\Catalog\Api\ProductRepositoryInterface $productRepository,
        \Psr\Log\LoggerInterface $logger
    ) {
        $this->productRepository = $productRepository;
        $this->logger = $logger;
    }

    /**
     * Updates the specified product from the request payload.
     *
     * @api
     * @param mixed $products
     * @return boolean
     */
    public function updateProduct($products) {
        if (!empty($products)) {
            $error = false;
            $errors = 0;
            foreach ($products as $product) {
                try {
                    if (isset($product['Id'])) {
                        $sku = $product['Id'];
                        $productObject = $this->productRepository->get($sku);
                        if (isset($product['price'])) {
                            $price = $product['price'];
                            $productObject->setPrice($price);
                        }
                        if (isset($product['QtDispo'])) {
                            if (is_numeric($product['QtDispo'])){
                                $qty = $product['QtDispo'];
                            } else {
                                $this->writeLog("Non numeric data for product ".$sku);
                                $qty = 0;
                            }
                            $this->setQtyToProduct($sku, $qty, 'default');
                            if ($qty > 0) {
                                $productObject->setStockData(
                                    [
                                        'is_in_stock' => 1,
                                        'qty' => $qty
                                    ]
                                );
                            } else {
                                $productObject->setStockData(
                                    [
                                        'is_in_stock' => 0,
                                        'qty' => 0
                                    ]);
                            };
                        };
                        try {
                            $this->productRepository->save($productObject);
                        } catch (\Exception $e) {
                            $this->writeLog($product['Id'].' =>'.$e->getMessage());
                            throw new StateException(__('Cannot save product :' . $product['Id']));
                        }
                    }
                } catch (\Magento\Framework\Exception\LocalizedException $e) {
                    $messages[] = $product['Id'].' =>'.$e->getMessage();
                    $error = true;
                    $errors = $errors +1;
                }
            }
            if ($error) {
                $this->writeLog(implode(" || ",$messages));
                return $errors;
            }
        }
        return 0;
    }


    public function setQtyToProduct($sku, $qty, $source)
    {
        $sourceItem = $this->sourceItemFactory->create();
        $sourceItem->setSourceCode($source);
        $sourceItem->setSku($sku);
        $sourceItem->setQuantity($qty);
        if ($qty > 0) {
            $sourceItem->setStatus(1);
        } else {
            $sourceItem->setStatus(0);
        }

        $this->sourceItemsSave->execute([$sourceItem]);
    }
    /* log for an API */
    public function writeLog($log)
    {
        $this->logger->info($log);
    }
}
