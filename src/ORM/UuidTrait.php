<?php
declare(strict_types=1);

namespace App\ORM;

use Cake\Datasource\EntityInterface;
use Cake\Event\EventInterface;
use Cake\Utility\Text;
use ArrayObject;

trait UuidTrait {
  public function afterMarshal(EventInterface $event, EntityInterface $entity, ArrayObject $data, ArrayObject $options) {
    if ($entity->isNew()) {
      if (empty($entity['uuid'])) {
        $isEntityExistsWithUuid = true;

        while ($isEntityExistsWithUuid) {
          $entity->set([
            'uuid' => Text::uuid(),
          ]);

          $entityWithUuid = $this->find()
              ->where([
                [$this->aliasField('uuid') => $entity['uuid']],
              ])
              ->first();

          $isEntityExistsWithUuid = !empty($entityWithUuid);
        }
      }
    }
  }
}

