<?php declare(strict_types=1);

namespace SangrossAdapter\ScheduledTask;

use Shopware\Core\Framework\MessageQueue\ScheduledTask\ScheduledTaskHandler;

class ImportProductHandler extends ScheduledTaskHandler
{
    public static function getHandledMessages(): iterable
    {
        return [ ExampleTask::class ];
    }

    public function run(): void
    {
        file_put_contents('/tmp/foobar', 'example');
    }
}
