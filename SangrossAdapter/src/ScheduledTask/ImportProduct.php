<?php declare(strict_types=1);

namespace SangrossAdapter\ScheduledTask;

use Shopware\Core\Framework\MessageQueue\ScheduledTask\ScheduledTask;

class ImportProduct extends ScheduledTask
{
    public static function getTaskName(): string
    {
        return 'swag.example_task';
    }

    public static function getDefaultInterval(): int
    {
        return 300; // 5 minutes
    }
}
