<?php
declare(strict_types=1);

namespace App\Model\Table;

use App\ORM\Table;
use Cake\Validation\Validator;

class AdministratorsTable extends Table {
  public function initialize(array $config): void {
    parent::initialize($config);
  }

  public function validationDefault(Validator $validator): Validator {
    $validator
        ->notEmptyString('auth_email', __('メールアドレスを入力してください。'));

    $validator
        ->notEmptyString('auth_password', __('ログインパスワードを入力してください。'));

    $validator
        ->notEmptyString('display_name', __('表示名を入力してください。'));

    return $validator;
  }
}

