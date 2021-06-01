<?php
declare(strict_types=1);

namespace App\Model\Table;

use App\ORM\Table;

class RequestLogsTable extends Table {
  public function initialize(array $config): void {
    parent::initialize($config);
  }
}

