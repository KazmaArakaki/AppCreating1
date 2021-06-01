<?php
declare(strict_types=1);

namespace App\Model\Table;

use App\ORM\Table;
use Cake\Validation\Validator;

class LanguagesTable extends Table {
  public function initialize(array $config): void {
    parent::initialize($config);
  }

  public function validationDefault(Validator $validator): Validator {
    $validator
        ->notEmptyString('key', __('言語のキーを入力してください。'));

    $validator
        ->notEmptyString('name', __('言語の名前を入力してください。'));

    return $validator;
  }
}

