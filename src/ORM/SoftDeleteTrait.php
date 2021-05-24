<?php
declare(strict_types=1);

namespace App\ORM;

use ArrayObject;
use Cake\Datasource\EntityInterface;
use Cake\I18n\Time;
use Cake\ORM\Query;
use Cake\ORM\RulesChecker;
use InvalidArgumentException;

trait SoftDeleteTrait {
  public function query(): Query {
    return new SoftDeleteQuery($this->getConnection(), $this);
  }

  protected function _processDelete(EntityInterface $entity, ArrayObject $options): bool {
    if ($entity->isNew()) {
      return false;
    }

    $primaryKey = (array)$this->getPrimaryKey();

    if (!$entity->has($primaryKey)) {
      throw new InvalidArgumentException('Deleting requires all primary key values.');
    }

    if ($options['checkRules'] && !$this->checkRules($entity, RulesChecker::DELETE, $options)) {
      return false;
    }

    $event = $this->dispatchEvent('Model.beforeDelete', [
      'entity' => $entity,
      'options' => $options
    ]);

    if ($event->isStopped()) {
      return (bool)$event->getResult();
    }

    $this->_associations->cascadeDelete($entity, [
      '_primary' => false,
    ] + $options->getArrayCopy());

    $statement = $this->query()
        ->update()
        ->set([
          'deleted' => Time::now(),
        ])
        ->where((array)$entity->extract($primaryKey))
        ->execute();

    $success = $statement->rowCount() > 0;

    if (!$success) {
      return $success;
    }

    $this->dispatchEvent('Model.afterDelete', [
      'entity' => $entity,
      'options' => $options
    ]);

    return $success;
  }

  public function deleteAll($conditions): int {
    $query = $this->query()
        ->update()
        ->set([
          'deleted' => Time::now(),
        ])
        ->where($conditions + [
          ['deleted IS NULL'],
        ]);

    $statement = $query->execute();

    $statement->closeCursor();

    return $statement->rowCount();
  }
}

