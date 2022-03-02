<?php

namespace LigoSangrossAdapter\Bundle\StoreFrontBundle;

use Shopware\Bundle\StoreFrontBundle\Service\ListProductServiceInterface;
use Shopware\Bundle\StoreFrontBundle\Struct\ProductContextInterface;

class ListProductService implements ListProductServiceInterface
{
    private $service;

    public function __construct(ListProductServiceInterface $service)
    {
        $this->service = $service;
    }

    public function getList(array $numbers, ProductContextInterface $context)
    {
        $products = $this->service->getList($numbers, $context);
        //...
        return $products;
    }

    public function get($number, ProductContextInterface $context)
    {
        return array_shift($this->getList([$number], $context));
    }
}
