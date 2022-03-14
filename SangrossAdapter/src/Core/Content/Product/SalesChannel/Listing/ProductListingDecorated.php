<?php declare(strict_types=1);

namespace SangrossAdapter\Core\Content\Product\SalesChannel\Listing;

use Shopware\Core\Content\Product\SalesChannel\Listing\AbstractProductListingRoute;
use Shopware\Core\Content\Product\SalesChannel\Listing\ProductListingRouteResponse;
use Shopware\Core\Framework\Context;
use Shopware\Core\Framework\DataAbstractionLayer\EntityRepositoryInterface;
use Shopware\Core\Framework\DataAbstractionLayer\Search\Criteria;
use Shopware\Core\Framework\DataAbstractionLayer\Search\EntitySearchResult;
use Shopware\Core\Framework\DataAbstractionLayer\Search\Filter\EqualsFilter;
use Shopware\Core\Framework\DataAbstractionLayer\Search\Filter\RangeFilter;
use Shopware\Core\Framework\DataAbstractionLayer\Search\Sorting\FieldSorting;
use Shopware\Core\System\SalesChannel\SalesChannelContext;
use Shopware\Core\System\SystemConfig\SystemConfigService;
use Symfony\Component\HttpFoundation\Request;
use Psr\Log\LoggerInterface;

class ProductListingDecorated extends AbstractProductListingRoute
{
    private AbstractProductListingRoute $decorated;

    private SystemConfigService $systemConfigService;

    private LoggerInterface $logger;

    public function __construct(
        AbstractProductListingRoute $decorated,
        SystemConfigService $systemConfigService,
        LoggerInterface $logger
    ) {
        $this->decorated = $decorated;
        $this->systemConfigService = $systemConfigService;
        $this->logger = $logger;
    }

    public function getDecorated(): AbstractProductListingRoute
    {
        return $this->decorated;
    }

    public function load(
        string $categoryId,
        Request $request,
        SalesChannelContext $context,
        Criteria $criteria
    ): ProductListingRouteResponse {
        $response = $this->getDecorated()->load($categoryId, $request, $context, $criteria);

        if (!$this->systemConfigService->get('SangrossAdapter.config.enableSearchBox')) {
            return $response;
        }

        $limit = $response->getListingResult()->getCriteria()->getLimit();
        $blogResult = $this->getBlogs($request->get('search'), $limit, $context->getContext());
        $response->getListingResult()->addExtension('blogResult', $blogResult);

        $this->logger->log(Logger::CRITICAL, 'Run ProductListingDecorated, yeehaawww ');
        return $response;
    }

    private function getBlogs(string $term, int $limit, Context $context): EntitySearchResult
    {
	/*
        $criteria = new Criteria();
        $criteria->setTerm($term);
        $criteria->setLimit($limit);
        $criteria->addAssociation('media');
        $criteria->addAssociation('blogCategories');
        $criteria->getAssociation('blogCategories')->addSorting(new FieldSorting('level', FieldSorting::ASCENDING));

        $criteria->addFilter(
            new EqualsFilter('active', true),
            new RangeFilter('publishedAt', [RangeFilter::LTE => (new \DateTime())->format(\DATE_ATOM)])
        );

	return $this->blogRepository->search($criteria, $context);
	 */
	    return [];
    }
}
