<?php
namespace Smartoys\BulkProductUpdate\Api;

/**
 * @api
 * @since 101.0.0
 */
interface ProductUpdateManagementInterface
{
    /**
     * Updates the specified products in item array.
     *
     * @api
     * @param mixed $data
     * @return boolean
     */
    public function updateProduct($products);
}
