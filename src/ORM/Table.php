<?php
declare(strict_types=1);

namespace App\ORM;

use Cake\ORM\Table as CakeTable;

class Table extends CakeTable {
  use SoftDeleteTrait;

  public function initialize(array $config): void {
    parent::initialize($config);

    $this->addBehavior('Timestamp', [
      'events' => [
        'Model.beforeSave' => [
          'created' => 'new',
          'modified' => 'always',
        ],
      ],
    ]);
  }
}

