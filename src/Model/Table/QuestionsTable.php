<?php
declare(strict_types=1);

namespace App\Model\Table;

use App\ORM\Table;
use App\ORM\UuidTrait;
use ArrayObject;
use Cake\Datasource\EntityInterface;
use Cake\Event\EventInterface;
use Cake\Validation\Validator;

class QuestionsTable extends Table {
  use UuidTrait {
    afterMarshal as protected afterMarshalOfUuidTrait;
  }

  public function initialize(array $config): void {
    parent::initialize($config);
  }

  public function afterMarshal(EventInterface $event, EntityInterface $entity, ArrayObject $data, ArrayObject $options) {
    $this->afterMarshalOfUuidTrait($event, $entity, $data, $options);
  }

  public function validationDefault(Validator $validator): Validator {
    $validator
        ->notEmptyString('title', __('タイトルを入力してください。'));

    return $validator;
  }
}

